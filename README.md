# podman-openjdk-el7

Builds the **java-17-openjdk-17.0.4.1.1-2.el7** rpms for Centos 7 systems

This was done by modifying the ```java-17-openjdk``` Rocky Linux 8 SRPM to make it compatible for Centos 7 systems.

**Fedora package install**
```
dnf install podman python3-podman python3-pydbus python3-termcolor
```

**non-interactive auto build**
```
# create podman image and run the container
./script-podman.py --auto
```

**interactive build**
Useful if you need to modify the SRPM, troubleshoot an issue, test out the environment...etc
```
# create podman image and run the container
./script-podman.py

# then login to the container with:
podman exec -it jdk_builder /bin/bash

# build the openjdk rpms and copy them to the shared volume output_rpms/
./scripts/01-build.openjdk.sh

# logout of the container with
Control+D or exit
```

**the RPM's will now be found under output_rpm/**
```
[leif.liddy@black podman-jdk-el7]$ ll output_rpm/
total 467316
-rw-r--r--. 1 leif.liddy leif.liddy  64249670 Oct  7 00:01 java-17-openjdk-17.0.4.1.1-2.el7.src.rpm
-rw-r--r--. 1 leif.liddy leif.liddy    794476 Oct  7 00:01 java-17-openjdk-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy   3572528 Oct  7 00:01 java-17-openjdk-demo-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy   5342336 Oct  7 00:01 java-17-openjdk-devel-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy  53281596 Oct  7 00:01 java-17-openjdk-headless-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy  16899292 Oct  7 00:01 java-17-openjdk-javadoc-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy  42174756 Oct  7 00:01 java-17-openjdk-javadoc-zip-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy 241764396 Oct  7 00:01 java-17-openjdk-jmods-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy  47488816 Oct  7 00:01 java-17-openjdk-src-17.0.4.1.1-2.el7.x86_64.rpm
-rw-r--r--. 1 leif.liddy leif.liddy   2945868 Oct  7 00:01 java-17-openjdk-static-libs-17.0.4.1.1-2.el7.x86_64.rpm
```

**script-podman.py options**
these should be pretty self-explanatory
```
usage: script-podman.py [-h] [--auto] [--debug]
                        [--rebuild | --rerun | --restart | --rm_image | --rm_container | --stop_container]

options:
  -h, --help        show this help message and exit
  --auto            ensure image is built, then run container_script in a non-interactive container
  --debug           display debug messages
  --rebuild         remove podman image and container if they exist, then build (new) podman image and run container
  --rerun           remove container if it exists, then (re-)run it
  --restart         stop the container if it exists, then (re-)run it
  --rm_image        remove podman image and container if they exist
  --rm_container    remove container if it exists
  --stop_container  stop podman container it exists and is running
```
