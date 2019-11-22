cmake_minimum_required(VERSION 3.4)
project(cmakefun C CXX)

set(CMAKE_CXX_STANDARD 14)
set(base_dir ${CMAKE_CURRENT_LIST_DIR}/)
set(cubeb_install_dir ${CMAKE_CURRENT_BINARY_DIR}/cubeb-installed/)
set(filament_install_dir ${CMAKE_CURRENT_BINARY_DIR}/filament-installed/)
set(filament_lib_dir ${filament_install_dir}/lib/x86_64)

include(ExternalProject)

if (UNIX)
  
  ExternalProject_Add(
    filament
    GIT_REPOSITORY https://github.com/google/filament.git
    GIT_SHALLOW 1
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${filament_install_dir} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DENABLE_JAVA=OFF
    )
  
else()
  
  ExternalProject_Add(
    filament
    GIT_REPOSITORY https://github.com/google/filament.git
    GIT_SHALLOW 1
    CMAKE_ARGS  -T "LLVM" -DCMAKE_INSTALL_PREFIX=${filament_install_dir} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DENABLE_JAVA=OFF
    )
  
endif()

message(FATAL_ERROR "--- ${CMAKE_CXX_COMPILER} ---")

ExternalProject_Add(
  cb
  GIT_REPOSITORY https://github.com/kinetiknz/cubeb.git
  GIT_SHALLOW 1
  UPDATE_COMMAND ""
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${cubeb_install_dir} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
  )

include_directories(${base_dir})
list(APPEND my_sources ${base_dir}/MyLib.cpp)
add_library(mylib STATIC ${my_sources})

add_executable(test-mylib ${base_dir}/test-mylib.cpp)
add_dependencies(test-mylib mylib filament cb)
target_link_libraries(test-mylib mylib ${cubeb_install_dir}/lib/libcubeb.a ${filament_lib_dir}/libfilament.a)


