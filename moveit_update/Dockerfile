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
# RUN mkdir -p ~/control_ws/src &&\
#     cd ~/control_ws/src &&\
#     git clone https://github.com/ros-controls/ros2_control.git &&\
#     cd ros2_control &&\
#     git reset --hard 3dc62e28e3bc8cf636275825526c11d13b554bb6

# # Install ros2 controllers
# RUN cd ~/control_ws/src &&\
#     . ~/control_ws/install/setup.sh &&\
#     git clone https://github.com/ros-controls/ros2_controllers &&\
#     cd ros2_controllers &&\
#     git reset --hard 83c494f460f1c8675f4fdd6fb8707b87e81cb197

# # Install Gazebo ROS2 control
# RUN cd ~/control_ws/src &&\
#     . ~/control_ws/install/setup.sh &&\
#     git clone https://github.com/ros-simulation/gazebo_ros2_control.git &&\
#     cd gazebo_ros2_control &&\
#     git reset --hard 3dfe04d412d5be4540752e9c1165ccf25d7c51fb &&\
#     cd .. &&\
#     . /opt/ros/foxy/setup.sh &&\
#     colcon build --merge-install --symlink-install

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]