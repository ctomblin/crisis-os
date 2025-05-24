#!/bin/bash

set -ouex pipefail

#Install cachyos scx-scheds
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons && \
dnf5 -y install \
	scx-scheds && \
dnf5 -y copr disable bieszczaders/kernel-cachyos-addons && \
dnf5 clean all

# Install packages
dnf5 -y install \
	steam-devices \
	goverlay \

#Remove unwated packages
dnf5 remove -y firefox

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo