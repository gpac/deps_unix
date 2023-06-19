#!/bin/sh -x

echo "Compilation of OpenHEVC"

branch="ffmpeg_update"

cd ./openHEVC/

git checkout --force "$branch"
git fetch
git reset --hard FETCH_HEAD

make clean
./configure --disable-debug --disable-iconv
make openhevc-shared || exit 1


mkdir -p ../../gpac_public/extra_lib/include/libopenhevc
cp ./libopenhevc/*.h ../../gpac_public/extra_lib/include/libopenhevc

mkdir -p ../../gpac_public/bin/gcc
if [ -f ./libopenhevc/libopenhevc.so ]; then
	cp -af ./libopenhevc/libopenhevc.so* ../../gpac_public/bin/gcc
fi
if [ -f ./libopenhevc/libopenhevc.dylib ]; then
        cp -af ./libopenhevc/libopenhevc*.dylib ../../gpac_public/bin/gcc
fi
cd ..
