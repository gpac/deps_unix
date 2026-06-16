#!/bin/bash -xe


echo "Building nghttp3"

pushd nghttp3

autoreconf -i
./configure  --enable-static=yes --enable-shared=no --enable-lib-only=yes --with-pic=yes --prefix=$(pwd)/build/
make -j4
make install

popd


echo "Building ngtcp2"

pushd ngtcp2

autoreconf -i
./configure PKG_CONFIG_PATH=$(pwd)/../nghttp3/build/lib/pkgconfig --with-gnutls --enable-static=yes --enable-shared=no -enable-lib-only=yes --with-pic=yes --prefix=$(pwd)/build
make -j4 check
make install

popd


echo "Copying libs and includes"

cp -av nghttp3/build/include/nghttp3 ../gpac_public/extra_lib/include/
cp -av ngtcp2/build/include/ngtcp2 ../gpac_public/extra_lib/include/

cp -av nghttp3/build/lib/libnghttp3* ../gpac_public/extra_lib/lib/gcc/
cp -av ngtcp2/build/lib/libngtcp2* ../gpac_public/extra_lib/lib/gcc/


echo "All done."
