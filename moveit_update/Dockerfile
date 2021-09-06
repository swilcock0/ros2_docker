FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

# Install latest version of moveit

RUN apt-get update &&\
    mkdir -p ~/moveit_ws/src && \
    cd ~/moveit_ws/src && \
    git clone https://github.com/ros-planning/moveit2.git -b foxy && \
    vcs import < moveit2/moveit2.repos && \
    #
    # Update apt package list as cache is cleared in previous container
    # Usually upgrading involves a few packages only (if container builds became out-of-sync)
    apt-get -qq update && \
    apt-get -qq dist-upgrade && \
    #
    rosdep update && \
    rosdep install -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} --as-root=apt:false && \
    rm -rf /var/lib/apt/lists/*

RUN cd ~/moveit_ws/ &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build \
    --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    --ament-cmake-args -DCMAKE_BUILD_TYPE=Release \
    --event-handlers desktop_notification- status-

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