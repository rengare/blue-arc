#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos

dnf5 -y copr enable ryanabx/cosmic-epoch
dnf5 -y install cosmic-desktop cosmic-store cosmic-edit cosmic-player
dnf5 -y copr disable ryanabx/cosmic-epoch

dnf5 -y copr enable ublue-os/packages
dnf5 -y install uupd
dnf5 -y copr disable ublue-os/packages

dnf5 -y install ptyxis gnome-keyring-pam NetworkManager-tui \
  NetworkManager-openvpn xdg-user-dirs \
  emacs mpv git-lfs fish foot samba samba-client samba-common

dnf5 -y remove code
dnf5 -y remove ublue-update

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl disable gdm || true
systemctl disable sddm || true
systemctl disable ublue-update || true

systemctl enable podman.socket
systemctl enable cosmic-greeter
systemctl enable uupd.service
systemctl enable uupd.timer

# Clean package manager cache
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

cp -rf /ctx/system_files/* /
mkdir /nix
