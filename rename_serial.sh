#!/usr/bin/env bash
count=1
image_extensions=("jpg" "jpeg" "png" "gif" "bmp" "tiff" "webp")

for file in *; do
  if [ -f "$file" ]; then
    extension="${file##*.}"
    extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

    if [[ " ${image_extensions[*]} " =~ " ${extension_lower} " ]]; then
      while [ -e "${count}.${extension_lower}" ]; do
        count=$((count + 1))
      done
      mv -- "$file" "${count}.${extension_lower}"
      count=$((count + 1))
    fi
  fi
done

echo "Image renaming complete!"
