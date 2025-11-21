#!/bin/bash

set -ouex pipefail

#Install cachyos scx-scheds
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons && \
dnf5 -y install \
	scx-scheds && \
dnf5 -y copr disable bieszczaders/kernel-cachyos-addons && \
dnf5 clean all

#Install latest mesa drivers from xxmitsu:mesa-git
dnf5 -y copr enable xxmitsu/mesa-git
dnf5 -y config-manager setopt copr:copr.fedorainfracloud.org:xxmitsu:mesa-git.priority=98

OVERRIDES=(
    "mesa-dri-drivers"
    "mesa-filesystem"
    "mesa-libEGL"
    "mesa-libGL"
    "mesa-libgbm"
    "mesa-va-drivers"
    "mesa-vulkan-drivers"
)

dnf5 distro-sync -y --repo='copr:copr.fedorainfracloud.org:xxmitsu:mesa-git' "${OVERRIDES[@]}"
dnf5 versionlock add "${OVERRIDES[@]}"
dnf5 -y copr disable xxmitsu/mesa-git

# Install packages
dnf5 -y install \
	steam-devices \

#Remove unwated packages
dnf5 -y remove \
    firefox \
    firefox-langpacks

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

dnf5 clean all
rm -rf /tmp/* || true
rm -rf /var/log/dnf5.log || true
rm -rf /boot/* || true
rm -rf /boot/.* || true

ostree container commit