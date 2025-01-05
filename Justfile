default:
    @echo "Use just system to setup system files"
    @echo "Or just home to setup home symbolic links"

copy-limine-config:
    sudo cp ./bootloader/limine.conf /boot/limine.conf
    sudo cp ./bootloader/background.png /boot/background.png

copy-kernel-config: 
    sudo cp kernel/config /usr/src/linux/.config


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

system: copy-kernel-config copy-limine-config resync-portage
