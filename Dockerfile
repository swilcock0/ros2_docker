FROM ros:foxy-ros-core-focal as ros2

FROM ros:foxy-ros1-bridge-focal as rosbridge

FROM nvidia/cuda:11.0-devel-ubuntu20.04 AS ubuntu

LABEL maintainer "Sam Wilcock"

# Install sudo
RUN apt-get update && \
    apt-get install -y sudo \
    xterm \
    curl

# Configure user
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
    # Replace 1000 with your user/group id
    usermod  --uid $UID $USER && \
    groupmod --gid $GID $USER

### Install VScode
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN sudo apt-get install -y apt-transport-https && \
    sudo apt-get update && \
    sudo apt-get install -y code

### VNC Installation
LABEL io.k8s.description="Headless VNC Container with Xfce window manager, firefox and chromium" \
      io.k8s.display-name="Headless VNC Container based on Ubuntu" \
      io.openshift.expose-services="6901:http,5901:xvnc" \
      io.openshift.tags="vnc, ubuntu, xfce" \
      io.openshift.non-scalable=true

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport 6901, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT

## Envrionment config. This could be moved up!  ^^^^^^^^^
ENV VNCPASSWD=samrobot
ENV HOME=/home/$USER \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/home/$USER/install \
    NO_VNC_HOME=/home/$USER/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1920x1080 \
    VNC_PW=$VNCPASSWD \
    VNC_VIEW_ONLY=false
WORKDIR $HOME

## Add all install scripts for further steps
ADD ./src/common/install/ $INST_SCRIPTS/
ADD ./src/ubuntu/install/ $INST_SCRIPTS/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

## Install some common tools
RUN $INST_SCRIPTS/tools.sh
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

## Install xvnc-server & noVNC - HTML5 based VNC viewer
RUN $INST_SCRIPTS/tigervnc.sh
RUN $INST_SCRIPTS/no_vnc.sh

## Install firefox and chrome browser
RUN $INST_SCRIPTS/firefox.sh
RUN $INST_SCRIPTS/chrome.sh

## Install xfce UI
RUN $INST_SCRIPTS/xfce_ui.sh
ADD ./src/common/xfce/ $HOME/

## configure startup
RUN $INST_SCRIPTS/libnss_wrapper.sh
ADD ./src/common/scripts $STARTUPDIR
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

# Install ROS2
COPY --from=ros2 / /

# Install rosbridge
COPY --from=rosbridge / /

# Install gazebo
COPY --from=gazebo:libgazebo11 / /

# Setup ROS environment
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN echo "export _colcon_cd_root=~/ros2_install" >> ~/.bashrc
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# TODO: 
# Add Catkin??
# Add Universal robots
# Test bridge, see https://index.ros.org/doc/ros2/Installation/Foxy/Linux-Install-Debians/
# Add danso robots if you can find
# Add keras, tensorflow


# Configure desktop and clean up
ADD ./src/desktop $HOME/Desktop
RUN $INST_SCRIPTS/set_user_permission.sh $HOME
RUN apt update
RUN apt-get autoremove -y && apt-get autoclean -y
ENV ROS_LOG_DIR=$HOME/Desktop/logs_ros

# Expose Tensorboard
EXPOSE 6006

# Expose Jupyter 
EXPOSE 8888

# Expose ROS
EXPOSE 9090

RUN useradd --create-home --no-log-init -g $USER $USER && \
    usermod -aG sudo $USER && \
    echo "$PASSWD:$PASSWD" | chpasswd && \
    chsh -s /bin/bash $USER && \
    # Replace 1000 with your user/group id
    usermod  --uid $UID $USER && \
    groupmod --gid $GID $USER


USER $USER

ENTRYPOINT ["/dockerstartup/vnc_startup.sh", "-w", "-d"]
CMD ["--wait"]