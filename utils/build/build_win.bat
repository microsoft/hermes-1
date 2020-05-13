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

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp

pushd build_64_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=x64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=x64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=x64

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:X64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\RelWithDebInfo\hermesPlatformUWP.lib" "..\API\hermes\RelWithDebInfo\hermesapi.lib" "..\API\hermes\RelWithDebInfo\compileJS.lib" "..\jsi\RelWithDebInfo\jsi.lib" "..\lib\VM\RelWithDebInfo\hermesVMRuntime.lib" "..\lib\Platform\RelWithDebInfo\hermesPlatform.lib" "..\lib\BCGen\HBC\RelWithDebInfo\hermesHBCBackend.lib" "..\lib\BCGen\RelWithDebInfo\hermesBackend.lib" "..\lib\RelWithDebInfo\hermesFrontend.lib" "..\lib\Inst\RelWithDebInfo\hermesInst.lib" "..\lib\RelWithDebInfo\hermesOptimizer.lib" "..\lib\SourceMap\RelWithDebInfo\hermesSourceMap.lib" "..\lib\Parser\RelWithDebInfo\hermesParser.lib" "..\lib\AST\RelWithDebInfo\hermesAST.lib" "..\lib\ADT\RelWithDebInfo\hermesADT.lib" "..\lib\Support\RelWithDebInfo\hermesSupport.lib" "..\lib\Regex\RelWithDebInfo\hermesRegex.lib" "..\lib\Platform\Unicode\RelWithDebInfo\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\RelWithDebInfo\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\RelWithDebInfo\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\RelWithDebInfo\LLVHDemangle.lib" "..\external\dtoa\RelWithDebInfo\dtoa.lib""
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:X64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\MinSizeRel\hermesPlatformUWP.lib" "..\API\hermes\MinSizeRel\hermesapi.lib" "..\API\hermes\MinSizeRel\compileJS.lib" "..\jsi\MinSizeRel\jsi.lib" "..\lib\VM\MinSizeRel\hermesVMRuntime.lib" "..\lib\Platform\MinSizeRel\hermesPlatform.lib" "..\lib\BCGen\HBC\MinSizeRel\hermesHBCBackend.lib" "..\lib\BCGen\MinSizeRel\hermesBackend.lib" "..\lib\MinSizeRel\hermesFrontend.lib" "..\lib\Inst\MinSizeRel\hermesInst.lib" "..\lib\MinSizeRel\hermesOptimizer.lib" "..\lib\SourceMap\MinSizeRel\hermesSourceMap.lib" "..\lib\Parser\MinSizeRel\hermesParser.lib" "..\lib\AST\MinSizeRel\hermesAST.lib" "..\lib\ADT\MinSizeRel\hermesADT.lib" "..\lib\Support\MinSizeRel\hermesSupport.lib" "..\lib\Regex\MinSizeRel\hermesRegex.lib" "..\lib\Platform\Unicode\MinSizeRel\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\MinSizeRel\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\MinSizeRel\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\MinSizeRel\LLVHDemangle.lib" "..\external\dtoa\MinSizeRel\dtoa.lib""
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:X64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\Debug\hermesPlatformUWP.lib" "..\API\hermes\Debug\hermesapi.lib" "..\API\hermes\Debug\compileJS.lib" "..\jsi\Debug\jsi.lib" "..\lib\VM\Debug\hermesVMRuntime.lib" "..\lib\Platform\Debug\hermesPlatform.lib" "..\lib\BCGen\HBC\Debug\hermesHBCBackend.lib" "..\lib\BCGen\Debug\hermesBackend.lib" "..\lib\Debug\hermesFrontend.lib" "..\lib\Inst\Debug\hermesInst.lib" "..\lib\Debug\hermesOptimizer.lib" "..\lib\SourceMap\Debug\hermesSourceMap.lib" "..\lib\Parser\Debug\hermesParser.lib" "..\lib\AST\Debug\hermesAST.lib" "..\lib\ADT\Debug\hermesADT.lib" "..\lib\Support\Debug\hermesSupport.lib" "..\lib\Regex\Debug\hermesRegex.lib" "..\lib\Platform\Unicode\Debug\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\Debug\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\Debug\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\Debug\LLVHDemangle.lib" "..\external\dtoa\Debug\dtoa.lib""
popd

popd


call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp --32-bit

pushd build_32_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=Win32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=Win32
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=Win32

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars32.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:X64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\RelWithDebInfo\hermesPlatformUWP.lib" "..\API\hermes\RelWithDebInfo\hermesapi.lib" "..\API\hermes\RelWithDebInfo\compileJS.lib" "..\jsi\RelWithDebInfo\jsi.lib" "..\lib\VM\RelWithDebInfo\hermesVMRuntime.lib" "..\lib\Platform\RelWithDebInfo\hermesPlatform.lib" "..\lib\BCGen\HBC\RelWithDebInfo\hermesHBCBackend.lib" "..\lib\BCGen\RelWithDebInfo\hermesBackend.lib" "..\lib\RelWithDebInfo\hermesFrontend.lib" "..\lib\Inst\RelWithDebInfo\hermesInst.lib" "..\lib\RelWithDebInfo\hermesOptimizer.lib" "..\lib\SourceMap\RelWithDebInfo\hermesSourceMap.lib" "..\lib\Parser\RelWithDebInfo\hermesParser.lib" "..\lib\AST\RelWithDebInfo\hermesAST.lib" "..\lib\ADT\RelWithDebInfo\hermesADT.lib" "..\lib\Support\RelWithDebInfo\hermesSupport.lib" "..\lib\Regex\RelWithDebInfo\hermesRegex.lib" "..\lib\Platform\Unicode\RelWithDebInfo\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\RelWithDebInfo\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\RelWithDebInfo\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\RelWithDebInfo\LLVHDemangle.lib" "..\external\dtoa\RelWithDebInfo\dtoa.lib""
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars32.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:X64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\MinSizeRel\hermesPlatformUWP.lib" "..\API\hermes\MinSizeRel\hermesapi.lib" "..\API\hermes\MinSizeRel\compileJS.lib" "..\jsi\MinSizeRel\jsi.lib" "..\lib\VM\MinSizeRel\hermesVMRuntime.lib" "..\lib\Platform\MinSizeRel\hermesPlatform.lib" "..\lib\BCGen\HBC\MinSizeRel\hermesHBCBackend.lib" "..\lib\BCGen\MinSizeRel\hermesBackend.lib" "..\lib\MinSizeRel\hermesFrontend.lib" "..\lib\Inst\MinSizeRel\hermesInst.lib" "..\lib\MinSizeRel\hermesOptimizer.lib" "..\lib\SourceMap\MinSizeRel\hermesSourceMap.lib" "..\lib\Parser\MinSizeRel\hermesParser.lib" "..\lib\AST\MinSizeRel\hermesAST.lib" "..\lib\ADT\MinSizeRel\hermesADT.lib" "..\lib\Support\MinSizeRel\hermesSupport.lib" "..\lib\Regex\MinSizeRel\hermesRegex.lib" "..\lib\Platform\Unicode\MinSizeRel\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\MinSizeRel\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\MinSizeRel\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\MinSizeRel\LLVHDemangle.lib" "..\external\dtoa\MinSizeRel\dtoa.lib""
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars32.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:X64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\Debug\hermesPlatformUWP.lib" "..\API\hermes\Debug\hermesapi.lib" "..\API\hermes\Debug\compileJS.lib" "..\jsi\Debug\jsi.lib" "..\lib\VM\Debug\hermesVMRuntime.lib" "..\lib\Platform\Debug\hermesPlatform.lib" "..\lib\BCGen\HBC\Debug\hermesHBCBackend.lib" "..\lib\BCGen\Debug\hermesBackend.lib" "..\lib\Debug\hermesFrontend.lib" "..\lib\Inst\Debug\hermesInst.lib" "..\lib\Debug\hermesOptimizer.lib" "..\lib\SourceMap\Debug\hermesSourceMap.lib" "..\lib\Parser\Debug\hermesParser.lib" "..\lib\AST\Debug\hermesAST.lib" "..\lib\ADT\Debug\hermesADT.lib" "..\lib\Support\Debug\hermesSupport.lib" "..\lib\Regex\Debug\hermesRegex.lib" "..\lib\Platform\Unicode\Debug\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\Debug\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\Debug\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\Debug\LLVHDemangle.lib" "..\external\dtoa\Debug\dtoa.lib""
popd

popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp --arm

pushd build_arm_64_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=ARM64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=ARM64
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=ARM64

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:ARM64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\RelWithDebInfo\hermesPlatformUWP.lib" "..\API\hermes\RelWithDebInfo\hermesapi.lib" "..\API\hermes\RelWithDebInfo\compileJS.lib" "..\jsi\RelWithDebInfo\jsi.lib" "..\lib\VM\RelWithDebInfo\hermesVMRuntime.lib" "..\lib\Platform\RelWithDebInfo\hermesPlatform.lib" "..\lib\BCGen\HBC\RelWithDebInfo\hermesHBCBackend.lib" "..\lib\BCGen\RelWithDebInfo\hermesBackend.lib" "..\lib\RelWithDebInfo\hermesFrontend.lib" "..\lib\Inst\RelWithDebInfo\hermesInst.lib" "..\lib\RelWithDebInfo\hermesOptimizer.lib" "..\lib\SourceMap\RelWithDebInfo\hermesSourceMap.lib" "..\lib\Parser\RelWithDebInfo\hermesParser.lib" "..\lib\AST\RelWithDebInfo\hermesAST.lib" "..\lib\ADT\RelWithDebInfo\hermesADT.lib" "..\lib\Support\RelWithDebInfo\hermesSupport.lib" "..\lib\Regex\RelWithDebInfo\hermesRegex.lib" "..\lib\Platform\Unicode\RelWithDebInfo\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\RelWithDebInfo\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\RelWithDebInfo\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\RelWithDebInfo\LLVHDemangle.lib" "..\external\dtoa\RelWithDebInfo\dtoa.lib""
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:ARM64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\MinSizeRel\hermesPlatformUWP.lib" "..\API\hermes\MinSizeRel\hermesapi.lib" "..\API\hermes\MinSizeRel\compileJS.lib" "..\jsi\MinSizeRel\jsi.lib" "..\lib\VM\MinSizeRel\hermesVMRuntime.lib" "..\lib\Platform\MinSizeRel\hermesPlatform.lib" "..\lib\BCGen\HBC\MinSizeRel\hermesHBCBackend.lib" "..\lib\BCGen\MinSizeRel\hermesBackend.lib" "..\lib\MinSizeRel\hermesFrontend.lib" "..\lib\Inst\MinSizeRel\hermesInst.lib" "..\lib\MinSizeRel\hermesOptimizer.lib" "..\lib\SourceMap\MinSizeRel\hermesSourceMap.lib" "..\lib\Parser\MinSizeRel\hermesParser.lib" "..\lib\AST\MinSizeRel\hermesAST.lib" "..\lib\ADT\MinSizeRel\hermesADT.lib" "..\lib\Support\MinSizeRel\hermesSupport.lib" "..\lib\Regex\MinSizeRel\hermesRegex.lib" "..\lib\Platform\Unicode\MinSizeRel\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\MinSizeRel\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\MinSizeRel\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\MinSizeRel\LLVHDemangle.lib" "..\external\dtoa\MinSizeRel\dtoa.lib""
popd


mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm64.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:ARM64 WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\Debug\hermesPlatformUWP.lib" "..\API\hermes\Debug\hermesapi.lib" "..\API\hermes\Debug\compileJS.lib" "..\jsi\Debug\jsi.lib" "..\lib\VM\Debug\hermesVMRuntime.lib" "..\lib\Platform\Debug\hermesPlatform.lib" "..\lib\BCGen\HBC\Debug\hermesHBCBackend.lib" "..\lib\BCGen\Debug\hermesBackend.lib" "..\lib\Debug\hermesFrontend.lib" "..\lib\Inst\Debug\hermesInst.lib" "..\lib\Debug\hermesOptimizer.lib" "..\lib\SourceMap\Debug\hermesSourceMap.lib" "..\lib\Parser\Debug\hermesParser.lib" "..\lib\AST\Debug\hermesAST.lib" "..\lib\ADT\Debug\hermesADT.lib" "..\lib\Support\Debug\hermesSupport.lib" "..\lib\Regex\Debug\hermesRegex.lib" "..\lib\Platform\Unicode\Debug\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\Debug\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\Debug\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\Debug\LLVHDemangle.lib" "..\external\dtoa\Debug\dtoa.lib""
popd


popd
popd

call python %~dp0\configure.py --build-system="Visual Studio 16 2019" --uwp --arm --32-bit

pushd build_arm_32_uwp
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=RelWithDebInfo /p:Platform=ARM
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=Debug  /p:Platform=ARM
MSBuild.exe ALL_BUILD.vcxproj /p:Configuration=MinSizeRel  /p:Platform=ARM

mkdir uwp_dll_relwithdbg & pushd uwp_dll_relwithdbg
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:ARM WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\RelWithDebInfo\hermesPlatformUWP.lib" "..\API\hermes\RelWithDebInfo\hermesapi.lib" "..\API\hermes\RelWithDebInfo\compileJS.lib" "..\jsi\RelWithDebInfo\jsi.lib" "..\lib\VM\RelWithDebInfo\hermesVMRuntime.lib" "..\lib\Platform\RelWithDebInfo\hermesPlatform.lib" "..\lib\BCGen\HBC\RelWithDebInfo\hermesHBCBackend.lib" "..\lib\BCGen\RelWithDebInfo\hermesBackend.lib" "..\lib\RelWithDebInfo\hermesFrontend.lib" "..\lib\Inst\RelWithDebInfo\hermesInst.lib" "..\lib\RelWithDebInfo\hermesOptimizer.lib" "..\lib\SourceMap\RelWithDebInfo\hermesSourceMap.lib" "..\lib\Parser\RelWithDebInfo\hermesParser.lib" "..\lib\AST\RelWithDebInfo\hermesAST.lib" "..\lib\ADT\RelWithDebInfo\hermesADT.lib" "..\lib\Support\RelWithDebInfo\hermesSupport.lib" "..\lib\Regex\RelWithDebInfo\hermesRegex.lib" "..\lib\Platform\Unicode\RelWithDebInfo\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\RelWithDebInfo\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\RelWithDebInfo\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\RelWithDebInfo\LLVHDemangle.lib" "..\external\dtoa\RelWithDebInfo\dtoa.lib""
popd

mkdir uwp_dll_minsizerel & pushd uwp_dll_minsizerel
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:ARM WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\MinSizeRel\hermesPlatformUWP.lib" "..\API\hermes\MinSizeRel\hermesapi.lib" "..\API\hermes\MinSizeRel\compileJS.lib" "..\jsi\MinSizeRel\jsi.lib" "..\lib\VM\MinSizeRel\hermesVMRuntime.lib" "..\lib\Platform\MinSizeRel\hermesPlatform.lib" "..\lib\BCGen\HBC\MinSizeRel\hermesHBCBackend.lib" "..\lib\BCGen\MinSizeRel\hermesBackend.lib" "..\lib\MinSizeRel\hermesFrontend.lib" "..\lib\Inst\MinSizeRel\hermesInst.lib" "..\lib\MinSizeRel\hermesOptimizer.lib" "..\lib\SourceMap\MinSizeRel\hermesSourceMap.lib" "..\lib\Parser\MinSizeRel\hermesParser.lib" "..\lib\AST\MinSizeRel\hermesAST.lib" "..\lib\ADT\MinSizeRel\hermesADT.lib" "..\lib\Support\MinSizeRel\hermesSupport.lib" "..\lib\Regex\MinSizeRel\hermesRegex.lib" "..\lib\Platform\Unicode\MinSizeRel\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\MinSizeRel\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\MinSizeRel\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\MinSizeRel\LLVHDemangle.lib" "..\external\dtoa\MinSizeRel\dtoa.lib""
popd

mkdir uwp_dll_debug & pushd uwp_dll_debug
cmd /c ""C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsamd64_arm.bat" & link.exe /DEF:..\..\src\lib\platform\uwp\hermes.def /OUT:hermes.dll /PDB:hermes.pdb /IMPLIB:hermes.lib /DLL /MACHINE:ARM WindowsApp.lib /SUBSYSTEM:CONSOLE /APPCONTAINER /WINMD:NO /DYNAMICBASE /NXCOMPAT /MANIFEST:NO /DEBUG:FASTLINK "..\lib\Platform\uwp\Debug\hermesPlatformUWP.lib" "..\API\hermes\Debug\hermesapi.lib" "..\API\hermes\Debug\compileJS.lib" "..\jsi\Debug\jsi.lib" "..\lib\VM\Debug\hermesVMRuntime.lib" "..\lib\Platform\Debug\hermesPlatform.lib" "..\lib\BCGen\HBC\Debug\hermesHBCBackend.lib" "..\lib\BCGen\Debug\hermesBackend.lib" "..\lib\Debug\hermesFrontend.lib" "..\lib\Inst\Debug\hermesInst.lib" "..\lib\Debug\hermesOptimizer.lib" "..\lib\SourceMap\Debug\hermesSourceMap.lib" "..\lib\Parser\Debug\hermesParser.lib" "..\lib\AST\Debug\hermesAST.lib" "..\lib\ADT\Debug\hermesADT.lib" "..\lib\Support\Debug\hermesSupport.lib" "..\lib\Regex\Debug\hermesRegex.lib" "..\lib\Platform\Unicode\Debug\hermesPlatformUnicode.lib" "..\lib\FrontEndDefs\Debug\hermesFrontEndDefs.lib" "..\external\llvh\lib\Support\Debug\\LLVHSupport.lib" "..\external\llvh\lib\Demangle\Debug\LLVHDemangle.lib" "..\external\dtoa\Debug\dtoa.lib""
popd

popd

