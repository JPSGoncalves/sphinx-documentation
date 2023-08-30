#Oe container script to start docker for yocto development 
# with Toradex Meta Layers
# usage ./start_orcont_toradex_dev.sh bsp or ./start_orcont_toradex_dev.sh tezi

set -e

source $HOME/personal/repos/sphinx-documentation/automation/bash/docker.env

echo -e "OE Development Docker for\n"

WORKDIR_HOST=$OEDEV_WORKDIR_HOST
WORKDIR_CONTAINER=$OEDEV_WORKDIR_CONTAINER
SHARED_DOWLOADS_CONTAINER=${WORKDIR_CONTAINER}/shared-downloads


echo -e "OE Dev Enviroment:"
printenv | grep OEDEV_ && echo ""


echo -e "Docker Enviroment:"
echo "Meta OE Main Volume (host)            : $OEDEV_WORKDIR_HOST"
echo "Meta OE Shared Downloads Volume (host): $OEDEV_META_SHARED_DOWLOADS_HOST"
echo "Container Workdir                    : $OEDEV_WORKDIR_CONTAINER"
echo "Container Shared Downloadas          : $SHARED_DOWLOADS_CONTAINER"

# mount 2 volumes on docker one for meta layers and one for a folder to shared downloads between diff OE builds 
echo "Starting Docker"
docker run -it $MY_DOCKER_COMMON_ARGS \
-v $OEDEV_WORKDIR_HOST:$OEDEV_WORKDIR_CONTAINER \
-v $OEDEV_META_SHARED_DOWLOADS_HOST:$OEDEV_META_SHARED_DOWLOADS_CONTAINER \
--workdir=$WORKDIR_CONTAINER $OEDEV_DOCKER_YOCTO_IMG


