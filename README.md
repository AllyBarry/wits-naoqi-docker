# NAOqi Full Development Environment with Docker
This Docker image enables a user to interact with the Pepper robot using the NAOqi Python SDK or Choregraphe Suite (support for additional SDKs to be added).

These tools have very specific architectural requirements and using a container makes setup faster and hassle-free.
After running the container, one can use the /src folder in their local PC to develop, as they would normally, as this folder is mounted in the container.

Wits' NAOqi robot has the following details:
- NAOqi version: 2.5.10.7

Which requires:
- Python version 2.7
- Choregraphe 2.5.10.7 (requiring Ubuntu 16)

This repository currently only includes support for the Python SDK.
Other interfaces include:
- C++ SDK
- Java SDK
- JavaScript SDK
- ROS

**Note** that you will need to retrieve the following from the Wits RAIL Lab:
- RAIL Lab WiFi connection details
- License key for Choregraphe
- Installation files

### Useful links
[NAOqi Getting Started Documentation](http://doc.aldebaran.com/2-5/getting_started/index.html)

[NAOqi Python SDK](http://doc.aldebaran.com/2-5/dev/python/intro_python.html) running in a Docker container. The directory `./src` is mapped in the container and real-time updated, so you can develop your code on your host machine and run it from the Docker container.

[Choregraphe Documentation](http://doc.aldebaran.com/2-5/software/choregraphe/index.html)


## Connecting directly to the NAOqi
Turn the NAOqi on using the button directly under its screen.
You can connect directly to it using WiFi as it has been configured to connect to the RAIL Lab network. Its address should be `192.168.1.5` but if this does not work, you can click its on button once and it should tell you the address.
Retrieve the login details from the Pepper Discord channel.

If the connection does not work, refer to the Getting Started documentation.

### GUI
Navigate to `192.168.1.5` in your browser and enter the login details.

### Terminal
From a terminal, you can connect to Pepper using:
`ssh nao@192.168.1.5`
and entering the password.

You can find the source code in: `/opt/aldebaran/`

## Prerequisites

- [Docker](https://www.docker.com)
- Windows X Server, such as [VcXsrv](https://vcxsrv.com/)
If you are running this from a Windows PC you may need X Server to use the graphical user interface.
Before running the Docker container, you must allow connections to X server using the commands:
```
# Before:
xhost +local:docker

# When complete:
xhost +local:docker
```


## Installation

1. Clone this repo and move into the directory.

2. Download the relevant installation files (download links to be added...). These include:
- choregraphe-suite-2.5.10.7-linux64-setup.reun
- naoqi-sdk-2.8.5.10-linuc64.tar.gz
- pynaoqi-python2.7-2.8.6.23-linux64...tar.gz

3. Build the container `docker build -t wits-naoqi .`
4. Run the container using the script `run_container.sh`. It should be run from the root of the repository. This will open an interactive bash terminal.
If you need to open additional terminals, you can use the command: `docker exec -it wits_pepper bash`. 
> Don't forget to set up xhost if you are on Windows and want to use the Choregraphe GUI

### Installing Choregraphe
From the interactive terminal, run the Choregraph installation wizard: 
1. From the home directory, run:
```
./choregraphe/choregraphe-suite-2.5.10.7-linux64-setup.run
```
2. Follow the installation wizard through until completion. You can select `/home/nao/choregraphe` as the installation directory. You will need to enter the license key.
If all goes well, you should have the Choregraph GUI running on your PC.

You can connect to Pepper using the connection icon and Pepper's IP address.

### Python SDK
Once in the interactive terminal, you can test that the Python SDK has been loaded successfully with an example such as:
```
from naoqi import ALProxy
tts = ALProxy("ALTextToSpeech", "<IP of your robot>", 9559)
tts.say("Hello, world!")
```
Running these lines should result in Pepper speaking out "Hello, world!"

## Demos & Usage
### Using the NAOqi web-based GUI
Instruct Pepper to say words using the textbox on its web-based GUI (as per the direct connection instructions)

### Interacting Directly with the NAOqi
You can speak directly to Pepper as it has some pre-loaded functionality.

Some verbal commands that are loaded:
- "close hand"
- "raise arm"
- "look left/right"
- "stop looking at me"
- "shake hand"

Physical actions:
- Stroke its head and it should purr or speak.
- Hold your hand over its' front camera (forehead) and it will go to sleep.

### Terminal commands:
After connecting to Pepper (as per the terminal connection instructions), the *qicli* interface can be used.
More details can be found in the documentation: [qicli Guide](http://doc.aldebaran.com/2-5/dev/libqi/guide/qicli.html)

Pre-loaded commands can be used, such as:
```
say "How are you?"
```

### Using Choregraphe
You can launch some of Pepper's pre-loaded behaviours using the Choregraphe GUI or import some of the samples in this repository. You can find these files under: `/home/nao/naoqi/samples`.
1. Once connected to Pepper in the Choregraphe GUI, look for the 'Robot applications' section.
2. From there, you can trigger pre-loaded behaviours or import new ones.
