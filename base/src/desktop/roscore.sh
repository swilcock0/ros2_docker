#!/bin/bash

source /home/ros/ros1_common_msg/install_isolated/setup.bash
export ROS_MASTER_URI=http://localhost:11311
roslaunch rosbridge_server rosbridge_websocket.launch
