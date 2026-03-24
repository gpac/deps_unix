#!/bin/sh

./build_opensvc_static.sh $@


./build_openhevc_static.sh $@

./build_libcaption_static.sh $@

./build_mpegh_static.sh  $@  || true
