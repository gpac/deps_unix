#!/bin/sh

cd opensvc/svcsvn/
svn revert -R .
patch -p0 < ../gpac_bb.patch

is_64=`uname -a | grep 64`

if test ! -z "$is_64" ; then
echo "64 bit compilation of OpenSVC"
cmake -DCMAKE_C_FLAGS=-fPIC .
else
echo "32 bit compilation of OpenSVC"
cmake .
fi

make || exit 1
mkdir temp
cp SVC/lib_svc/CMakeFiles/SVC_baseline.dir/*.o temp/
mv temp/slice_data_cabac.c.o temp/slice_data_cabac_svc.c.o
cp AVC/h264_baseline_decoder/lib_baseline/CMakeFiles/AVC_baseline.dir/*.o temp/
cp AVC/h264_main_decoder/lib_main/CMakeFiles/AVC_main.dir/*.o temp/
cp CommonFiles/src/CMakeFiles/OpenSVCDec.dir/*.o temp/
ar cr libOpenSVCDec.a temp/*.o
ranlib libOpenSVCDec.a
rm -rf temp
mkdir -p ../../../gpac_public/extra_lib/lib/gcc
cp libOpenSVCDec.a ../../../gpac_public/extra_lib/lib/gcc
cd ..



