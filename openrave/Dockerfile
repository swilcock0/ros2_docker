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

RUN apt-add-repository ppa:imnmfotmal/libccd -y &&\
    apt-get update &&\
    apt-get install -y m4 libccd &&\
    curl -L https://github.com/Kitware/CMake/releases/download/v3.19.2/cmake-3.19.2-Linux-x86_64.sh -o /opt/cmake-19.2.sh &&\
    chmod +x /opt/cmake-3.19.2.sh &&\
    /opt/cmake-3.19.2.sh --skip-license --include-subdir &&\
    cd ~ &&\
    git clone https://github.com/flexible-collision-library/fcl.git &&\
    cd ~/fcl &&\
    git checkout 0.5.0 &&\
    mkdir -p ~/fcl/build &&\
    cd ~/fcl/build &&\
    /root/cmake-3.19.2/bin/cmake .. &&\
    make &&\
    make install

ENTRYPOINT [ "/bin/bash" ]