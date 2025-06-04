#!/bin/bash

output_file="css-pages.tsv"
echo -e "File\tTitle\tSlug\tPage Type" > "$output_file"

# Use sort here to ensure alphabetical order
total_files=$(find files/en-us/web/css -name '*.md' | sort | tee /tmp/css-filelist.txt | wc -l)
count=0

cat /tmp/css-filelist.txt | while read -r file; do
  count=$((count + 1))
  printf "\rProcessing file %d of %d..." "$count" "$total_files"

  yaml=$(awk '/^---/{f=!f; next} f' "$file")
  slug=$(printf '%s\n' "$yaml" | yq e '.slug' - 2>/dev/null)
  title=$(printf '%s\n' "$yaml" | yq e '.title' - 2>/dev/null)
  page_type=$(printf '%s\n' "$yaml" | yq e '.page-type' - 2>/dev/null)

  if [[ -n "$slug" && -n "$title" ]]; then
    echo -e "$file\t$title\t$slug\t$page_type" >> "$output_file"
  fi
done

echo -e "\nDone! Output written to $output_file"
