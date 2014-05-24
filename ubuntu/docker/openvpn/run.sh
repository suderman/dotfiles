#!/bin/bash

# Build
docker build -t="suderman/openvpn" .

# Server
docker run -d --privileged --net host -v /data/openvpn:/etc/openvpn suderman/openvpn

# Client
docker run -it -p 8080:8080 -v /data/openvpn:/etc/openvpn suderman/openvpn serveconfig

