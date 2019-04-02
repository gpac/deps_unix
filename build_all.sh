#!/bin/sh

ARCH="linux"
PLAT_ARCH="x86-unknown-linux"
JP2=""

if [ "$1" = "osx" ]; then
	ARCH="osx"
	PLAT_ARCH="universal-apple-macosx"
	JP2="osx"
fi


cd PlatinumSDK/
./BuildAndCopy2Public.sh "$PLAT_ARCH"
cd ..

cd avcap
./BuildAndCopy2Public.sh "$ARCH"
cd ..


./build_opensvc_static.sh "$ARCH"


./build_openhevc_static.sh "$ARCH"


cd js
make -f Makefile.ref Linux_All_DBG.OBJ/libjs.a
cp -av Linux_All_DBG.OBJ/libjs.a ../../gpac_public/extra_lib/lib/gcc/
cd ..


cd OpenJPEG
make $JP2
cp libopenjpeg.a ../../gpac_public/extra_lib/lib/gcc/
cd ..

