# Supported tags and respective `Dockerfile` links

- [`latest`](https://github.com/EngMohamedRaafat/fos-container/blob/main/Dockerfile)

# What is FOS?

[FOS][fos-v1] (**F**CIS **OS**) is an educational OS for Ain Shams University Operating Systems Course CSW355, forked and refactored from [MIT Operating Systems Lab 6.828][mit-6.828].

[fos-v1]: https://github.com/mahossam/FOS-Ain-Shams-University-Educational-OS
[mit-6.828]: http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-828-operating-system-engineering-fall-2012/

# How to use this image

These instructions will cover usage information for the FOS container

## Prerequisities

In order to run this container you'll need docker installed.

- [Windows](https://docs.docker.com/windows/started)
- [OS X](https://docs.docker.com/mac/started/)
- [Linux](https://docs.docker.com/linux/started/)

For Windows, you'll need to install X Server as well:

- VcXsrv Windows X Server:

  [SourceForge Link](https://sourceforge.net/projects/vcxsrv/)
  or
  [MEGA Link](https://mega.nz/file/1cclkR6A#vuAQYHjbOL0nu_H9kcUXkDZwe-tGtsFIAJ34EHbN4lE)

## Usage

### Container Parameters

#### For Windows:

```console
# start VcXsrv in background
$ & $env:ProgramFiles\VcXsrv\VcXsrv.exe -multiwindow -clipboard -wgl

$ docker run -it -d --name fos-container -e DISPLAY=host.docker.internal:0.0 mohamedraafat/fos:latest
```

#### For Linux:

```console
$ docker run -it -d \
    --name fos-container \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    mohamedraafat/fos:latest

# add the container's hostname to the local family's list of permitted names to open up xhost only to the container's host
$ xhost +local:$(docker container inspect --format '{{ .Config.Hostname }}' fos-container)
```

[![Try in PWD](https://github.com/play-with-docker/stacks/raw/cff22438cb4195ace27f9b15784bbb497047afa7/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/docker-library/docs/9efeec18b6b2ed232cf0fbd3914b6211e16e242c/postgres/stack.yml)

### Environment Variables

- `DISPLAY` - Screen id to display X (graphical) applications on. This instructs X clients (your graphical programs) which X server to connect to. (it tells GUI programs where to send their output)

### Volumes

- `/tmp/.X11-unix` - The default directory for X socket on linux host and docker containers.

## Built With

- QEMU
- i386 elf toolchain
- FOSv2

## Links

- [Image source](https://github.com/EngMohamedRaafat/fos-container)
- [The version of FOS supported within this image](https://github.com/EngMohamedRaafat/fos-v2)

## Authors

- [**Mohamed Raafat**](https://github.com/EngMohamedRaafat)

## Acknowledgments

- This project was originally developed based on FOS v2 thanks to [Youssef Raafat](https://github.com/YoussefRaafatNasry) and [contributors](https://github.com/YoussefRaafatNasry/fos-v2/graphs/contributors) who
  participated in this project.
