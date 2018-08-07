#!/bin/sh -x

echo "Compilation of OpenHEVC"

branch="ffmpeg_update"

git submodule update --init

cd ./openhevc/

git checkout --force "$branch"
git fetch
git reset --hard FETCH_HEAD

make clean
./configure --disable-debug --disable-iconv
make openhevc-static || exit 1

mkdir -p ../../gpac_public/extra_lib/lib/gcc
cp ./libopenhevc/libopenhevc.a ../../gpac_public/extra_lib/lib/gcc
cd ..

