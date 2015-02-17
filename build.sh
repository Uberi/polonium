#!/usr/bin/env bash

PACKAGE=./dist/polonium.nw

# create ZIP archive for distribution
mkdir --parents ./dist
zip -r "$PACKAGE" ./polonium/*

# create distribution for Linux
output=./dist/linux64
rm -rf "$output/"
mkdir "$output"
cp -r ./resources/ "$output/"
cp -r ./node_modules/ "$output/"
cp ./package.json "$output/"
cp ./nwjs/linux64/nw "$output/polonium"
cp ./nwjs/linux64/nw.pak "$output/"
cp ./nwjs/linux64/libffmpegsumo.so "$output/"
cp ./nwjs/linux64/icudtl.dat "$output/"

# create distribution for Windows
output=./dist/windows64
rm -rf "$output/"
mkdir "$output"
cp -r ./resources/ "$output/"
cp -r ./node_modules/ "$output/"
cp ./package.json "$output/"
cp ./nwjs/windows64/nw.exe "$output/polonium.exe"
cp ./nwjs/windows64/nw.pak "$output/"
cp ./nwjs/windows64/*.dll "$output/"
cp ./nwjs/windows64/icudtl.dat "$output/"
