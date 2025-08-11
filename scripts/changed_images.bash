#!/bin/bash

set -e
DEFAULT_BRANCH=${DEFAULT_BRANCH:-origin/main}
modified_folders=$(git --no-pager diff "$DEFAULT_BRANCH" --name-only -- ':!.git*' ':!scripts' ':!templates' ':!.vib' ':bitnami/clickhouse' ':bitnami/postgresql')

for folder in $modified_folders; do
  if [[ $folder == *"/"* ]]; then
    result+=(\""$(dirname "$folder")"\")
  else
    result+=(\""${folder}"\")
  fi
done

result=($(printf '%s\n' "${result[@]}" | sort | uniq))

echo "[$(
  IFS=,
  echo "${result[*]}"
)]"
