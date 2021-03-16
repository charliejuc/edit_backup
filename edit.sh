#!/bin/bash
set -e

defaultBackupPath=/tmp

if [ ! "$EDITOR_BACKUP_PATH" ]; then
  EDITOR_BACKUP_PATH=$defaultBackupPath
fi

if [ ! -d "$EDITOR_BACKUP_PATH" ]; then
  echo >&2 "\"EDITOR_BACKUP_PATH\" should be a directory"
  exit 1
fi

outputPath="${EDITOR_BACKUP_PATH}/sec_edit/$(date +%Y-%m)"

arguments=("$@")
file=${arguments[${#arguments[@]} - 1]}

tookArguments="${arguments[*]/#/}"
unset "tookArguments[${#tookArguments[@]}-1]"

filename="${file%.*}"
extension="${file##*.}"
outputFile="${filename}_$(date +%Y-%M-%d_%H:%m:%S).$extension"

if [ ! -d "$outputPath" ]; then
  mkdir -p "$outputPath"
fi

cp "$file" "$outputPath/$outputFile"

$EDITOR "${tookArguments[@]/#/}" "$file"
