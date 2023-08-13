#Oe container script to start docker for yocto development 
# with Toradex Meta Layers
# usage ./start_orcont_toradex_dev.sh bsp or ./start_orcont_toradex_dev.sh tezi

set -e

source $HOME/repos/personal/sphinx-documentation/automation/bash/docker.env 
source $HOME/toradex/enviroment/toradex_common.env


echo -e "Toradex OE Development Docker for\n"

case "$1" in
  "bsp")
    echo -e "BSP Development\n"
    WORKDIR_HOST=$TORADEX_BSP_WORKDIR_HOST
    WORKDIR_CONTAINER=$TORADEX_BSP_WORKDIR_CONTAINER
    ;;
  "tezi") 
    echo -e "Tezi Development\n"
    WORKDIR_HOST=$TORADEX_TEZI_WORKDIR_HOST
    WORKDIR_CONTAINER=$TORADEX_TEZI_WORKDIR_CONTAINER
    ;;
  *)
    echo "Invalid development type."
    exit 1
esac


SHARED_DOWLOADS_CONTAINER=${WORKDIR_CONTAINER}/shared-downloads

echo -e "Toradex Enviroment:"
printenv | grep TORADEX_ && echo ""


echo -e "Docker Enviroment:"
echo "Meta OE Main Volume (host)            : $WORKDIR_HOST"
echo "Meta OE Shared Downloads Volume (host): $TORADEX_META_SHARED_DOWLOADS_HOST"
echo "Container Workdir                    : $WORKDIR_CONTAINER"
echo "Container Shared Downloadas          : $SHARED_DOWLOADS_CONTAINER"

# mount 2 volumes on docker one for meta layers and one for a folder to shared downloads between diff OE builds 
echo "Starting Docker"
docker run -it $MY_DOCKER_COMMON_ARGS -v $WORKDIR_HOST:$WORKDIR_CONTAINER -v $TORADEX_META_SHARED_DOWLOADS_HOST:$SHARED_DOWLOADS_CONTAINER --workdir=$WORKDIR_CONTAINER $TORADEX_DOCKER_YOCTO_IMG


