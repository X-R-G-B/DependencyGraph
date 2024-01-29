#!/bin/sh

# Install dependencies

# rm -rf "./deps/cosmocc"
# ./deps/cosmocc-bin/curl.exe -sSLfo "./deps/cosmocc.zip" "https://cosmo.zip/pub/cosmocc/cosmocc.zip"
# ./deps/cosmocc-bin/unzip.exe "./deps/cosmocc.zip" -d "./deps/cosmocc"
# rm "./deps/cosmocc.zip"

CURL="./deps/cosmocc-bin/curl.exe"
UNZIP="./deps/cosmocc-bin/unzip.exe"
MAKE="./deps/cosmocc-bin/make.exe"

rm -rf "./deps/v-master"
if [ "$1" == "useSystem" ]; then
    CURL="curl"
    UNZIP="unzip"
    MAKE="make"
fi

$CURL -sSLfo "./deps/vlang.zip" "https://github.com/vlang/v/archive/refs/heads/master.zip"
$UNZIP "./deps/vlang.zip" -d "./deps"

$MAKE \
    -C "./deps/v-master"

rm "./deps/vlang.zip"
