FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

# Install latest version of rviz
RUN apt update &&\
    apt install -y ros-${ROS_DISTRO}-rviz* &&\
    rm -rf /var/lib/apt/lists/*

# Install moveit
RUN apt update &&\
    apt install -y ros-galactic-moveit &&\
    rm -rf /var/lib/apt/lists/*

# Cant remember what this patched
RUN apt-get update &&\
    apt-get install -y ros-${ROS_DISTRO}-test-msgs libopenblas-dev &&\
    rm -rf /var/lib/apt/lists/*

# # Install ros2_control/ ros2_controllers (do the binary releases exist yet?? Give @bmagyar a couple weeks)
# RUN apt-get update && \
#     apt-get install -y ros-${ROS_DISTRO}-ros2-control ros-${ROS_DISTRO}-ros2-controllers && \
#     rm -rf /var/lib/apt/lists/*

USER $USER

# # Install ROS2 control and controllers
# RUN mkdir -p ~/ros2_control/src &&\
#     cd ~/ros2_control/ &&\
#     . /opt/ros/${ROS_DISTRO}/setup.sh &&\
#     git clone https://github.com/ros-controls/ros2_control.git src &&\
#     cd src &&\
#     vcs import < ros2_control/ros2_control.repos &&\
#     rosdep install -r -q --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y &&\
#     cd .. &&\
#     colcon build --merge-install --symlink-install


# # Install Gazebo ROS2 control - this may take some debugging/dual versions of ros2-control?
# RUN mkdir -p ~/gazebo_ros2_control/src &&\
#     cd ~/gazebo_ros2_control/ &&\
#     . /opt/ros/${ROS_DISTRO}/setup.sh &&\
#     git clone https://github.com/ros-simulation/gazebo_ros2_control.git src &&\
#     colcon build --merge-install --symlink-install

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]