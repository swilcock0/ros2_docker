# Depends on base container
# Build as (in ros2_ubuntu): docker build -t swilcock0/ros2_ubuntu:course -f ./tag_course/Dockerfile .
FROM swilcock0/ros2_ubuntu:latest

USER root

RUN echo "Package: * " >> /etc/apt/preferences.d/allow-downgrade && echo "Pin: release o=Ubuntu" >> /etc/apt/preferences.d/allow-downgrade && echo "Pin-Priority: 1001"  >> /etc/apt/preferences.d/allow-downgrade 

RUN apt-get install -y python3-pip ros-foxy-rqt ros-foxy-rqt-common-plugins ros-foxy-turtlesim ros-foxy-rviz2 &&\
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade autopep8
RUN rm -rf /etc/apt/sources.list.d/cuda.list

USER $USER

RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc &&\
    echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc &&\
    echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc && echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc &&\
    rm -rf /var/lib/apt/lists/* &&\
    printenv | grep -i ROS

RUN rosdep update && export COLCON_WS=~/ros2_ws/

USER root
RUN apt-get install python3-vcstool -y

RUN /bin/bash -c "apt-get update && source ~/.bashrc && export MOVEIT_WS=~/moveit_ws/ && mkdir -p $MOVEIT_WS/src && cd $MOVEIT_WS/src &&\
    git clone https://github.com/ros-planning/moveit2.git -b main  &&\
    vcs import $MOVEIT_WS/src < $MOVEIT_WS/src/moveit2/moveit2.repos &&\
    rosdep install -r --from-paths MOVEIT_WS/src --ignore-src --rosdistro foxy -y  &&\
    cd $MOVEIT_WS &&\
    colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release"
RUN echo "source $MOVEIT_WS/install/setup.bash" >> ~/.bashrc

USER $USER


ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]