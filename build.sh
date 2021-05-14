#!/bin/bash

TAG='lambda-layer-kubectl'

docker build -t $TAG .
CONTAINER=$(docker run -d $TAG false)
docker cp ${CONTAINER}:/layer.zip layer.zip