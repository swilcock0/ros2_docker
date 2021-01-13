@echo off
docker build -t swilcock0/ros2_ubuntu:base .\base\.

if %errorlevel% neq 0 exit /b %errorlevel%

docker build -t swilcock0/ros2_ubuntu:moveit .\moveit_update\.

if %errorlevel% neq 0 exit /b %errorlevel%

docker build -t swilcock0/ros2_ubuntu:moveit_bridge .\moveit_bridge\.

if %errorlevel% neq 0 exit /b %errorlevel%

docker image tag swilcock0/ros2_ubuntu:moveit_bridge swilcock0/ros2_ubuntu:latest

if %errorlevel% neq 0 exit /b %errorlevel%

nircmd beep 450 2000
pause
docker push swilcock0/ros2_ubuntu

echo Done!