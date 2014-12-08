# docker-counterclockwise

[Counterclockwise](http://doc.ccw-ide.org/) version 0.31.1 in Ubuntu 14.04.1 with Oracle Java 8u25. 

## Requirements

* Docker 1.2+
* An X11 socket

## Quickstart
I decided to split Counterclockwise dockerization in three `Dockerfile`s

1. `ubuntu.docker` enriches base ubuntu 14.04.1 image available at https://registry.hub.docker.com/_/ubuntu/
2. `java.docker` starts from `ubuntu.docker` and installs java 8u25
3. `Dockerfile` picks up from where `java.docker` left and installs gtk dependencies and Counterclockwise itself

Due to this containerization, and to the naming chosen, to build the counterclockwise container run:

```
sudo docker build --rm -t mdavi/ubuntu.base:14.04.1 - < ubuntu.docker && \
sudo docker build --rm -t mdavi/java8:8u25 - < java.docker && \
sudo docker build --rm -t mdavi/counterclockwise:0.31.1 .
```

To run the IDE execute (change `/somewhere` to whichever location you like to mount the volume for keeping your workspace on your host machine and `somewhereelse` to the location where you want to configuration, plugins and dependencies):

```
sudo docker run --rm -it -e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /somewhere:/workspace \
	 -v /somewhereelse:/home/developer \
	mdavi/counterclockwise:0.31.1
```

## TODO

The generated container is absolutely too big, I would really like to compress it a bit. But to achieve this goal, I should study Docker more!
Also, I need to improve `Dockerfile`
