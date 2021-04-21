#!/bin/bash

PROJECT=`echo ${6,,}`

PREFIX="dev"
if test "$4" = "Production"; then
  PREFIX="live"
fi

FOLDER=`echo /home/microservices/${PREFIX}/${PROJECT}`
IMAGE=`echo ${PREFIX}-${5}`
STACK_NAME=`echo ${PREFIX}-${PROJECT}`

mkdir -p ~/.ssh
chmod 700 ~/.ssh
eval $(ssh-agent -s)
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
ssh-add <(echo "$2")

ssh -oStrictHostKeyChecking=no $3@$1 mkdir $FOLDER -p
scp -oStrictHostKeyChecking=no docker-compose.$4.yml $3@$1:$FOLDER
ssh -oStrictHostKeyChecking=no $3@$1 env IMAGE=$IMAGE env IMAGETAG=$7 docker stack deploy -c $FOLDER/docker-compose.$4.yml $STACK_NAME
