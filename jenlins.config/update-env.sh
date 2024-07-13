#!/bin/bash

ENV_FILE="src/environments/environment.ts"

# Check if the environment file exists
if [ -f "$ENV_FILE" ]; then
  echo "Updating environment.ts file with API_URL=${API_URL}"

  # Update the API_URL in environment.ts
  sed -i "s|const url = .*|const url = '${API_URL}';|g" "$ENV_FILE"

  echo "Updated environment.ts file:"
  cat "$ENV_FILE"
else
  echo "Environment file not found: $ENV_FILE"
  exit 1
fi
