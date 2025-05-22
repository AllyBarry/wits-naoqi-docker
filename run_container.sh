#!/bin/bash

# Before running, run this to allow connections to X server
# xhost +local:docker
# When complete, run:
# xhost -local:docker

# Change to 'run -d' to run in detached mode.
docker run -it \
  -v `pwd`/src:/naoqi/src \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --gpus all \
  --name wits_pepper \
  -w /home/user \
  naoqi-python