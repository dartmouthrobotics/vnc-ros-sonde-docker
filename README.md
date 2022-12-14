# ROS-SONDE converter on Mac/Windows
This repo contains docker module that automatically change `.bag` data into `.csv` by running (1) rosbag play (2) converter harness. This is designed for non-computer scientists and roboticists so that people can easily run in a single shot.

## Contributor
* Mingi Jeong
* Alberto Quattrini Li

![structure](images/vnc-ros-sonde-docker.png)

```
.
├── bagfile
├── docker-compose.yml
├── Dockerfile
├── images
├── LICENSE
├── novnc.env
├── ros.env
└── workspace
    └── src
        ├── time_sync_bag_to_csv
        └── ysi_exo

```

## Prerequisite

Before following the next two steps, install Docker ([installation instructions for Mac](https://docs.docker.com/docker-for-mac/install/) or [for Windows](https://docs.docker.com/docker-for-windows/install/#system-requirements-for-wsl-2-backend)).


## 1. Setup
Open a new terminal in the Mac or PowerShell in Windows.
1. Once the terminal is open, clone this repository with the command `git clone https://github.com/dartmouthrobotics/vnc-ros-sonde-docker.git`
2. Enter in the cloned repository folder, `cd vnc-ros-sonde-docker`
3. Run `git submodule init` (only first time)
4. Run `git submodule update --recursive` (only first time)
5. Run `docker-compose build`

(`ros.env` contains environment variables for ROS that can be modified before running the command in step 3. No need to change it for biologists)

Once the other terminal shows the following type of messages

    Starting mac-ros_novnc_1 ... done
    Starting mac-ros_ros_1   ... done

## 2. Entering  the container
On the same terminal you built,
1. Run `docker-compose up`
open another terminal:
2. Run `docker-compose exec ros bash` (`docker-compose up` has to be running)
3. On the same terminal, run `source /opt/ros/melodic/setup.bash`
4. Run `find /root/catkin_ws/src -type f -exec dos2unix '{}' '+'` (only first time)
5. `cd /root/catkin_ws` and `catkin_make`
6. `source /devel/setup.bash`
7. `cd /root/catkin_ws/src/time_sync_bag_to_csv/nodes`
8. `chmod +x convert_harness` and `chmod +x csv_converter`


## 3. Data preparation and conversion
1. copy one bag file into `bagfile` folder inside `vnc-ros-sonde-docker`.
2. `vnc-ros-sonde-docker` --> `workspace` --> `src` --> `time_sync_bag_to_csv` --> `param` --> change the information
    * update the `bag_file_name` to be convereted
    * update `sonar` true or false according to the usage of Catabot2, Catabot3 or box

3. On the same terminal, run `roslaunch time_sync_bag_to_csv harness.launch` and you should see a number of messages, including `[INFO] data saving! file location`. As long as the time is ticking, it is going on. The conversion takes the same amount of the deployment.

## 4. To terminate

1. In the terminal open for step 2., press ctrl+c, which will stop the execution of the simulator. Once that is stopped -- you should see it as the terminal can accept commands -- press ctrl+d to exit the Docker container.

2. Afterwards, in the terminal open for step 1., press ctrl+c. Once terminated, you should see the following messages

    Stopping mac-ros_ros_1   ... done
    Stopping mac-ros_novnc_1 ... done

3. Run `docker-compose down` (Make sure you are inside `vnc-ros-sonde-docker` before doing this)

At this point, both terminals can be closed if you wish.

## 5. from 2nd time usage
1. copy bag file to `bagfile` folder
2. `docker-compose up` as per step 2
3. `docker-compose exec ros bash` as per step 2
4. source workspace bash as per step 2.
5. roslaunch as per step 3.

## Editing your workspace (not for limno)
The workspace folder that gets created on your machine by `docker-compose` is where you can write and edit your packages. It maps to `~/catkin_ws` on the Docker container. However, if you want to run `catkin_make`, do so by creating a bash via `docker-compose exec ros bash` and running `catkin_make` in `/catkin_ws`.

## Installing other packages (not for limno)
Edit the `Dockerfile` line that installs packages and rebuild the container using `docker-compose build`.

## TODO
1. multiple bags