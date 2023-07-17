#!/bin/sh -x

echo "Compilation of mpeghdec"

branch="main"

cd ./mpeghdec/

git checkout --force "$branch"
git fetch
git reset --hard FETCH_HEAD


sed -i'.bak' -e 's/git@github.com:/https:\/\/github.com\//'  CMakeLists.txt

mkdir -p build

cat << EOF > build/toolchain.cmake
set(CMAKE_CXX_FLAGS "\${CMAKE_CXX_FLAGS} -fPIC" )
set(CMAKE_C_FLAGS   "\${CMAKE_C_FLAGS} -fPIC" )
EOF

cmake --build build --target clean || true
cmake -S . -B build  -DCMAKE_TOOLCHAIN_FILE=build/toolchain.cmake   -DCMAKE_BUILD_TYPE=Release -Dmpeghdec_BUILD_BINARIES=OFF -Dmpeghdec_BUILD_DOC=OFF
cmake --build build --parallel 4


mkdir -p ../../gpac_public/extra_lib/include
cp -av include/mpeghdecoder.h ../../gpac_public/extra_lib/include/

mkdir -p ../../gpac_public/extra_lib/lib/gcc
cp -av build/lib/lib*.a ../../gpac_public/extra_lib/lib/gcc/


cd ..
