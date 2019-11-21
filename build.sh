#!/bin/sh

d=${PWD}

if [ ! -d ${d}/build ] ; then
    cd ${d}
    mkdir build
fi

cd ${d}
cd build

cmake -DCMAKE_CXX_COMPILER="/usr/bin/clang++" \
      -DCMAKE_C_COMPILER="/usr/bin/clang" \
      ..

if [ $? -ne 0 ] ; then
    echo "Failed to configure."
    exit
fi

cmake --build . 

if [ $? -ne 0 ] ; then
    echo "Failed to build."
    exit
fi

./test-mylib
