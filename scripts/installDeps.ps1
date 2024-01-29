#!/bin/pwsh

rm -Recurse -Force "./deps/v-master"
.\deps\cosmocc-bin\curl.exe -sSLfo ".\deps\vlang.zip" "https://github.com/vlang/v/archive/refs/heads/master.zip"
.\deps\cosmocc-bin\unzip.exe ".\deps\vlang.zip" -d "./deps"
rm -Force ".\deps\vlang.zip"

cd ".\deps\v-master"
.\make.bat
cd ".\..\.."
