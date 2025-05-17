#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images

#Install cachy addons
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons
dnf5 -y install \
    scx-scheds
dnf5 -y copr disable bieszczaders/kernel-cachyos-addons

# this installs a package from fedora repos
dnf5 install -y steam-devices corectrl goverlay

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
