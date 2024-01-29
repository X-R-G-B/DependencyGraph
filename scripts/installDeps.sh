#!/bin/sh

# Install dependencies

# rm -rf "./deps/cosmocc"
# ./deps/cosmocc-bin/curl.exe -sSLfo "./deps/cosmocc.zip" "https://cosmo.zip/pub/cosmocc/cosmocc.zip"
# ./deps/cosmocc-bin/unzip.exe "./deps/cosmocc.zip" -d "./deps/cosmocc"
# rm "./deps/cosmocc.zip"

rm -rf "./deps/v-master"
./deps/cosmocc-bin/curl.exe -sSLfo "./deps/vlang.zip" "https://github.com/vlang/v/archive/refs/heads/master.zip"
./deps/cosmocc-bin/unzip.exe "./deps/vlang.zip" -d "./deps"
rm "./deps/vlang.zip"

./deps/cosmocc-bin/make.exe \
    -C "./deps/v-master"
