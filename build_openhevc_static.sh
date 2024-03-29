#!/bin/sh -x

echo "Compilation of OpenHEVC"

branch="ffmpeg_update"

#git submodule update --init

cd ./openHEVC/

git checkout --force "$branch"
git fetch
git reset --hard FETCH_HEAD

if [ "$2" = "rebuild" ] || [ ! -f ffbuild/config.mak ] ; then

  make clean
  ./configure --disable-debug --disable-iconv --enable-pic

fi

make openhevc-static || exit 1


mkdir -p ../../gpac_public/extra_lib/include/libopenhevc
cp ./libopenhevc/*.h ../../gpac_public/extra_lib/include/libopenhevc

mkdir -p ../../gpac_public/extra_lib/lib/gcc
cp ./libopenhevc/libopenhevc.a ../../gpac_public/extra_lib/lib/gcc
cd ..
