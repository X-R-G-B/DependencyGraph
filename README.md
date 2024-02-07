# DependencyGraph

Get [d2](https://github.com/terrastruct/d2) config file from source code
imports

## Install

## Binary (precompiled)

Go to the latest release and download the binary for your platform

### Build (from source)

- Linux/Macos

```bash
./scripts/installDeps.sh
./deps/v-master/v run ./scripts/build.vsh
./dg --help
```

- Windows

```powershell
.\scripts\installDeps.ps1
.\deps\v-master\v run .\scripts\build.vsh
.\dg --help
```

## Usage

```bash
dg --help
```
```
./dg 0.0.0
-----------------------------------------------
Usage: ./dg [options] [FOLDERS]

Description: output d2 dependency graph

Options:
  -l, --language <string>   Language to use for the folders
  -o, --output <string>     Output file
  -h, --help                display this help and exit
```
