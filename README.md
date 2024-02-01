# VPN Web Proxy

The "VPN Web Proxy" project provides a Docker-based solution for integrating a web proxy with VPN connectivity. It's designed to enable direct access to internal websites through a VPN connection and is compatible with a range of VPN services including Cisco VPN, NordVPN, and others.

## What is it?

A Docker container that combines a VPN client and an Nginx web proxy for secure, internal web access.

## Who uses this project?

Ideal for remote workers, IT professionals, and anyone needing to access internal networks securely.

## Where it is used?

In environments where internal websites are accessible only via a VPN.

## When is it necessary?

Essential in remote working scenarios or for accessing internal resources from outside a corporate network.

## Why was it developed?

To simplify the process of accessing internal web resources through a VPN.

# Summary

1. [Architecture](#architecture)
2. [Repository](#repository)
3. [Installation](#installation)
4. [Build](#build)
5. [Run](#run)
6. [Documentation](#documentation)

# Architecture

This section will detail the architecture of the project, including how the Docker container integrates the VPN client and Nginx web proxy, and their interaction with the external network.

# Repository

The repository consists of the following key components:

- **Dockerfile** - Defines the Docker image and its dependencies for running the VPN and web proxy.
- **nginx.conf** - Nginx configuration file set up as a reverse proxy.
- **vpn-connect.sh** - Script to manage Nginx and the logic for connecting to the VPN.

# Installation

To set up this project, you need:

- A machine capable of running Docker and Docker Compose.
- Dependencies: Docker, Docker Compose, and a compatible VPN client.

# Build

This section outlines the commands and steps required to build the Docker container.

# Run

You can run the application using Docker or Docker Compose. Here's an example Docker Compose setup:

```yaml
version: "3.8"

services:
  vpn-client:
    image: ghcr.io/relybytes/vpn-website-proxy:latest
    cap_add:
      - NET_ADMIN
    ports:
      - "18080:18080"
    environment:
      - VPN_URL= # VPN server URL
      - VPN_USER= # VPN username
      - VPN_PASS= # VPN password
      - PROXY_PASS_URL= # URL to proxy pass
      - PROXY_BASE_URL= # URL to proxy pass without ports (can be the same of proxy pass url)
      - PROXY_LISTEN_PORT=18080
```

or docker command:

```bash
docker run --name vpn-client -d \
  --cap-add NET_ADMIN \
  -p 18080:18080 \
  -e VPN_URL=YOUR_VPN_SERVER_URL \
  -e VPN_USER=YOUR_VPN_USERNAME \
  -e VPN_PASS=YOUR_VPN_PASSWORD \
  -e PROXY_LISTEN_PORT=18080 \
  -e PROXY_BASE_URL=YOUR_PROXY_BASE_URL \
  -e PROXY_PASS_URL=YOUR_PROXY_PASS_URL \
  ghcr.io/relybytes/vpn-website-proxy:latest -d

```

Wait one minute and go to `localhost:18080`

# Documentation

This section provides additional resources and documents related to the VPN-Aware Web Proxy project. It's a central repository for all the informational content that supports the understanding, implementation, and operation of the project.

## Reference Materials

- **Docker Documentation**: For understanding Docker and Docker Compose configurations, refer to the [official Docker documentation](https://docs.docker.com/).
- **Nginx Documentation**: To get more detailed information about Nginx configurations, visit the [official Nginx documentation](https://nginx.org/en/docs/).
- **VPN Client Documentation**: For specific details about the VPN clients supported (like Cisco VPN or NordVPN), refer to the respective official documentation of these services.

## Support

For additional support or queries regarding the project, you can refer to the issue tracker in the repository.

Remember, this project is a collaborative effort, and contributions to both the code and documentation are always welcome!
