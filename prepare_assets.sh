#!/usr/bin/env bash
# Собирает стандартную структуру Android-проекта из плоских файлов и встраивает библиотеки.
set -euo pipefail
M=app/src/main
mkdir -p $M/java/com/sofa/slasher $M/assets/lib $M/res/values $M/res/drawable $M/res/mipmap-anydpi-v26
mv AndroidManifest.xml $M/
mv MainActivity.java $M/java/com/sofa/slasher/
mv styles.xml $M/res/values/
mv ic_bg.xml ic_fg.xml $M/res/drawable/
mv ic_launcher.xml $M/res/mipmap-anydpi-v26/
mv app_build.gradle app/build.gradle
mv index.html $M/assets/index.html
A=$M/assets
curl -fsSL https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js -o $A/lib/three.min.js
curl -fsSL https://cdn.jsdelivr.net/npm/peerjs@1.5.4/dist/peerjs.min.js -o $A/lib/peerjs.min.js
curl -fsSL https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/GLTFLoader.js -o $A/lib/GLTFLoader.js
curl -fsSL https://threejs.org/examples/models/gltf/ferrari.glb -o $A/lib/ferrari.glb
sed -i \
 -e 's#https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js#lib/three.min.js#' \
 -e 's#https://cdn.jsdelivr.net/npm/peerjs@1.5.4/dist/peerjs.min.js#lib/peerjs.min.js#' \
 -e 's#https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/GLTFLoader.js#lib/GLTFLoader.js#' \
 -e 's#https://threejs.org/examples/models/gltf/ferrari.glb#lib/ferrari.glb#' \
 $A/index.html
echo ready
