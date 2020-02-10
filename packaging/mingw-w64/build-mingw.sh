#!/bin/bash
#
# Build librdkafka with a MinGW cross-compler Docker image.
#
# Statically linked
# WITHOUT  openssl, zlib
# WITHOUT libsasl2, lz4(ext, using builtin instead)
#
# Usage (from top-level librdkafka dir):
#   docker run -it -v $PWD:/v microsoft/dotnet:2-sdk /v/packaging/tools/build-debian.sh /v /v/librdkafka-debian9.tgz
#


set -ex

LRK_DIR=$1
OUT_TGZ=$2

if [[ ! -f $LRK_DIR/configure.self || -z $OUT_TGZ ]]; then
    echo "Usage: $0 <librdkafka-root-direcotry> <output-tgz>"
    exit 1
fi

set -u

apt-get update
apt-get install -y git-core make cmake gcc-mingw-w64-base binutils-mingw-w64-x86-64 gcc-mingw-w64-x86-64 gcc-mingw-w64 g++-mingw-w64-x86-64


# Copy the librdkafka git archive to a new location to avoid messing
# up the librdkafka working directory.

BUILD_DIR=$(mktemp -d)

pushd $BUILD_DIR

DEST_DIR=$PWD/dest
mkdir -p $DEST_DIR

(cd $LRK_DIR ; git archive --format tar HEAD) | tar xf -

cmake -B$DEST_DIR -H$BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$BUILD_DIR/packaging/mingw-w64/mingw_toolchain.cmake \
      -DMINGW_BUILD:BOOL=ON \
      -DWITHOUT_WIN32_CONFIG:BOOL=ON \
      -DRDKAFKA_BUILD_EXAMPLES:BOOL=ON \
      -DRDKAFKA_BUILD_TESTS:BOOL=ON \
      -DWITH_LIBDL:BOOL=OFF \
      -DWITH_PLUGINS:BOOL=OFF \
      -DWITH_SASL:BOOL=OFF \
      -DWITH_SSL:BOOL=OFF \
      -DWITH_ZLIB:BOOL=OFF \
      -DRDKAFKA_BUILD_STATIC:BOOL=OFF \
      -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS:BOOL=TRUE

pushd $DEST_DIR
make -j2

# Tar up the output directory
rm -rf CMakeFiles
find . -type f \( -name "*.exe" -o -name "*.dll*" \) | tar cvzf $OUT_TGZ -T -

popd # $DEST_DIR

popd # $BUILD_DIR

rm -rf "$BUILD_DIR"
