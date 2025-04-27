![](https://github.com/ayogun/42-project-badges/blob/main/badges/inceptionm.png?raw=true)

![42 Badge](https://img.shields.io/badge/42-Project-blue)  
![](https://img.shields.io/github/languages/code-size/rpdjf/42-Inception?color=5BCFFF)

![](https://img.shields.io/badge/Linux-0a97f5?style=for-the-badge&logo=linux&logoColor=white)
![](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)

# 🏗️ 42_Inception 🏗️
Ahoy, coding adventurers! Welcome to **42_Inception**, a project designed to help you set up your very own virtualized environment with Docker, all in the name of learning. This project is an introduction to containerization, Dockerfile creation, and managing multi-container systems for development environments. 🚀

## What’s Inception? 🤔
42_Inception is your own custom virtualized environment built using Docker. It allows you to set up a variety of services such as databases, web servers, and more in isolated containers. It's an essential project for mastering container-based development workflows! 🖥️🌍

## Cloning the Repository 🛠
Ready to begin? Clone the repository with:
```bash
git clone https://github.com/rpdjf/42-Inception.git
```

## Building & Running Inception 🚀
To run the project, make sure you have docker & docker compose installed.

You may also need openssl tools, since i am using host self signed SSL (makes more sense for me, my dockerfiles are generalized, no specific config inside)
```bash
make
```

Services will be available at:
- https://rude-jes.42.fr - wordpress website through nginx
- https://ruinformatique/ - my own tailwind website through nginx
- https://adminer/ - adminer php through nginx
- https://qbittorrent/ - a torrent webclient
- ftp://127.0.0.1:21 - a ftp server

Default credentials are stored in  `srcs/secrets/creds.txt`

They can be changed by editing `srcs/.env` or `srcs/.env.example` if .env wasn't created yet

## Stopping the containers
Containers can simply be stoped by either:
```bash
make clean
```
or
```bash
make down
```

Both of them will simply stop the containers. `make down` will print the containers being shut down.

## Cleaning inception
When you finished playing around with 42-Inception, you can wipe it from your system simply by running:
```bash
make fclean
```

It will wipe out any change made by inception