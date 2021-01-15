FROM swilcock0/ros2_ubuntu:base

LABEL maintainer "Sam Wilcock/swilcock0"

USER $USER

# Install latest version of moveit, ros2_control, ros2_controllers, Gazebo_ros2_control...
RUN mkdir -p /home/ros/moveit_ws/src &&\
    cd /home/ros/moveit_ws/src/ &&\
    git clone https://github.com/ros-planning/moveit2 &&\
    git clone https://github.com/ros-planning/moveit_msgs -b ros2 &&\
    git clone https://github.com/ros-planning/moveit_resources -b ros2 &&\
    git clone https://github.com/ros-planning/geometric_shapes -b ros2 &&\
    git clone https://github.com/ros-planning/srdfdom -b ros2 &&\
    git clone https://github.com/ros-planning/warehouse_ros -b ros2 &&\
    git clone https://github.com/ros-planning/warehouse_ros_mongo -b ros2 &&\
    git clone https://github.com/ros-controls/ros2_control &&\
    git clone https://github.com/ros-controls/ros2_controllers &&\
    git clone https://github.com/ros-simulation/gazebo_ros_demos -b ahcorde/port/ros2 &&\
    git clone https://github.com/ros-simulation/gazebo_ros2_control -b ahcorde/update/foxy

USER root

RUN rm -f /usr/lib/x86_64-linux-gnu/liblapack.so /usr/lib/x86_64-linux-gnu/libblas.so &&\
    ln -s /usr/lib/x86_64-linux-gnu/lapack/liblapack.so /usr/lib/x86_64-linux-gnu/liblapack.so &&\
    ln -s /usr/lib/x86_64-linux-gnu/blas/libblas.so /usr/lib/x86_64-linux-gnu/libblas.so &&\
    cd /home/ros/moveit_ws/src/ &&\
    rosdep install -r --from-paths . -y --rosdistro foxy --ignore-src

USER $USER

RUN cd /home/ros/moveit_ws/ &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build --merge-install --cmake-args -DCMAKE_BUILD_TYPE=Release

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]