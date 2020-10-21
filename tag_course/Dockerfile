# Depends on base container
# Build as (in ros2_ubuntu): docker build -t swilcock0/ros2_ubuntu:course -f ./tag_course/Dockerfile .
FROM swilcock0/ros2_ubuntu:latest

USER root

RUN apt-get install -y --no-install-recommends python3-pip ros-foxy-rqt ros-foxy-rqt-common-plugins ros-foxy-turtlesim ros-foxy-rviz2 &&\
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade autopep8 -y

USER $USER

RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc &&\
    echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc &&\
    echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc && echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc &&\
    rm -rf /var/lib/apt/lists/* &&\
    printenv | grep -i ROS

ENTRYPOINT ["/dockerstartup/vnc_startup.sh", "-d"]
CMD ["--wait"]