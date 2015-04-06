#!/usr/bin/env bash

DISPLAY_VERSION=1.0.0
PACKAGE_VERSION=1.0-1

# setup
mkdir --parents ./dist
rm -r ./dist/*

# create distribution for Linux
echo "Creating Linux portable archive"
output=./dist/linux64
rm -rf "$output/"
mkdir "$output"
cp -r ./resources/ "$output/"
cp -r ./node_modules/ "$output/"
cp ./package.json "$output/"
cp ./nwjs/linux64/nw "$output/polonium"
sed -i 's/udev\.so\.0/udev.so.1/g' "$output/polonium" # fix an issue on recent Ubuntu/Fedora/etc. versions where libudev backward compatibility is broken (https://github.com/nwjs/nw.js/wiki/The-solution-of-lacking-libudev.so.0)
cp ./nwjs/linux64/nw.pak "$output/"
cp ./nwjs/linux64/libffmpegsumo.so "$output/"
cp ./nwjs/linux64/icudtl.dat "$output/"
zip -r "./dist/Polonium $DISPLAY_VERSION Linux 64-bit.zip" ./dist/linux64/* > /dev/null

# create Ubuntu/Debian DEB archive
echo "Creating Debian package"
base_path=./dist/deb #polonium-$PACKAGE_VERSION
installed_size=$(du --summarize "$output" | cut -f1)
mkdir --parents "$base_path/DEBIAN/" # set up package control file
echo -e "Package: polonium\nVersion: $PACKAGE_VERSION"            > "$base_path/DEBIAN/control"
echo -e "Section: base\nPriority: optional\nArchitecture: amd64" >> "$base_path/DEBIAN/control"
echo "Depends: npm, nodejs, nodejs-legacy" >> "$base_path/DEBIAN/control"
echo "Maintainer: Anthony Zhang <azhang9@gmail.com>"             >> "$base_path/DEBIAN/control"
echo "Homepage: https://github.com/Uberi/polonium#readme"        >> "$base_path/DEBIAN/control"
echo "Installed-Size: $installed_size"                           >> "$base_path/DEBIAN/control"
echo -e "Description: Polonium\n Polonium is a better desktop Facebook chat client, with resizable chat windows, desktop notifications, and more." >> "$base_path/DEBIAN/control"
mkdir --parents "$base_path/usr/bin" # set up launcher script
echo -e "#!/usr/bin/env bash\n/opt/polonium/polonium" > "$base_path/usr/bin/polonium"
chmod +x "$base_path/usr/bin/polonium"
mkdir --parents "$base_path/usr/share/applications" # set up menu shortcuts
echo -e "[Desktop Entry]\nType=Application\nName=Polonium\nComment=Facebook Chat Client\nExec=polonium\nIcon=polonium" > "$base_path/usr/share/applications/polonium.desktop"
chmod +x "$base_path/usr/share/applications/polonium.desktop"
mkdir --parents "$base_path/usr/share/pixmaps" # set up icons
cp ./resources/icon.png "$base_path/usr/share/pixmaps/polonium.png"
mkdir --parents "$base_path/opt/polonium" # set up program files
cp -r ./dist/linux64/* "$base_path/opt/polonium/"
sleep 3 # wait for the files to stop changing, seems to be necessary on some machines
fakeroot dpkg --build "$base_path" "./dist/Polonium $DISPLAY_VERSION Linux 64-bit.deb"

# create distribution for Windows
echo "Creating Windows portable archive"
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
zip -r "./dist/Polonium $DISPLAY_VERSION Windows 64-bit.zip" ./dist/windows64/* > /dev/null

# clean up temp directories
rm -r ./dist/linux64/
rm -r ./dist/deb
rm -r ./dist/windows64/