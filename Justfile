default:
    @echo "Use just system to setup system files"
    @echo "Or just home to setup home symbolic links"
    @echo "Needs sudo-rs installed first"

copy-limine-config:
    sudo cp ./bootloader/limine.conf /boot/limine.conf
    sudo cp ./bootloader/background.png /boot/background.png

copy-kernel-config: 
    sudo cp kernel/config /usr/src/linux/.config

system-services:
    sudo systemctl enable ckb-next-daemon.service
    sudo systemctl enable systemd-networkd.service
    sudo systemctl enable pfl.timer
    sudo systemctl enable scx.service

# Note: These are synched from portage directories -> home in order to prevent breakage if
# my ZFS /home fails to mount after a kernel update.
# I also keep a minimal portage homedir in order to rebuild zfs-kmod.
resync-repos:
    sudo cp /etc/portage/repos.conf/eselect-repo.conf ./portage

resync-world:
    sudo cp /var/lib/portage/world ./portage

symlink-patches:
    sudo ./symlink-patches.fish

symlink-portage-dirs:
    sudo ./symlink-portage.fish

resync-portage: resync-repos resync-world symlink-patches symlink-portage-dirs

emerge: resync-portage
    sudo emerge -auvDNg --with-bdeps=y @world

system: copy-kernel-config copy-limine-config resync-portage system-services

foot:
    ln -svf '{{absolute_path("./home/foot/foot.ini")}}' ~/.config/foot/foot.ini

labwc:
    ln -svf '{{absolute_path("./home/labwc/environment")}}' ~/.config/labwc/environment
    ln -svf '{{absolute_path("./home/labwc/rc.xml")}}' ~/.config/labwc/rc.xml

services:
    ./symlink-services.fish
    systemctl --user daemon-reload
    systemctl --user enable ckb-next.service
    systemctl --user enable cliphist-image.service cliphist-text.service
    systemctl --user enable kanshi.service
    # Only used on niri
    systemctl --user enable xwayland-satellite.service

    systemctl --user enable foot-server.socket
    systemctl --user enable mako.service
    systemctl --user enable pipewire-pulse.socket pipewire.socket wireplumber.service


home: foot labwc services
