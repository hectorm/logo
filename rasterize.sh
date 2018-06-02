#!/bin/sh

# Author:     Héctor Molinero Fernández <hector@molinero.xyz>
# Repository: https://github.com/hectorm/logo

# Exit on errors
set -eu

# Globals
scriptDir=$(dirname "$(readlink -f "$0")")
buildDir="$scriptDir/bitmap"

# Process:
main() {
	cd "$scriptDir"
	rm -rf "$buildDir"
	mkdir "$buildDir"

	for i in $(seq 0 "$(jq '.vectors|length-1' build.json)"); do
		name=$(jq -r ".vectors[$i].name" build.json)
		file=$(jq -r ".vectors[$i].file" build.json)
		background=$(jq -r ".vectors[$i].background" build.json)
		margin=$(jq -r ".vectors[$i].margin" build.json)

		for j in $(seq 0 "$(jq ".vectors[$i].sizes|length-1" build.json)"); do
			size=$(jq ".vectors[$i].sizes[$j]" build.json)

			inkscape --without-gui \
				-w "$size" -h "$size" \
				-e "$buildDir/${name}_x${size}.png" \
				"$file"

			inkscape --without-gui \
				-w "$size" -h "$size" \
				-b "$background" \
				-e "$buildDir/${name}_background_x${size}.png" \
				"$file"

			if [ "$margin" != "null" ]; then
				inkscape --without-gui \
					-w "$size" -h "$size" \
					-a "$margin" \
					-e "$buildDir/${name}_margin_x${size}.png" \
					"$file"

				inkscape --without-gui \
					-w "$size" -h "$size" \
					-b "$background" \
					-a "$margin" \
					-e "$buildDir/${name}_background_margin_x${size}.png" \
					"$file"
			fi
		done
	done
}

main

