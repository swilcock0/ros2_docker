#!/bin/bash

#my_startup_moveit_checks.sh

export COLCON_WS=~/ros2_ws/
cd ~/ros2_ws/src 
rosdep update

vcs import < moveit2/moveit2.repos
rosdep install -r --from-paths . --ignore-src --rosdistro foxy -y
cd $COLCON_WS
colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release