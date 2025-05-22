# NAOqi Docker Development Environment

A Docker container for developing applications for the Pepper robot using the NAOqi Python SDK and Choregraphe Suite. This containerized approach eliminates complex setup requirements and provides a consistent development environment.

## System Requirements

**Wits NAOqi Robot Specifications:**
- NAOqi 2.5.10.7
- Python 2.7
- Choregraphe 2.5.10.7 
- Python NOAqi SDK 2.8.6.23
- Ubuntu 16

**Prerequisites:**
- [Docker](https://www.docker.com)
- Windows X Server (e.g., [VcXsrv](https://vcxsrv.com/)) for GUI applications on Windows

**Required from RAIL Lab:**
- WiFi connection details
- Choregraphe license key  
- Installation files

## Connecting directly to Pepper
Turn Pepper on using the button directly under its screen.
You can connect directly to it using WiFi as it has been configured to connect to the RAIL Lab network. Make sure you are connected to the RAL Lab network. Its address should be `192.168.1.5` but if this does not work, you can click its on button once and it should tell you the address.

**Network Details:**
- IP Address: `192.168.1.5` (press power button once if different)
- Credentials: Available in Pepper Discord channel

### Web Interface
Navigate to `192.168.1.5` in your browser and log in.

### SSH Access
```bash
ssh nao@192.168.1.5
```
Source code location: `/opt/aldebaran/`
Do not edit this.

## Docker Container Installation

### 1. Setup Repository
Clone this repository and navigate to the directory.

### 2. Download Installation Files
Obtain these files from the RAIL Lab and place them in the root of the directory:
- `choregraphe-suite-2.5.10.7-linux64-setup.run`
- `pynaoqi-python2.7-2.8.6.23-linux64.tar.gz`

### 3. Build and Run Container
```bash
# Build the container
docker build -t wits-naoqi .

# Run the container (use provided script)
./run_container.sh
```

- For additional terminals: `docker exec -it wits_pepper bash`
- To run a container in the background, edit the command to use `-d` instead of `-it`.

**Windows Users:** Enable X Server before running:
```bash
# Before running
xhost +local:docker
# Once complete
xhost -local:docker
```



## Software Setup
From within the interactive container, the installation can be completed with the following steps.

### Choregraphe Installation
1. You can run the installation wizard using:
   ```bash
   /choregraphe/choregraphe-suite-2.5.10.7-linux64-setup.run
   ```
   or use the simplified command:
   ```bash
   /choregraphe/choregraphe-suite-2.5.10.7-linux64-setup.run --mode unattended --installdir /home/user/choregraphe/
   ```
3. Enter the license key when prompted
4. If the installation is successful, the Choregraphe GUI should open.
5. Connect to Pepper using the connection icon and its IP address

To re-launch the program at any point:
```bash
# {Installation directory}/choregraphe
# E.g., from /home/user
./choregraphe/choregraphe
```
If you used the installation and Quick mode, the installation directory will likely be: `/opt/Softbank Robotics/Choregraphe Suite 2.5`.

### Python SDK Testing
Test the SDK installation:
```python
from naoqi import ALProxy
tts = ALProxy("ALTextToSpeech", "192.168.1.5", 9559)
tts.say("Hello, world!")
```
Running these lines should result in Pepper speaking out "Hello, world!"

## Demos & Usage Examples

### Using Pepper's Web Interface
Instruct Pepper to say words using the textbox on its web-based GUI (as per the direct connection instructions)


### Voice Commands
Pepper responds to these verbal commands:
- "close hand"
- "raise arm" 
- "look left/right"
- "stop looking at me"
- "shake hand"

### Physical Interactions
- **Head stroke:** Pepper purrs or speaks
- **Cover front camera:** Pepper goes to sleep

### Terminal Commands (via SSH)
Use the [qicli interface](http://doc.aldebaran.com/2-5/dev/libqi/guide/qicli.html) for direct API calls. Note that these are run from Pepper's direct connection SSH terminal, not via the Docker container. Some other commands that are pre-loaded include:
```bash
# You can type any words/sentences for Pepper to speak.
say "How are you?"
```

### Choregraphe GUI
1. Connect to Pepper in the Choregraphe GUI
2. Locate the 'Robot applications' section
3. Trigger pre-loaded behaviors or import samples from `/home/user/naoqi/samples`

## Development Workflow

The `./src` directory is mounted in the container and updates in real-time, allowing you to:
1. Develop code on your host machine
2. Run and test code from within the Docker container
3. Deploy to Pepper for testing

## Additional Resources

- [NAOqi Getting Started Guide](http://doc.aldebaran.com/2-5/getting_started/index.html)
- [Python SDK Documentation](http://doc.aldebaran.com/2-5/dev/python/intro_python.html)
- [Choregraphe Documentation](http://doc.aldebaran.com/2-5/software/choregraphe/index.html)
- [qicli Command Reference](http://doc.aldebaran.com/2-5/dev/libqi/guide/qicli.html)

## Supported SDKs
- ✅ Python SDK (included)
- ⏳ C++ SDK (planned)
- ⏳ Java SDK (planned)
- ⏳ JavaScript SDK (planned)
- ⏳ ROS (planned)