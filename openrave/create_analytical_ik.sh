#!/bin/bash

export MYROBOT_NAME="vs068"

# Setup environment
. /opt/ros/indigo/setup.bash
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:/home/ros/ros2_ws/src/my_denso:/home/ros/ros2_ws/src/gripper_assy

roscd my_denso/urdf

rosrun collada_urdf urdf_to_collada vs068_with_gripper.urdf "$MYROBOT_NAME".dae

export IKFAST_PRECISION="5"
cp "$MYROBOT_NAME".dae "$MYROBOT_NAME".backup.dae  # create a backup of your full precision dae.
rosrun moveit_kinematics round_collada_numbers.py "$MYROBOT_NAME".dae "$MYROBOT_NAME".dae "$IKFAST_PRECISION"

openrave-robot.py "$MYROBOT_NAME".dae --info links

export PLANNING_GROUP="arm"

export BASE_LINK="0"
export EEF_LINK="10"

export IKFAST_OUTPUT_PATH=`pwd`/ikfast61_"$PLANNING_GROUP".cpp
python `openrave-config --python-dir`/openravepy/_openravepy_/ikfast.py --robot="$MYROBOT_NAME".dae --iktype=transform6d --baselink="$BASE_LINK" --eelink="$EEF_LINK" --savefile="$IKFAST_OUTPUT_PATH"
