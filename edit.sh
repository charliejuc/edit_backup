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

outputPath="${EDITOR_BACKUP_PATH}/edit_backup_$(whoami)/$(date +%Y-%m)"

arguments=("$@")
file=${arguments[${#arguments[@]} - 1]}

if [ ! "$file" ] || [[ "$file" == -* ]]; then
  $EDITOR "${arguments[@]/#/}"
  exit $?
fi

tookArguments="${arguments[*]/#/}"
unset "tookArguments[${#tookArguments[@]}-1]"

getFilename() {
  local filename
  filename=$(basename "$1")
  if [[ "$filename" == .* ]]; then
    echo "$filename"
    return 0
  fi

  echo "${filename%.*}"
}

getDottedExtension() {
  local filename
  filename=$(basename "$1")
  if [[ "$filename" == .* ]] && [[ "$filename" != .*.* ]]; then
    echo ""
    return 0
  fi

  echo ".${filename##*.}"
}

filename="$(getFilename "$file")"
extension="$(getDottedExtension "$file")"

outputFile="${filename}_$(date +%Y-%m-%d_%H:%M:%S)${extension}"

if [ ! -d "$outputPath" ]; then
  mkdir -p "$outputPath"
fi

if [[ "$file" != $outputPath/* ]]; then
  cp "$file" "$outputPath/$outputFile"
fi

$EDITOR "${tookArguments[@]/#/}" "$file"
