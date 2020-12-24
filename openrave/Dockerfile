FROM personalrobotics/ros-openrave

USER 0

RUN apt-get update &&\
    apt-get install ros-indigo-moveit-kinematics ros-indigo-collada-urdf -y &&\
    rm -rf /var/lib/apt/lists/*

RUN cd / &&\
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py &&\
    python get-pip.py &&\
    pip install --ignore-installed sympy==0.7.1

RUN pip install scipy

ADD ./create_analytical_ik.sh /bin/create_analytical_ik.sh

ENTRYPOINT [ "/bin/bash" ]