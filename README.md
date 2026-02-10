# PSFree Web Host - Development Source

A lightweight local web server for hosting the PSFree exploit with latest GoldHEN

<p align="center">
  <img src="https://raw.githubusercontent.com/HVR88/PSFree_DEV/develop/extras/icon.png" alt="PSFree Web Host" />
</p>

PSFree_Docker is based on [PSFree from Nazky](https://github.com/Nazky/PSFree)

**_This is the source repo to build the PSFree project - you probably want the below instead:_**

> [!IMPORTANT]
>
> **_For the premade Docker container, visit the Docker Repo: https://github.com/HVR88/PSFree_Docker_**

### About this project

- **Updated to latest (Jan 2026) GoldHEN 2.4b18.8**
- Multi-Architecture: amd64 and arm64 support
- _Web server drops paths/text from URL - "Just Works" on PS4_
- _Updated to allow running default http port 80_
- Automatic build action pushes container to Docker hub
- Build versioning for repo and docker container
- Docker compose with instructions and exmaple defaults
- Unraid template for manual installation and deployment to Unraid Community Apps
- Unraid Docker 'app' icon

## Requirements to fork this repo

You need to configure the following two secrets in your GitHub account to automatically push your build to Docker Hub

- DOCKERHUB_USERNAME (this is your normal Docker Hub login username)
- DOCKERHUB_TOKEN (you need to generater this at Docker Hub)
