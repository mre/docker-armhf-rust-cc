FROM scorpil/rust:1.6
MAINTAINER Matthias Endler <matthias-endler@gmx.net>

# Install ARM compiler for Debian Jessie based systems
RUN echo "deb http://emdebian.org/tools/debian/ jessie main" > /etc/apt/sources.list.d/crosstools.list \
    && curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | apt-key add - \
    && dpkg --add-architecture armhf \
    && apt-get update \
    && apt-get install -y crossbuild-essential-armhf

# Install Rust standard library for ARM
WORKDIR /tmp
RUN mkdir rust-standard-arm \
    && cd rust-standard-arm/ \
    && curl -O http://static.rust-lang.org/dist/rust-std-1.6.0-arm-unknown-linux-gnueabihf.tar.gz \
    && tar xzf rust-std-1.6.0-arm-unknown-linux-gnueabihf.tar.gz \
    && cd rust-std-1.6.0-arm-unknown-linux-gnueabihf \
    && ./install.sh --prefix=$(rustc --print sysroot) \
    && cd ../.. \
    && rm -rf rust-standard-arm/

# Configure cargo for cross compilation
RUN mkdir -p ~/.cargo \
    && echo '[target.arm-unknown-linux-gnueabihf]\n\
linker = "arm-linux-gnueabihf-gcc"\n'\
>> ~/.cargo/config

# Mount your code into the following directory
# to compile it for ARM at build time
ADD . /project
WORKDIR /project

RUN cargo build --verbose --release --target=arm-unknown-linux-gnueabihf
