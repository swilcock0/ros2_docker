docker build -t swilcock0/ros2_ubuntu:latest . 
Write-Output "Done!"
docker build -t swilcock0/ros2_ubuntu:course -f ./tag_course/Dockerfile .
Write-Output "DONE!!"
pause
