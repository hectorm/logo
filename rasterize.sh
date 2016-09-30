#!/usr/bin/env bash

# Author:   Héctor Molinero Fernández <hector@molinero.xyz>
# License:  MIT, https://opensource.org/licenses/MIT

# Exit on errors
set -eu

# Globals
scriptDir=$(dirname "$(readlink -f "$0")")
buildDir="$scriptDir/build"
commonArgs='--without-gui'
logoArgs="$commonArgs $scriptDir/ZNT_logo.svg"
faviconArgs="$commonArgs $scriptDir/ZNT_favicon.svg"
backgroundArgs="-b #ECEFF1"

# Process:
cd "$scriptDir"
rm -rf "$buildDir"
mkdir "$buildDir"

inkscape $logoArgs                    -w 4096 -h 4096 -e "$buildDir"/ZNT_x4096_logo.png
inkscape $logoArgs    $backgroundArgs -w 4096 -h 4096 -e "$buildDir"/ZNT_x4096_logo_background.png

inkscape $logoArgs                    -w 2048 -h 2048 -e "$buildDir"/ZNT_x2048_logo.png
inkscape $logoArgs    $backgroundArgs -w 2048 -h 2048 -e "$buildDir"/ZNT_x2048_logo_background.png

inkscape $logoArgs                    -w 1024 -h 1024 -e "$buildDir"/ZNT_x1024_logo.png
inkscape $logoArgs    $backgroundArgs -w 1024 -h 1024 -e "$buildDir"/ZNT_x1024_logo_background.png

inkscape $logoArgs                    -w 1024 -h 1024 -e "$buildDir"/ZNT_x1024_logo_moremargin.png            -a '-96:-96:1120:1120'
inkscape $logoArgs    $backgroundArgs -w 1024 -h 1024 -e "$buildDir"/ZNT_x1024_logo_moremargin_background.png -a '-96:-96:1120:1120'

inkscape $logoArgs                    -w 512  -h 512  -e "$buildDir"/ZNT_x512_logo.png
inkscape $logoArgs    $backgroundArgs -w 512  -h 512  -e "$buildDir"/ZNT_x512_logo_background.png

inkscape $logoArgs                    -w 460  -h 460  -e "$buildDir"/ZNT_x460_logo.png
inkscape $logoArgs    $backgroundArgs -w 460  -h 460  -e "$buildDir"/ZNT_x460_logo_background.png

inkscape $logoArgs                    -w 256  -h 256  -e "$buildDir"/ZNT_x256_logo.png
inkscape $logoArgs    $backgroundArgs -w 256  -h 256  -e "$buildDir"/ZNT_x256_logo_background.png

inkscape $faviconArgs                 -w 192  -h 192  -e "$buildDir"/ZNT_x192_favicon.png
inkscape $faviconArgs $backgroundArgs -w 192  -h 192  -e "$buildDir"/ZNT_x192_favicon_background.png

inkscape $faviconArgs                 -w 62   -h 62   -e "$buildDir"/ZNT_x62_favicon.png
inkscape $faviconArgs $backgroundArgs -w 62   -h 62   -e "$buildDir"/ZNT_x62_favicon_background.png

inkscape $faviconArgs                 -w 48   -h 48   -e "$buildDir"/ZNT_x48_favicon.png
inkscape $faviconArgs $backgroundArgs -w 48   -h 48   -e "$buildDir"/ZNT_x48_favicon_background.png

inkscape $faviconArgs                 -w 32   -h 32   -e "$buildDir"/ZNT_x32_favicon.png
inkscape $faviconArgs $backgroundArgs -w 32   -h 32   -e "$buildDir"/ZNT_x32_favicon_background.png

inkscape $faviconArgs                 -w 16   -h 16   -e "$buildDir"/ZNT_x16_favicon.png
inkscape $faviconArgs $backgroundArgs -w 16   -h 16   -e "$buildDir"/ZNT_x16_favicon_background.png

mat "$buildDir"/*.png

