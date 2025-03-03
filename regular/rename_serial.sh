#!/usr/bin/env bash

image_extensions=("jpg" "jpeg" "png" "gif" "bmp" "tiff" "webp")
count=1

for file in *; do
  if [ -f "$file" ]; then
    extension="${file##*.}"
    extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

    if [[ " ${image_extensions[*]} " =~ " ${extension_lower} " ]]; then
      new_name=$(printf "%03d.%s" "$count" "$extension_lower")

      while [ -e "$new_name" ]; do
        count=$((count + 1))
        new_name=$(printf "%03d.%s" "$count" "$extension_lower")
      done

      git mv -- "$file" "$new_name"
      count=$((count + 1))
    fi
  fi
done

echo "Image renaming complete!"