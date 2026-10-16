#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Cloudflare's Linux build image does not include the Dart SDK.
if ! command -v dart >/dev/null 2>&1; then
  sdk_dir="$(mktemp -d)"
  trap 'rm -rf "$sdk_dir"' EXIT
  curl --fail --location --retry 3 \
    'https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.2/sdk/dartsdk-linux-x64-release.zip' \
    --output "$sdk_dir/dart.zip"
  unzip -q "$sdk_dir/dart.zip" -d "$sdk_dir"
  export PATH="$sdk_dir/dart-sdk/bin:$PATH"
fi

dart pub get
npm ci
dart pub global activate jaspr_cli 0.23.4
rm -f web/output.css
npm run build:css
dart pub global run jaspr_cli:jaspr build
test -f build/jaspr/index.html
test -f build/jaspr/favicon.svg
