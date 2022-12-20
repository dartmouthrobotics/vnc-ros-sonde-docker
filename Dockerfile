FROM osrf/ros:melodic-desktop-full
USER root

RUN apt-get -y update && apt-get install -y \
    curl

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

RUN apt-get -y update && apt-get install -y \
    iputils-ping \
    net-tools \
    wget \
    screen \
    git \
    nano \
    vim \
    htop \
    dos2unix \
    python-simplejson \
    ros-melodic-joy \
    ros-melodic-teleop-twist-joy \
    ros-melodic-teleop-twist-keyboard \
    ros-melodic-laser-proc \
    ros-melodic-rgbd-launch \
    ros-melodic-depthimage-to-laserscan \
    ros-melodic-rosserial-arduino \
    ros-melodic-rosserial-python \
    ros-melodic-rosserial-server \
    ros-melodic-rosserial-client \
    ros-melodic-rosserial-msgs \
    ros-melodic-amcl \
    ros-melodic-map-server \
    ros-melodic-move-base \
    ros-melodic-urdf \
    ros-melodic-xacro \
    ros-melodic-compressed-image-transport \
    ros-melodic-rqt-image-view \
    ros-melodic-gmapping \
    ros-melodic-navigation \
    ros-melodic-interactive-markers \
    ros-melodic-turtlebot3-gazebo \
    ros-melodic-mavros \
    ros-melodic-mavros-msgs

# git install
RUN apt-get install git -y
RUN mkdir -p /root/catkin_ws/src
RUN mkdir -p /root/bagfile
WORKDIR /root/catkin_ws
# RUN /bin/bash -c 'git submodule update --recursive'
RUN echo "source /opt/ros/melodic/setup.sh" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
RUN echo "defshell -bash" >> ~/.screenrc
WORKDIR /root/catkin_ws/src
RUN /bin/bash -c 'find /root/catkin_ws/src -type f -exec dos2unix '{}' '+''
RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash; cd /root/catkin_ws; catkin_make'
