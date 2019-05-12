#!/bin/sh

# Author:     Héctor Molinero Fernández <hector@molinero.dev>
# Repository: https://github.com/hectorm/logo

set -eu

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
TARGET_DIR="${SCRIPT_DIR}/bitmap"

main() {
	rm -rf "${TARGET_DIR}"
	mkdir -p "${TARGET_DIR}"

	for i in $(seq 0 "$(jq '.vectors|length-1' "${SCRIPT_DIR}/build.json")"); do
		name=$(jq       -r --arg i "${i}" '.vectors[$i|tonumber].name' "${SCRIPT_DIR}/build.json")
		file=$(jq       -r --arg i "${i}" '.vectors[$i|tonumber].file' "${SCRIPT_DIR}/build.json")
		background=$(jq -r --arg i "${i}" '.vectors[$i|tonumber].background' "${SCRIPT_DIR}/build.json")
		margin=$(jq     -r --arg i "${i}" '.vectors[$i|tonumber].margin' "${SCRIPT_DIR}/build.json")
		totalSizes=$(jq -r --arg i "${i}" '.vectors[$i|tonumber].sizes|length-1' "${SCRIPT_DIR}/build.json")

		for j in $(seq 0 "${totalSizes}"); do
			size=$(jq -r --arg i "${i}" --arg j "${j}" '.vectors[$i|tonumber].sizes[$j|tonumber]' "${SCRIPT_DIR}/build.json")

			inkscape --without-gui \
				-w "${size}" -h "${size}" \
				-e "${TARGET_DIR}/${name}_x${size}.png" \
				"${SCRIPT_DIR}/${file}"

			inkscape --without-gui \
				-w "${size}" -h "${size}" \
				-b "${background}" \
				-e "${TARGET_DIR}/${name}_background_x${size}.png" \
				"${SCRIPT_DIR}/${file}"

			if [ "${margin}" != 'null' ]; then
				inkscape --without-gui \
					-w "${size}" -h "${size}" \
					-a "${margin}" \
					-e "${TARGET_DIR}/${name}_margin_x${size}.png" \
					"${SCRIPT_DIR}/${file}"

				inkscape --without-gui \
					-w "${size}" -h "${size}" \
					-b "${background}" \
					-a "${margin}" \
					-e "${TARGET_DIR}/${name}_background_margin_x${size}.png" \
					"${SCRIPT_DIR}/${file}"
			fi
		done
	done
}

main

