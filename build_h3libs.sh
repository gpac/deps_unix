#!/bin/bash -xe

echo "Building quictls"

pushd openssl

./config enable-tls1_3 enable-quic no-shared --prefix=$(pwd)/build/ --libdir=lib
make -j4
make install_sw

popd


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
./configure PKG_CONFIG_PATH=$(pwd)/../openssl/build/lib/pkgconfig:$(pwd)/../nghttp3/build/lib/pkgconfig --with-openssl --enable-static=yes --enable-shared=no -enable-lib-only=yes --with-pic=yes --prefix=$(pwd)/build
make -j4 check
make install

popd


echo "Copying libs and includes"

cp -av openssl/build/include/openssl ../gpac_public/extra_lib/include/
cp -av nghttp3/build/include/nghttp3 ../gpac_public/extra_lib/include/
cp -av ngtcp2/build/include/ngtcp2 ../gpac_public/extra_lib/include/

cp -av openssl/build/lib/lib* ../gpac_public/extra_lib/lib/gcc/
cp -av nghttp3/build/lib/libnghttp3* ../gpac_public/extra_lib/lib/gcc/
cp -av ngtcp2/build/lib/libngtcp2* ../gpac_public/extra_lib/lib/gcc/


echo "All done."
