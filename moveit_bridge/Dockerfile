FROM swilcock0/ros2_ubuntu:moveit

LABEL maintainer "Sam Wilcock/swilcock0"

USER root

ENV DEBIAN_FRONTEND=noninteractive

USER 1000

# Install NVM and node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash &&\
    echo "export NVM_DIR='$HOME/.nvm'" >> ~/.bashrc &&\
    echo "[ -s '$NVM_DIR/nvm.sh' ] && \. '$NVM_DIR/nvm.sh'" >> ~/.bashrc &&\
    echo "[ -s '$NVM_DIR/bash_completion' ] && \. '$NVM_DIR/bash_completion'" >> ~/.bashrc &&\
    chmod +x ~/.nvm/nvm.sh

# Install ros2-web-bridge
RUN /bin/bash -c ". ~/.nvm/nvm.sh &&\
    nvm install 12.16.1"
 
RUN cd ~ &&\
    git clone https://github.com/swilcock0/ros2-web-bridge.git

RUN /bin/bash -c ". /opt/ros/foxy/setup.sh &&\
    . ~/.nvm/nvm.sh &&\
    cd ros2-web-bridge &&\
    npm install"

# Install ros2api
RUN mkdir -p ~/ros2api/src &&\
    git clone https://github.com/swilcock0/ros2api.git ros2api/src &&\
    cd ~/ros2api &&\
    . /opt/ros/foxy/setup.sh &&\
    colcon build

# Clean generated messages
RUN rm -rf /home/ros/ros2-web-bridge/node_modules/rclnodejs/generated

ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait"]