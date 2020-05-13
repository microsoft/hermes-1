call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
REM WIN32

call python %~dp0\configure.py --build-system="Visual Studio 16 2019"

pushd build_64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=x64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=x64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=x64
popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --32-bit

pushd build_32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=Win32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=Win32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=Win32
popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --arm 

pushd build_arm_64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=ARM64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=ARM64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=ARM64
popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --arm --32-bit

pushd build_arm_32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=ARM
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=ARM
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=ARM
popd

REM UWP

REM --------------------------------------

setlocal ENABLEDELAYEDEXPANSION

REM link.exe settings
REM Key UWP settings: WindowsApp.lib /APPCONTAINER
REM Debug: /DEBUG:FASTLINK /PDB:<filename>
REM MinSizeRel: /DEBUG:NONE
REM RelWithDebInfo: /DEBUG:FULL /PDB:<filename>

SET CMNOPT=/DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /IMPLIB:hermes.lib /DLL /SUBSYSTEM:CONSOLE /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed
SET UWPOPT=/APPCONTAINER WindowsApp.lib

REM /OPT:REF for reducing image size.
SET DBGOPT=/DEBUG:FASTLINK /PDB:hermes.pdb /OPT:REF /OPT:NOICF

REM /OPT:REF for reducing image size.
SET RELWITHDBGOPT=/DEBUG:FULL /PDB:hermes.pdb /OPT:REF

REM /OPT:REF is default when .DEBUG is off..
SET MINSIZERELOPT=/DEBUG:NONE

set LIBSTEMPLATE=..\lib\Platform\uwp\__FLAVOR__\hermesPlatformUWP.lib ..\API\hermes\__FLAVOR__\hermesapi.lib ..\API\hermes\__FLAVOR__\compileJS.lib ..\jsi\__FLAVOR__\jsi.lib ..\lib\VM\__FLAVOR__\hermesVMRuntime.lib ..\lib\Platform\__FLAVOR__\hermesPlatform.lib ..\lib\BCGen\HBC\__FLAVOR__\hermesHBCBackend.lib ..\lib\BCGen\__FLAVOR__\hermesBackend.lib ..\lib\__FLAVOR__\hermesFrontend.lib ..\lib\Inst\__FLAVOR__\hermesInst.lib ..\lib\__FLAVOR__\hermesOptimizer.lib ..\lib\SourceMap\__FLAVOR__\hermesSourceMap.lib ..\lib\Parser\__FLAVOR__\hermesParser.lib ..\lib\AST\__FLAVOR__\hermesAST.lib ..\lib\ADT\__FLAVOR__\hermesADT.lib ..\lib\Support\__FLAVOR__\hermesSupport.lib ..\lib\Regex\__FLAVOR__\hermesRegex.lib ..\lib\Platform\Unicode\__FLAVOR__\hermesPlatformUnicode.lib ..\lib\FrontEndDefs\__FLAVOR__\hermesFrontEndDefs.lib ..\external\llvh\lib\Support\__FLAVOR__\\LLVHSupport.lib ..\external\llvh\lib\Demangle\__FLAVOR__\LLVHDemangle.lib ..\external\dtoa\__FLAVOR__\dtoa.lib

SET PLATFORMOPT_X64=/MACHINE:X64
SET PLATFORMOPT_X86=/MACHINE:X86
SET PLATFORMOPT_ARM=/MACHINE:ARM
SET PLATFORMOPT_ARM64=/MACHINE:ARM64

set LIBS_Debug=%LIBSTEMPLATE:__FLAVOR__=Debug%
set LIBS_MinSizeRel=%LIBSTEMPLATE:__FLAVOR__=MinSizeRel%
set LIBS_RelWithDebInfo=%LIBSTEMPLATE:__FLAVOR__=RelWithDebInfo%

REM --------------------------------------

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp

pushd build_64_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=x64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=x64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=x64

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" & link.exe %CMNOPT% %PLATFORMOPT_X64% %UWPOPT% %RELWITHDBGOPT% %LIBS_RelWithDebInfo%"
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" & link.exe %CMNOPT% %PLATFORMOPT_X64% %UWPOPT% %MINSIZERELOPT% %LIBS_MinSizeRel%"
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" & link.exe %CMNOPT% %PLATFORMOPT_X64% %UWPOPT% %DBGOPT% %LIBS_Debug%"
popd

popd


call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp --32-bit

pushd build_32_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=Win32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=Win32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=Win32

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars32.bat" & link.exe %CMNOPT% %PLATFORMOPT_X86% %UWPOPT% %RELWITHDBGOPT% %LIBS_RelWithDebInfo%"
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars32.bat" & link.exe %CMNOPT% %PLATFORMOPT_X86% %UWPOPT% %MINSIZERELOPT% %LIBS_MinSizeRel%"
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars32.bat" & link.exe %CMNOPT% %PLATFORMOPT_X86% %UWPOPT% %DBGOPT% %LIBS_Debug%"
popd

popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp --arm

pushd build_arm_64_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=ARM64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=ARM64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=ARM64

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" & link.exe %CMNOPT% %PLATFORMOPT_ARM64% %UWPOPT% %RELWITHDBGOPT% %LIBS_RelWithDebInfo%"
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" & link.exe %CMNOPT% %PLATFORMOPT_ARM64% %UWPOPT% %MINSIZERELOPT% %LIBS_MinSizeRel%"
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" & link.exe %CMNOPT% %PLATFORMOPT_ARM64% %UWPOPT% %DBGOPT% %LIBS_Debug%"
popd

popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp --arm --32-bit

pushd build_arm_32_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=ARM
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=ARM
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=ARM

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm.bat" & link.exe %CMNOPT% %PLATFORMOPT_ARM% %UWPOPT% %RELWITHDBGOPT% %LIBS_RelWithDebInfo%"
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm.bat" & link.exe %CMNOPT% %PLATFORMOPT_ARM% %UWPOPT% %MINSIZERELOPT% %LIBS_MinSizeRel%"
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm.bat" & link.exe %CMNOPT% %PLATFORMOPT_ARM% %UWPOPT% %DBGOPT% %LIBS_Debug%"
popd

popd

