#!/usr/bin/env bash

# Print errors with line number and failing command
trap 'echo "[ERROR] Command failed at line $LINENO: $BASH_COMMAND"; exit 1' ERR

# Exit if undefined variable is used
set -u
# Fail on pipeline errors
set -o pipefail


# Detect or override compilers
: "${CC:=mpicc}"
: "${CXX:=mpicxx}"

echo "[Build] Using CC=$CC, CXX=$CXX"


# Step 1: Build CombBLAS
cd CombBLAS
rm -rf _build
mkdir -p _build
cd _build
cmake .. -DCMAKE_C_COMPILER="$CC" -DCMAKE_CXX_COMPILER="$CXX"
make -j


echo
echo "[Build] Done. Executables are in ./build and library objects in CombBLAS/_build"

