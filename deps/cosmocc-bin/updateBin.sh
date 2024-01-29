#!/bin/sh

download() {
    PACK="$1"
    URL="https://cosmo.zip/pub/cosmos/bin/$PACK"
    DESTTMP="deps/cosmocc-bin/$PACK-tmp"
    DEST="deps/cosmocc-bin/$PACK.exe"
    ./deps/cosmocc-bin/curl.exe -sSLfo "$DESTTMP" "$URL"
    mv "$DESTTMP" "$DEST"
    chmod +x "$DEST"
}

chmod +x "deps/cosmocc-bin/curl.exe"

download "curl"
download "unzip"
download "make"
