# Inception

## Project:
Inception focues on Docker and containerization. The goal of this project is to be familiarized with setting up Docker containers.

## Core features
- **NGINX** web server
- **WordPress and PHP-FPM** application
- **MariaDB** database
- **Docker Compose** for clarity in defining multi-container application

## Requirements
- Docker installed
- Docker Compose installed
- Basic understanding of Docker and containerization

## Usage
Before testing Inception, you need to download Docker and Docker Compose (if you can download Docker Desktop then it will have both).
Head to https://www.docker.com/products/docker-desktop to download Docker Destop. 
Once you have Docker installed, launch the application. 
Open the terminal and run:
```
docker --version
docker compose version
```
You should see similar output to these
```
Docker version 28.1.1, build 4eba377
Docker Compose version v2.35.1-desktop.1
```
Now you can git clone the project and enter the project directory and 
```
make
```

## Docker Commands
you can check the containers with
```
docker ps
```
Docker volumes:
```
docker volume ls
or
docker volume inspect <volume-name>
```
Interacting with Docker exec command to open the interactive terminal inside a Docker container for debugging, inspecting and manually interacting with the container
```
docker exec -it <image-name> sh
```

## Makefile commands

