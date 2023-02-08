# Create your custom ubuntu image here, based of official ubuntu image
FROM ubuntu

# Install required packages
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    build-essential qemu-system-i386 gdb libfl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create directory
RUN mkdir /opt/cross
WORKDIR /opt/cross

# Update your PATH in your ~/.bashrc file.
RUN echo 'export PATH="$PATH:/opt/cross/bin"' >> ~/.bashrc

# Install Toolchain
RUN wget https://github.com/YoussefRaafatNasry/fos-v2/releases/download/toolchain/i386-elf-toolchain-linux.tar.bz2 --no-check-certificate \
    && tar xjf i386-elf-toolchain-linux.tar.bz2 \
    && rm i386-elf-toolchain-linux.tar.bz2

RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /root

RUN git clone https://github.com/EngMohamedRaafat/fos-v2.git ${HOME}/fos-v2

WORKDIR ${HOME}/fos-v2

RUN apt update && apt install -y qemu-system-gui \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \ 
    && apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module

# Installing the sources for the locales
RUN apt-get install -y locales
# locale-gen generates locales for en_US.UTF-8
RUN locale-gen en_US.UTF-8
# Setting up the default locale to en_US.UTF-8
ENV LANG=en_US.UTF-8
