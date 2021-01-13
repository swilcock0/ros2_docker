# ros2_docker

### My docker builds for development with ROS2
Incremental docker build going base->moveit_update->moveit_bridge. To run, use 

```cmd
docker run -rm -d -p 5901:5901 -p 6901:6901 -p 9090:9090 -e VNC_PW={YOUR_PASSWORD} swilcock0/ros2_ubuntu
```

Then you can visit [http://localhost:6901/vnc.html](http://localhost:6901/vnc.html), or use a VNC viewer with port 5901 to access the ROS2 desktop.

Tools included in the build:

- Gazebo11
- [Moveit2](https://github.com/ros-planning/moveit2) for motion planning and control
- [Forked](https://github.com/swilcock0/ros2-web-bridge) version of [ros2-web-bridge](https://github.com/RobotWebTools/ros2-web-bridge) which allows easy JSON control of ROS2 from the host


It's a pretty large final image for development use. Based roughly on [henry2423/docker-ros-vnc](https://github.com/henry2423/docker-ros-vnc)
