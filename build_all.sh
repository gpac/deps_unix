#!/bin/sh

ARCH="$1"


./build_opensvc_static.sh "$ARCH"


./build_openhevc_static.sh "$ARCH"

./build_libcaption_static.sh "$ARCH"

./build_mpegh_static.sh  "$ARCH"  || true

bash ./build_h3libs.sh  "$ARCH"
