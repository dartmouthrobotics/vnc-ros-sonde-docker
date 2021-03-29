# ROS on Mac/Windows

Before following the next two steps, install Docker ([installation instructions for Mac](https://docs.docker.com/docker-for-mac/install/) or [for Windows](https://docs.docker.com/docker-for-windows/install/#system-requirements-for-wsl-2-backend)).

## 1. Setup
Open a new terminal in the Mac or PowerShell in Windows.
1. Once the terminal is open, clone this repository with the command `git clone https://github.com/quattrinili/vnc-ros`
2. Enter in the cloned repository folder, `cd vnc-ros`
3. Run `docker-compose up --build`

(`ros.env` contains environment variables for ROS that can be modified before running the command in step 3.)

## 2. Running a ROS gazebo simulation for testing
Once the other terminal shows the following type of messages 

    Starting mac-ros_novnc_1 ... done
    Starting mac-ros_ros_1   ... done

open another terminal:
1. Run `docker-compose exec ros bash` (`docker-compose up` has to be running)
2. Run `source /opt/ros/melodic/setup.bash`
3. Run `roslaunch turtlebot3_gazebo turtlebot3_world.launch` and you should see a number of messages, including `[ INFO] [1617035063.438483400, 0.126000000]: DiffDrive(ns = //): Advertise odom on odom `

To see whether it was successful, 
5. Open your browser to `localhost:8080/vnc.html` and click connect.
6. The robotic simulator is now running in your browser.

## 3. To terminate

In the terminal open for step 2., press ctrl+c, which will stop the execution of the simulator. Once that is stopped -- you should see it as the terminal can accept commands -- press ctrl+d to exit the Docker container.

Afterwards, in the terminal open for step 1., press ctrl+c. Once terminated, you should see the following messages

    Stopping mac-ros_ros_1   ... done
    Stopping mac-ros_novnc_1 ... done

At this point, both terminals can be closed if you wish.

## Editing your workspace
The workspace folder that gets created on your machine by `docker-compose` is where you can write and edit your packages. It maps to `~/catkin_ws` on the Docker container. However, if you want to run `catkin_make`, do so by creating a bash via `docker-compose exec ros bash` and running `catkin_make` in `/catkin_ws`.

## Installing other packages
Edit the `Dockerfile` line that installs packages and rebuild the container using `docker-compose build`.
