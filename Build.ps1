docker build -t swilcock0/xfce_novnc -f ../xfce_novnc/Dockerfile .
pause
docker build -t swilcock0/ros2_ubuntu:latest . 
pause
docker build -t swilcock0/ros2_ubuntu:course -f ./tag_course/Dockerfile .
pause