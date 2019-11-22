@echo off
set d=%cd%
set bd=build

if not exist %d%/%bd% (
   mkdir "%d%/%bd%"
)

cd %d%/%bd%

cmake -DCMAKE_BUILD_TYPE=%cmake_bt% ^
      -DCMAKE_CXX_COMPILER:PATH="C:\Program Files\LLVM\bin\clang-cl.exe" ^
      -DCMAKE_C_COMPILER:PATH="C:\Program Files\LLVM\bin\clang-cl.exe" ^
      -DCMAKE_LINKER:PATH="C:\Program Files\LLVM\bin\lld-link.exe" ^
      -G "Visual Studio 16 2019" ^
      -A X64 ^
      ..

if errorlevel 1 (
   echo "Failed to configure"
   exit
)

cmake --build . 
