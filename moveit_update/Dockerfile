FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

# Install latest version of moveit

COPY --from=moveit/moveit2:foxy-source /root/ws_moveit/ /home/ros/moveit_ws/

RUN apt-get update -qq &&\
    cd ~/moveit_ws/src &&\
    rosdep install -r --from-paths . --ignore-src --rosdistro foxy -y --as-root=apt:false && \
    rm -rf /var/lib/apt/lists/*

# Prerequisites & install debian ros2_control pkg
RUN apt-get update &&\
    apt-get install -y ros-foxy-test-msgs libopenblas-dev &&\
    apt-get install -y ros-foxy-ros2-control ros-foxy-ros2-controllers &&\
    rm -rf /var/lib/apt/lists/*

# Fix the colcon build. This technique of cloning the built workspace and rebuilding seems faster than directly building from source
RUN . /opt/ros/foxy/setup.sh &&\ 
    cd /home/ros/moveit_ws &&\
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    --ament-cmake-args -DCMAKE_BUILD_TYPE=Release --event-handlers desktop_notification- status- --cmake-clean-cache

USER $USER

# Install Gazebo ROS2 control
RUN mkdir -p ~/gazebo_ros2_control/src &&\
    cd ~/gazebo_ros2_control/ &&\
    . /opt/ros/foxy/setup.sh &&\
    git clone https://github.com/ros-simulation/gazebo_ros2_control.git src &&\
    colcon build --merge-install --symlink-install

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]