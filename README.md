# CrisisOS 

A custom desktop Fedora Silverblue bootc gaming image combined with CachyOS kernel (for my own gaming needs). All the real work done here is provided by upstream [Fedora](https://fedoraproject.org/atomic-desktops/silverblue/) and [UBlue](https://universal-blue.org/) and based on [Universal Blue's](https://github.com/ublue-os) excellent [template](https://github.com/ublue-os/image-template).

# Description
Both Fedora Silverblue and the customized Bazzite OS are amazing but didn't check all the boxes for me or, as in Bazzite's case, provide more than I'll ever want or need.
This custom image makes a few modification to the base Fedora image, moving in the direction toward Bazzite while keeping the Fedora Silverblue experiance.
As I only game on Steam, no other game launcher is included, however, I assume most can be added as flatpaks. I've tried Lutris and PlayonLinux and both worked fine, however, this image does nothing special to support or optimize for game launchers outside Steam.
This is an AMD only image. No Nvidia support is included.

Built weekly, the latest Fedora base image is modified in the following ways:
- Removes Fedora kernel and swaps in latest [CachyOS kernel](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos/) 
- Adds scx-scheds added from [CachyOS kernel addons](https://copr.fedorainfracloud.org/coprs/bieszczaders/kernel-cachyos-addons/)
- Swaps in latest Mesa drivers at build time from [mesa-git](https://copr.fedorainfracloud.org/coprs/xxmitsu/mesa-git/)
- Adds [Steam-devices](https://packages.fedoraproject.org/pkgs/steam-devices/steam-devices/) at build time
- Adds [Goverlay](https://packages.fedoraproject.org/pkgs/goverlay/) at build time
- Adds [Flathub](https://flathub.org/) to remote flatpak repository
- Removes Firefox from image (flatpak version can be installed)

# How to Use

The easiest way to get going is to rebase from an installed bootc image. If you are starting from a clean install, I recommend installing latest Fedora Silveblue, pinning that image ```sudo ostree admin pin 0``` (for the latest image), then rebasing by running: 
```sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/ctomblin/crisis-os```

To upgrade after weekly builds:
```sudo rpm-ostree upgrade```

# Issues

Since the first build I've had zero stability issues. However, that's not always going to be true. This is especally true with latest mesa drivers at build time. The beauty of bootc (atomic images) is the rollback feature to a previous image using ```sudo rpm-ostree rollback``` if any issues are encountered after an upgrade.
I recommed pinning a stable bootc image with ```ostree admin pin``` or easily seen and managed through [Cockpit Client](https://flathub.org/apps/org.cockpit_project.CockpitClient) GUI (installed as a flatpak) under "Software Update".

