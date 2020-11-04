docker build -t swilcock0/ros2_ubuntu:latest . 
Write-Output "Done!"

docker run --rm -it -d -p 5901:5901 -p 6901:6901 -p 8888:8888 -p 9090:9090 -v C:\Users\Sam\Desktop\Uni\_PhD\ROSBuilds\ros2_ws:/home/ros/ros2_ws -e VNC_PW=samrobot swilcock0/ros2_ubuntu -d
pause
Start-Process -FilePath "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe" -ArgumentList "-config","C:\Users\Sam\Documents\ROS2.vnc"
