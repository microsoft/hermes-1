param(
    [string]$SourcesPath = $PSScriptRoot,
    [string]$OutputPath = "$PSScriptRoot\out",
    [ValidateSet("x64", "x86", "arm", "arm64")]
    [String[]]$Platform = @("x64"),
    [ValidateSet("debug", "release")]
    [String[]]$Configuration = @("debug"),
    [ValidateSet("win32", "uwp")]
    [String[]]$AppPlatform = ("win32", "uwp"),
    [switch]$ToolsBuild,
    [switch]$CompilerBuild,
    [switch]$DllBuild,
    [switch]$TestBuild
)

function Find-Path($exename) {
    $v = (get-command $exename -ErrorAction SilentlyContinue)
    if ($v.Path) {
        return $v.Path
    }
    else {
        throw "Could not find $exename"
    }
}

function Find-VS-Path() {
    $vsWhere = (get-command "vswhere.exe" -ErrorAction SilentlyContinue)
    if ($vsWhere) {
        $vsWhere = $vsWhere.Path
    }
    else {
        $vsWhere = "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" 
    }

    if (Test-Path $vsWhere) {
        $versionJson = & $vsWhere -format json 
        $versionJson = & $vsWhere -format json -version 16
        $versionJson = $versionJson | ConvertFrom-Json 
    } else {
        $versionJson = @()
    }

    if ($versionJson.Length -gt 1) { Write-Warning 'More than one VS install detected, picking the first one'; $versionJson = $versionJson[0]; }

    if ($versionJson.installationPath) {
        $vcVarsPath = "$($versionJson.installationPath)\VC\Auxiliary\Build\vcvarsall.bat"
        if (Test-Path $vcVarsPath) {
            return $vcVarsPath
        } else {
            throw "Could not find vcvarsall.bat at expected Visual Studio installation path"
            throw "Could not find vcvarsall.bat at expected Visual Studio installation path: $vcVarsPath"
        }
    } else {
        throw "Could not find Visual Studio installation path"
    }
}

function Get-VCVarsParam($plat = "x64", $arch = "win32") {
    $args = switch ($plat)
    {
        "x64" {"x64"}
        "x86" {"x64_x86"}
        "arm" {"x64_arm"}
        "arm64" {"x64_arm64"}
        default { "x64" }
    }

    if ($arch -eq "uwp") {
        $args = "$args uwp"
    }

    return $args
}

function Get-CMakeConfiguration($config) {
    $val = switch ($config)
    {
        "debug" {"Debug"}
        "release" {"MinSizeRel"}
        default {"Debug"}
    }

    return $val
}

function Invoke-Environment($Command, $arg) {
    $Command = "`"" + $Command + "`" " + $arg
    Write-Host "Running command [ $Command ]"
    cmd /c "$Command && set" | . { process {
        if ($_ -match '^([^=]+)=(.*)') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
        }
    }}
}

function Run-Build($SourcesPath, $OutputPath, $Platform, $Configuration, $AppPlatform) {
    $Triplet = "$AppPlatform-$Platform-$Configuration"

    Write-Host "Building $Triplet..."

    $CompilerPath =Join-Path $SourcesPath "build\hermesc"
    if ($CompilerBuild.IsPresent) {
        $buildPath = $CompilerPath
    } else {
        $buildPath = Join-Path $SourcesPath "build\$Triplet"
    }
    
    $skipBuild = $False

    if(!$skipBuild) {
        if ((Test-Path -Path $buildPath)) {
            Remove-Item $buildPath -Recurse -ErrorAction Ignore
        }

        New-Item -ItemType "directory" -Path $buildPath | Out-Null
    }

    Push-Location $buildPath

    if(!$skipBuild) {
        $genArgs = @('-G')
        $genArgs += 'Ninja'

        $genArgs += ('-DPYTHON_EXECUTABLE={0}' -f $PYTHON_PATH)
        $genArgs += ('-DCMAKE_BUILD_TYPE={0}' -f (Get-CMakeConfiguration $Configuration))
        $genArgs += '-DHERMES_ENABLE_DEBUGGER=On'
        $genArgs += '-HERMESVM_PLATFORM_LOGGING=On'
       
        if ($CompilerBuild.IsPresent) {
            if (Test-Path -Path $CompilerPath) {
                Remove-Item $CompilerPath -Recurse -ErrorAction Ignore
            }

            New-Item -ItemType "directory" -Path $CompilerPath | Out-Null
            Push-Location $CompilerPath
        }

        if ($AppPlatform -eq "uwp") {
            $genArgs += '-DCMAKE_CXX_STANDARD=17'
            $genArgs += '-DCMAKE_SYSTEM_NAME=WindowsStore'
            $genArgs += '-DCMAKE_SYSTEM_VERSION="10.0.15063"'
            $genArgs += "-DIMPORT_HERMESC=$CompilerPath\ImportHermesc.cmake"
        }
        
        $genCall = ('cmake {0}' -f ($genArgs -Join ' ')) + " $SourcesPath";

        Write-Host $genCall

        $ninjaCmd = "ninja"
            
        if ($ToolsBuild.IsPresent) {
            $ninjaCmd = $ninjaCmd + " hermes"
        }
        
        if ($DllBuild.IsPresent) {
            $ninjaCmd = $ninjaCmd + " libhermes"
        }
        
        if ($TestBuild.IsPresent) {
            $ninjaCmd = $ninjaCmd + " check-hermes"
        }

        if ($CompilerBuild.IsPresent) {
            $ninjaCmd = $ninjaCmd + " hermesc"
        }

        # else build everything


        # See https://developercommunity.visualstudio.com/content/problem/257260/vcvarsallbat-reports-the-input-line-is-too-long-if.html
        $Bug257260 = $false

        if ($Bug257260) {
            Invoke-Environment $VCVARS_PATH (Get-VCVarsParam $Platform $AppPlatform)
            Invoke-Expression $genCall
            ninja $ninjaCmd
        } else {
            cmd /c "`"$VCVARS_PATH`" $(Get-VCVarsParam $Platform $AppPlatform) && $genCall 2>&1 && ${ninjaCmd}"
        }

        if ($CompilerBuild.IsPresent) {
            Pop-Location
        }
    }
    

    # Now copy the needed build outputs        
    if ($DllBuild.IsPresent) {
        if (!(Test-Path -Path "$OutputPath\lib\$AppPlatform\$Configuration\$Platform")) {
            New-Item -ItemType "directory" -Path "$OutputPath\lib\$AppPlatform\$Configuration\$Platform" | Out-Null
        }

        Copy-Item "$buildPath\API\hermes\hermes.dll" -Destination "$OutputPath\lib\$AppPlatform\$Configuration\$Platform"
        Copy-Item "$buildPath\API\hermes\hermes.lib" -Destination "$OutputPath\lib\$AppPlatform\$Configuration\$Platform"
    }

    if ($ToolsBuild.IsPresent) {
        $toolsPath = "$OutputPath\tools\$Configuration\$Platform"
        if (!(Test-Path -Path $toolsPath)) {
            New-Item -ItemType "directory" -Path $toolsPath | Out-Null
        }
    
        Copy-Item "$buildPath\bin\hermes.exe" -Destination $toolsPath
    }

    Pop-Location
}

$VCVARS_PATH = Find-VS-Path
$PYTHON_PATH = Find-Path "python.exe"
$CMAKE_PATH = Find-Path "cmake.exe"

$StartTime = (Get-Date)

# first copy the headers into the output
if (!(Test-Path -Path "$OutputPath\build\native\include\hermes")) {
    New-Item -ItemType "directory" -Path "$OutputPath\build\native\include\hermes" | Out-Null
}

if (!(Test-Path -Path "$OutputPath\build\native\include\jsi")) {
    New-Item -ItemType "directory" -Path "$OutputPath\build\native\include\jsi" | Out-Null
}

Copy-Item "$SourcesPath\API\jsi\jsi\*" -Destination "$OutputPath\build\native\include\jsi" -force -Recurse
Copy-Item "$SourcesPath\API\hermes\hermes.h" -Destination "$OutputPath\build\native\include\hermes" -force
Copy-Item "$SourcesPath\API\hermes\DebuggerAPI.h" -Destination "$OutputPath\build\native\include\hermes" -force
Copy-Item "$SourcesPath\public\hermes\*" -Destination "$OutputPath\build\native\include\hermes" -force -Recurse

# run the actual builds

foreach ($Plat in $Platform) {
    foreach ($Config in $Configuration) {
        foreach ($AppPlat in $AppPlatform) {
            Run-Build -SourcesPath $SourcesPath -OutputPath $OutputPath -Platform $Plat -Configuration $Config -AppPlatform $AppPlat
        }
    }
}

# copy misc files for NuGet to pick up
if (!(Test-Path -Path "$OutputPath\license")) {
    New-Item -ItemType "directory" -Path "$OutputPath\license" | Out-Null
}

Copy-Item "$SourcesPath\LICENSE" -Destination "$OutputPath\license\" -force 
Copy-Item "$SourcesPath\ReactNative.Hermes.Windows.targets" -Destination "$OutputPath\build\native\" -force

# process version information

$gitRevision = ((git rev-parse --short HEAD) | Out-String).Trim()

$npmPackage = (Get-Content (Join-Path $SourcesPath "npm\package.json") | Out-String | ConvertFrom-Json).version

(Get-Content "$SourcesPath\ReactNative.Hermes.Windows.nuspec") -replace ('VERSION_DETAILS', "Hermes version: $npmPackage; Git revision: $gitRevision") | Set-Content "$OutputPath\ReactNative.Hermes.Windows.nuspec"

$npmPackage | Set-Content "$OutputPath\version"

$elapsedTime = $(get-date) - $StartTime

$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)

Write-Host "Build took $totalTime to run"