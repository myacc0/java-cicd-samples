#!/bin/bash

PROJECT=`echo ${5,,}`

PREFIX="dev"
if test "$4" = "Production"; then
  PREFIX="live"
fi

STACK_NAME=`echo ${PREFIX}-${PROJECT}`
IMAGETAG=`echo ${PREFIX}-${6}`

mkdir -p ~/.ssh
chmod 700 ~/.ssh
eval $(ssh-agent -s)
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
ssh-add <(echo "$2")

ssh -oStrictHostKeyChecking=no $3@$1 docker stack rm $STACK_NAME; (docker rmi $IMAGETAG)
