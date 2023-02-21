# Create your custom ubuntu image here, based of official ubuntu image
FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    build-essential qemu-system-i386 gdb libfl-dev \
    qemu-system-gui \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Libcanberra and the sources for the locales
RUN apt-get update \ 
    && apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Generate locales for en_US.UTF-8
RUN locale-gen en_US.UTF-8
# Set up the default locale to en_US.UTF-8
ENV LANG=en_US.UTF-8

# Fix dbind warning about registering with the accessibility bus 
# ENV NO_AT_BRIDGE=1

# Create directory
RUN mkdir /opt/cross
WORKDIR /opt/cross

# Install Toolchain
RUN wget https://github.com/YoussefRaafatNasry/fos-v2/releases/download/toolchain/i386-elf-toolchain-linux.tar.bz2 --no-check-certificate \
    && tar xjf i386-elf-toolchain-linux.tar.bz2 \
    && rm i386-elf-toolchain-linux.tar.bz2

# Update your PATH in your ~/.bashrc file.
RUN echo 'export PATH="$PATH:/opt/cross/bin"' >> ~/.bashrc

# Install GIT version control
RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

# Clone FOS repository
ENV HOME /root
RUN git clone https://github.com/EngMohamedRaafat/fos-v2.git ${HOME}/fos-v2
WORKDIR ${HOME}/fos-v2
