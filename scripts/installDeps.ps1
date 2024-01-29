#!/bin/pwsh

if (test-path ".\deps\v-master") {
    rm -Recurse -Force ".\deps\v-master"
}
.\deps\cosmocc-bin\curl.exe -sSLfo ".\deps\vlang.zip" "https://github.com/vlang/v/archive/refs/heads/master.zip"
.\deps\cosmocc-bin\unzip.exe ".\deps\vlang.zip" -d "./deps"
if (test-path ".\deps\vlang.zip") {
    rm -Recurse -Force ".\deps\vlang.zip"
}

cd ".\deps\v-master"
.\make.bat
cd ".\..\.."
