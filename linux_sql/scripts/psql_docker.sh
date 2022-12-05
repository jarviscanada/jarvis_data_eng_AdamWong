#! bin/bash

cmd=$1
db_username=$2
db_password=$3

#start docker
sudo systemctl status docker || systemctl start docker

#check container status
docker container inspect jrvs-psql
container_status=$?

#Switch case for create|start|stop operations
case $cmd in
  create)

    #check if container created
    if [ $container_status -eq 0 ]; then
      echo 'Container already exists'
      exit 1
    fi

    #check # of CLI args
    if [ $# -ne 3 ]; then
      echo 'Create requires username and password'
      exit 1
    fi

    #Create container
    docker volume create pgdata
    docker run --name jrvs-psql -e POSTGRES_PASSWORD=$PGPASSWORD -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
    exit $?
    ;;

    start|stop)
    #check instance status; exit 1 if not created
    if [ $container_status -eq 0 ]; then
      echo 'Container not created'
      exit 1
    fi

    #Start or stop container
    docker container $cmd jrvs-postgresql
    exit $?
    ;;

    *)
    echo 'Illegal command'
    echo 'Commands: start|stop|create'
    exit 1
    ;;
  esac


exit 0``