FROM moveit/moveit2:foxy-source as moveit
FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

# Install latest version of moveit

RUN apt-get update &&\
    mkdir -p ~/moveit_ws/src && \
    cd ~/moveit_ws/src && \
    wget https://raw.githubusercontent.com/ros-planning/moveit2/main/moveit2.repos &&\
    vcs import < moveit2.repos &&\
    git clone https://github.com/ros-planning/moveit2.git &&\
    rosdep install -r --from-paths . --ignore-src --rosdistro foxy -y &&\
    cd .. &&\
    rm -rf /var/lib/apt/lists/*

RUN cd ~/moveit_ws/ &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release

# Prerequisites & install debian ros2_control pkg
RUN apt-get update &&\
    apt-get install -y ros-foxy-test-msgs libopenblas-dev &&\
    apt-get install -y ros-foxy-ros2-control ros-foxy-ros2-controllers &&\
    rm -rf /var/lib/apt/lists/*

USER $USER

# Install Gazebo ROS2 control
RUN mkdir -p ~/gazebo_ros2_control/src &&\
    cd ~/gazebo_ros2_control/ &&\
    . /opt/ros/foxy/setup.sh &&\
    git clone https://github.com/ros-simulation/gazebo_ros2_control.git src &&\
    colcon build --merge-install --symlink-install

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]