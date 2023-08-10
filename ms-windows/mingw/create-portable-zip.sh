#!/bin/bash

DISTROOT=build_mingw64/dist/usr/x86_64-w64-mingw32/sys-root/mingw
DEBUGROOT=dist_debug
for file in $(find $DISTROOT -name '*.debug' \( -type l -or -type f \)); do
    DEST=${file/$DISTROOT/$DEBUGROOT}
    mkdir -p "$(dirname $DEST)"
    sudo mv "$file" "$DEST"
done
sudo mv $DISTROOT QGIS-Portable
zip -r qgis-portable-win64.zip QGIS-Portable
(cd $DEBUGROOT && zip -r - *) > qgis-portable-win64-debugsym.zip
