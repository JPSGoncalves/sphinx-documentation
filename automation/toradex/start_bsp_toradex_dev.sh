


set -e

source $HOME/repos/personal/sphinx-documentation/automation/bash/docker.env 

export TORADEX_BSP_YOCTO_IMG=crops/poky:ubuntu-22.04
export TORADEX_BSP_WORKDIR_HOST=$HOME/toradex/meta
export TORADEX_BSP_WORKDIR_CONTAINER=/toradex-bsp


echo "Toradex BSP Start Script"
echo "Enviroment:"
printenv | grep TORADEX_BSP

echo "Starting Docker"
docker run -it $MY_DOCKER_COMMON_ARGS -v $TORADEX_BSP_WORKDIR_HOST:$TORADEX_BSP_WORKDIR_CONTAINER --workdir=$TORADEX_BSP_WORKDIR_CONTAINER $TORADEX_BSP_YOCTO_IMG


