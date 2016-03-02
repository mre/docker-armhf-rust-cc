# docker-armhf-rust-cc

A Docker image that builds an ARM binary from the Rust Cargo project in the current directory.  
This way you don't need to install all build dependencies such as the ARM
compiler on your machine.  

Tested on Mac OSX compiling a binary for Raspberry Pi 2.


### Usage

```
cd /path/to/your/cargo/project
docker build --no-cache -t mre0/armhf-rust-cc .
# Extract the cargo target folder from the container
./extractbin.sh
```
