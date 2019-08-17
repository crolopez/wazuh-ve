#!/bin/bash

# Load the UI functions
. config/ui_functions

# Enable or disable debug mod
DEBUG_MODE="yes"

# Choose Docker or Vagrant virtualization
ask_virt_type

# Choose manager or agent
ask_inst_type

# Choose OS
ask_os_name

# Choose OS version
ask_os_version

# Choose branch
ask_branch

# Check the availability of the image
check_image

# Check the run options
ask_run_options

# Run the instance
run_instance

exit 0
