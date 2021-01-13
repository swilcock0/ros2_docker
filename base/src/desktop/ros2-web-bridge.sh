#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source /opt/ros/foxy/setup.bash
source /home/ros/ros2_ws/install/setup.bash
source /home/ros/moveit_ws/install/setup.bash
source /home/ros/ros2api/install/setup.bash
source /home/ros/ros2_control_ws/install/setup.bash
cd ~/ros2-web-bridge/bin
nvm use 11.0.0

node rosbridge.js -l info