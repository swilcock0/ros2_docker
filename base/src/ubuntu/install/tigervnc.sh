#!/usr/bin/env bash
set -e

echo "Install TigerVNC server"
wget -qO- https://github.com/TigerVNC/tigervnc/archive/refs/tags/v1.11.0.tar.gz | tar xz --strip 1 -C /

