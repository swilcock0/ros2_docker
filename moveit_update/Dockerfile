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

# Prerequisites
RUN apt-get update &&\
    apt-get install -y ros-foxy-test-msgs libopenblas-dev &&\
    rm -rf /var/lib/apt/lists/*

USER $USER

# Install ros2 control 
RUN mkdir -p ~/repos/ros2_control/src &&\
    cd ~/repos/ros2_control/ &&\
    git clone https://github.com/ros-controls/ros2_control.git src &&\
    cd src &&\
    git checkout 1e2797627f291bb64ff66dda77e7884b5f4b88c4 &&\
    cd .. &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build    

# Install ros2 controllers
RUN mkdir -p ~/repos/ros2_controllers/src &&\
    . ~/repos/ros2_control/install/setup.sh &&\
    cd ~/repos/ros2_controllers/ &&\
    git clone https://github.com/ros-controls/ros2_controllers src &&\
    cd src &&\
    git checkout bc2b5fd550179d9db78827f7cab19476cf1a4c4f &&\
    cd .. &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build

# Install Gazebo ROS2 control
RUN mkdir -p ~/repos/gazebo_ros2_control/src &&\
    cd ~/repos/gazebo_ros2_control &&\
    git clone https://github.com/ros-simulation/gazebo_ros2_control.git src &&\
    . ~/repos/ros2_control/install/setup.sh &&\
    . ~/repos/ros2_controllers/install/setup.sh &&\
    colcon build

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]