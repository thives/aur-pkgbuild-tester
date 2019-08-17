#!/bin/bash
set -e
# Create user
useradd -m -g wheel -s /bin/sh tester
echo "tester ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R tester:wheel /home/tester/pkgdir
# Install makepkg deps
pacman -Sy sudo binutils fakeroot --noconfirm
# Build the package as `tester' user
su - tester /home/tester/scripts/build-pkg.sh
# Install the package
cd /home/tester/pkgdir
pacman -U *.tar.xz --noconfirm
# Run the test
bash /home/tester/test.sh
