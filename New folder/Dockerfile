
FROM dorowu/ubuntu-desktop-lxde-vnc:focal

## Install sudo
RUN apt-get update && \
    apt-get install -y sudo \
    xterm \
    curl

## User definition
ARG user=ros
ARG passwd=ros
ARG uid=1000
ARG gid=1000
ENV USER=$user
ENV PASSWD=$passwd
ENV UID=$uid
ENV GID=$gid
RUN groupadd $USER && \
    useradd --create-home --no-log-init -g $USER $USER && \
    usermod -aG sudo $USER && \
    echo "$PASSWD:$PASSWD" | chpasswd && \
    chsh -s /bin/bash $USER && \
    usermod  --uid $UID $USER && \
    groupmod --gid $GID $USER


## Set locale and environment
ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    VNCPASSWD=samrobot \
    HOME=/home/$USER \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1920x1080 \
    VNC_PW=$VNCPASSWD \
    VNC_VIEW_ONLY=false

EXPOSE $VNC_PORT $NO_VNC_PORT

WORKDIR $HOME



### Applications


## Install VScode
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

## Install ROS
RUN sudo apt update && sudo apt install curl gnupg2 lsb-release &&\
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - &&\
    sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list' &&\
    sudo apt update &&\
    sudo apt install ros-foxy-desktop &&\
    sudo apt install -y python3-pip
    pip3 install -U argcomplete





## Install gazebo
RUN curl -sSL http://get.gazebosim.org | sh

## Install Moveit
RUN mkdir -p ~/moveit_ws/src && \
    cd ~/moveit_ws/src && \
    wget https://raw.githubusercontent.com/ros-planning/moveit2/main/moveit2.repos &&\
    vcs import < moveit2.repos &&\
    rosdep install -r --from-paths . --ignore-src --rosdistro foxy -y &&\
    cd .. &&\
    colcon build --event-handlers desktop_notification- status- --cmake-args -DCMAKE_BUILD_TYPE=Release

# Install ros2_control
RUN mkdir -p ~/ros2_control/src && \
    cd ~/ros2_control && \
    git clone BLAHBLAHBLAH src && \
    source /opt/ros/foxy/setup.bash && \

# Done?

RUN ["bin/bash"]
