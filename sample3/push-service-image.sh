#!/bin/bash

set -e

PROJECT=`echo ${7,,}`

PREFIX="dev"
if test "$8" = "Production"; then
  PREFIX="live"
fi

IMAGETAG=`echo ${PREFIX}-${1}`

docker rmi $IMAGETAG || true
docker build --build-arg GROUP_ID=$6 \
  --build-arg ARTIFACT_ID=$7 \
  --build-arg VERSION=$5 \
  --build-arg REPO_URL=$2 \
  --build-arg USERNAME=$3 \
  --build-arg PASSWORD=$4 \
  -f Dockerfile -t $IMAGETAG .

exit 0