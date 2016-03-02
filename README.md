# docker-armhf-rust-cc

A Docker image that builds an ARM binary from the Rust Cargo project in the current directory.  
This way you don't need to install all build dependencies such as the ARM
compiler on your machine.  

Tested on Mac OSX compiling a binary for Raspberry Pi 2.


### Usage

```
cd /path/to/your/cargo/project
docker build --no-cache -t mre0/armhf-rust-cc .
# To extract the cargo target folder from the container
# you can create a shell script from these commands:
containerID=$(docker run --detach mre0/armhf-rust-cc)
docker cp $containerID:/project/target target
docker rm $containerID
```
