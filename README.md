# wazuh-dev

This project aims to facilitate the development and testing of Wazuh features by deploying simulated environments through a simple graphical interface with no dependencies other than the desired virtualization mechanism.

## How to use

Just execute the `deploy.sh` script and configure the environment from the graphical menu.


If you wish, you can deploy the environment from a non-interactive way by modifying the `settings` file.

``` BASH
# Virtualization provider
VIRT_TYPE="docker"

# Wazuh installation
INSTALLATION_TYPE="agent"
BRANCH="v3.9.5"

# OS image options
OS_NAME="ubuntu"
OS_VERSION="16.04"
CREATE_IMAGE_IF_NECESSARY="YES"

# Run options
RO_DEBUG=1 #1, 2, NONE
RO_PROTOCOL=UDP  #UDP or TCP
RO_SHARED_FOLDER=NONE  #NONE OR A VALID PATH
RO_MANAGER_IP=172.18.0.57
RO_AUTHD_IP=172.18.0.57
```

## Supported virtualizations

These are the virtualization types currently supported. The list will be expanded.

|| Docker | VMware | VirtualBox |
|-|-|-|-|
**Ubuntu 16.04** | Supported | `Still not supported` | `Still not supported` |
**Centos 6** | Supported | `Still not supported` | `Still not supported` |
**Centos 7** | Supported | `Still not supported` | `Still not supported` |

## Login to docker containers

This repository also provides a simple graphical tool to access the running docker containers.

``` BASH
docker_attach.sh
```

## Contribute

Do you want to add any functionality to the project? Feel free to send a pull request. You can also open an issue to contribute ideas or report bugs.