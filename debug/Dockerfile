FROM ros:foxy-ros-core-focal as ros2

#FROM nvidia/cuda:11.0-devel-ubuntu20.04 AS ubuntu

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
ENV DEBIAN_FRONTEND=noninteractive
ENV DONT_PROMPT_WSL_INSTALL=1
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

# Deleted VSCode section 


ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN sudo apt-get install -y apt-transport-https

### VNC Installation info
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
RUN apt update && apt install supervisor xfce4 xfce4-terminal xfce4-goodies -y &&\
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt install tigervnc-standalone-server tigervnc-common -y &&\
    rm -rf /var/lib/apt/lists/*

RUN $INST_SCRIPTS/no_vnc.sh

## Install firefox and chrome browser
RUN $INST_SCRIPTS/firefox.sh

## Install xfce UI
# RUN $INST_SCRIPTS/xfce_ui.sh && apt-get update && \
#     apt-get install -y --no-install-recommends dbus-x11 xauth supervisor xfce4-terminal x11-xserver-utils gnome-icon-theme &&\
#     gtk-update-icon-cache &&\
#     rm -rf /var/lib/apt/lists/*
ADD ./src/common/xfce/ $HOME/

# ## Install numpy (for xfce) and pip
# RUN apt-get update && apt-get install -y python

RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py && python get-pip.py && python -m pip install numpy && rm get-pip.py

## Configure startup and desktop
RUN $INST_SCRIPTS/libnss_wrapper.sh
ADD ./src/common/scripts $STARTUPDIR
ADD ./src/desktop $HOME/Desktop
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME $HOME/Desktop

# Deleted upto clean

# Clean
RUN apt-get update && apt-get autoremove -y && apt-get autoclean -y
ENV ROS_LOG_DIR=$HOME/Desktop/logs_ros

USER $USER

# Expose Tensorboard
EXPOSE 6006

# Expose Jupyter 
EXPOSE 8888

# Expose ROS
EXPOSE 9090

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]