# Prints a help message.
default:
    @echo "Use just system to setup system files"
    @echo "Or just home to setup home symbolic links"
    @echo "Needs sudo-rs installed first"

# Copies bootloader configuration to /boot.
[group("core")]
copy-limine-config:
    sudo cp ./bootloader/limine.conf /boot/limine.conf
    sudo cp ./bootloader/background.png /boot/background.png

# Copies my current kernel config to /usr/src/linux.
[group("core")]
copy-kernel-config: 
    sudo cp kernel/config /usr/src/linux/.config

# Enables my systemd services.
[group("core")]
system-services:
    sudo systemctl enable ckb-next-daemon.service
    sudo systemctl enable systemd-networkd.service
    sudo systemctl enable pfl.timer
    sudo systemctl enable scx.service

# This is separate because of eselect-repository doing move writes rather than actually updating
# the file.

# Copies repos.conf back to this directory.
[group("portage")]
resync-repos:
    sudo cp /etc/portage/repos.conf/eselect-repo.conf ./portage

# Copies local repos.conf to the portage configuration directory.
[group("portage")]
overwrite-repos:
    sudo cp ./portage/eselect-repo.conf /etc/portage/repos.conf/eselect-repo.conf

# Note: This is synched from portage -> repo to avoid breakage
# Copies the @world set back to this directory.
[group("portage")]
resync-world:
    sudo cp /var/lib/portage/world ./portage

# Symlinks portage patches.
[group("portage")]
symlink-patches:
    sudo ./symlink-patches.fish

# Symlinks portage configuration.
[group("portage")]
symlink-portage-dirs:
    sudo ./symlink-portage.fish

# Resyncs all available portage configurations.
[group("portage")]
resync-portage: resync-repos resync-world symlink-patches symlink-portage-dirs

# Syncs overlays from the internet.
[group("portage")]
emaint: resync-portage
    sudo emaint --auto sync

# Does a system update/rebuild.
[group("portage")]
emerge-auvdn: emaint 
    sudo emerge -auvDNg --with-bdeps=y -j4 @world

# Performs all system setup tasks.
[group("terminal")]
system: copy-kernel-config copy-limine-config resync-portage system-services

# Symlinks the foot terminal configuration.
[group("configs")]
foot:
    mkdir -pv ~/.config/foot
    ln -svf '{{absolute_path("./home/foot/foot.ini")}}' ~/.config/foot/foot.ini

# Symlinks the labwc WM configuration.
[group("configs")]
labwc:
    mkdir -pv ~/.config/labwc
    ln -svf '{{absolute_path("./home/labwc/environment")}}' ~/.config/labwc/environment
    ln -svf '{{absolute_path("./home/labwc/rc.xml")}}' ~/.config/labwc/rc.xml

# Symlinks the GTK 3.0 configs.
[group("theming")]
gtk3:
    mkdir -pv ~/.config/gtk-3.0
    ln -svf '{{absolute_path("./home/gtk-3.0/gtk.css")}}' ~/.config/gtk-3.0/gtk.css
    ln -svf '{{absolute_path("./home/gtk-3.0/settings.ini")}}' ~/.config/gtk-3.0/settings.ini

# Symlinks the GTK 4.0 configs.
[group("theming")]
gtk4:
    mkdir -pv ~/.config/gtk-4.0
    ln -svf '{{absolute_path("./home/gtk-4.0/gtk.css")}}' ~/.config/gtk-4.0/gtk.css

# Symlinks the QT configs.
qt:
    mkdir -pv ~/.config/qt5ct ~/.config/qt6ct ~/.config/kvantum
    ln -svf '{{absolute_path("./home/kvantum/kvantum.kvconfig")}}' ~/.config/Kvantum/kvantum.kvconfig
    ln -svf '{{absolute_path("./home/qt5ct/qt5ct.conf")}}' ~/.config/qt5ct/qt5ct.conf
    ln -svf '{{absolute_path("./home/qt6ct/qt6ct.conf")}}' ~/.config/qt6ct/qt6ct.conf
    
# Symlinks all theming-related configs.
[group("theming")]
themes: gtk3 gtk4 qt

# Sets up fish configs.
[group("shell")]
fish:
    mkdir -pv ~/.config/fish
    ln -svf '{{absolute_path("./home/fish/config.fish")}}' ~/.config/fish/config.fish
    ln -svf '{{absolute_path("./home/fish/quotes.txt")}}' ~/.config/fish/quotes.txt

# Sets up things relating to my shell.
[group("shell")]
shell: fish
    ln -svf '{{absolute_path("./home/hyfetch.json")}}' ~/.config/hyfetch.json
    mkdir -pv ~/.config/atuin
    ln -svf '{{absolute_path("./home/atuin/config.toml")}}' ~/.config/atuin/config.toml

# Symlinks my monitor layout config.
[group("configs")]
kanshi:
    mkdir -pv ~/.config/kanshi
    ln -svf '{{absolute_path("./home/kanshi/config")}}' ~/.config/kanshi/config

# Sets up Rofi, my launcher.
[group("config")]
rofi:
    mkdir -pv ~/.config/rofi
    ln -svf '{{absolute_path("./home/rofi/config.rasi")}}' ~/.config/rofi/config.rasi
    ln -svf '{{absolute_path("./home/rofi/theme.rasi")}}' ~/.config/rofi/theme.rasi

# Sets up systemd user services.
[group("configs")]
services:
    ./symlink-services.fish
    systemctl --user daemon-reload
    systemctl --user enable ckb-next.service
    systemctl --user enable cliphist-image.service cliphist-text.service
    systemctl --user enable kanshi.service
    # Only used on niri
    systemctl --user enable xwayland-satellite.service

    systemctl --user enable foot-server.socket
    systemctl --user enable atuin-daemon.socket
    systemctl --user enable mako.service
    systemctl --user enable pipewire-pulse.socket pipewire.socket wireplumber.service

# Sets up my home config directory.
[group("terminal")]
home: foot labwc rofi themes shell kanshi services 
