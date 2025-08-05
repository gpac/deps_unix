#!/bin/sh -x

echo "Compilation of OpenHEVC"

branch="ffmpeg_update"

#git submodule update --init

cd ./openHEVC/

git checkout --force "$branch"
git fetch
git reset --hard FETCH_HEAD

git apply ../patches/effadce6c756247ea8bae32dc13bb3e6f464f0eb.patch

if [ "$2" = "rebuild" ] || [ ! -f ffbuild/config.mak ] ; then

  make clean
  ./configure --disable-debug --disable-iconv --enable-pic --extra-cflags="-Wno-attributes -Wno-array-bounds"

fi

make openhevc-static || exit 1


mkdir -p ../../gpac_public/extra_lib/include/libopenhevc
cp ./libopenhevc/*.h ../../gpac_public/extra_lib/include/libopenhevc

mkdir -p ../../gpac_public/extra_lib/lib/gcc
cp ./libopenhevc/libopenhevc.a ../../gpac_public/extra_lib/lib/gcc
cd ..
