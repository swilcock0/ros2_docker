FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

# Install latest version of rviz
RUN apt update &&\
    apt install -y ros-${ROS_DISTRO}-rviz* &&\
    rm -rf /var/lib/apt/lists/*

USER $user

# Install moveit
RUN mkdir -p ~/moveit/src &&\
    cd ~/moveit/src &&\
    . /opt/ros/${ROS_DISTRO}/setup.sh &&\
    git clone https://github.com/ros-planning/moveit2.git &&\  
    vcs import < moveit2/moveit2_galactic.repos &&\
    vcs import < moveit2/moveit2.repos

USER root
RUN apt update &&\
    cd ~/moveit &&\
    rosdep install -r --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} -y &&\
    rm -rf /var/lib/apt/lists/*

USER $user
RUN cd ~/moveit &&\
    . /opt/ros/${ROS_DISTRO}/setup.sh &&\
    colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release    
# End of moveit build #

USER root
RUN apt update &&\
    apt install -y ros-${ROS_DISTRO}-robot-state-publisher &&\
    rm -rf /var/lib/apt/lists/*

# Cant remember what this patched
RUN apt-get update &&\
    apt-get install -y ros-${ROS_DISTRO}-test-msgs libopenblas-dev &&\
    rm -rf /var/lib/apt/lists/*

RUN apt-get update &&\
    apt-get install -y ros-${ROS_DISTRO}-plotjuggler-ros &&\
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
#     vcs import < ros2_control/ros2_control.repos

# USER root
# RUN apt-get update &&\
#     cd ~/ros2_control &&\
#     rosdep install -r -q --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y &&\
#     rm -rf /var/lib/apt/lists/*

# USER $user
# RUN cd ~/ros2_control &&\
#     colcon build --merge-install --symlink-install 



# Install Gazebo ROS2 control - this may take some debugging/dual versions of ros2-control?
RUN mkdir -p ~/gazebo_ros2_control/src &&\
    cd ~/gazebo_ros2_control/ &&\
    . /opt/ros/${ROS_DISTRO}/setup.sh &&\
    . ~/moveit/install/setup.sh &&\
    git clone https://github.com/ros-simulation/gazebo_ros2_control.git src &&\
    colcon build --merge-install --symlink-install

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]