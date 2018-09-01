#!/bin/bash
VERSION=3.5
if [ -n "$1" ]; then
  VERSION="$1"
fi

echo "Building Zookeeper Image for Version: '$VERSION'"
docker build --no-cache \
  --build-arg VERSION="$VERSION" \
  -t countinus/zookeeper:$VERSION .
