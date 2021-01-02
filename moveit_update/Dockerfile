FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

# Install latest version of moveit

RUN apt-get update &&\
    mkdir -p ~/moveit_ws/src && \
    cd ~/moveit_ws/src && \
    wget https://raw.githubusercontent.com/ros-planning/moveit2/main/moveit2.repos &&\
    vcs import < moveit2.repos &&\
    rosdep install -r --from-paths . --ignore-src --rosdistro foxy -y &&\
    cd .. &&\
    rm -rf /var/lib/apt/lists/*

RUN cd ~/moveit_ws &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release

# Install ros2 control 
RUN apt-get update &&\
    apt-get install -y ros-foxy-test-msgs libopenblas-dev &&\
    mkdir -p ~/repos/ros2_control/src &&\
    cd ~/repos/ros2_control/ &&\
    git clone https://github.com/ros-controls/ros2_control.git src &&\
    cd src &&\
    git checkout 3d542bb045860cdc7e7338c2e16a73985e387511 &&\
    cd .. &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build &&\
    rm -rf /var/lib/apt/lists/*

# Install Gazebo ROS2 control
RUN mkdir -p ~/repos/gazebo_ros2_control/src &&\
    cd ~/repos/gazebo_ros2_control &&\
    git clone https://github.com/ros-simulation/gazebo_ros2_control.git src &&\
    . ~/repos/ros2_control/install/setup.sh &&\
    colcon build

USER $USER

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]