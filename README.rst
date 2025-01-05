More Config Files
=================

Yet another configuration directory. This is for Antiskill V4.

Setup
-----

1. Install ``eselect-repository`` and ``git``: ``emerge -av eselect-repository dev-vcs/git``
2. Enable my overlay: ``eselect repository add lura-overlay git https://github.com/Fuyukai/gentoo-overlay``
3. Install ``sudo-rs`` and ``just``: ``env ACCEPT_KEYWORDS="~amd64" emerge -av sudo-rs just``
4. Delete the old gentoo repository: ``rm -r /var/db/repos/gentoo``
5. Rebuild world: ``just -v overwrite-repos emerge-auvdn``

Kernel
------

Using ``cachyos-sources`` with 
``USE="auto-cpu-optimization bbr3 bore hugepage_always hz_ticks_1000 llvm-lto-thin o3 per-gov tickrate_full zfs"``.

My kernel config is tailored to my setup and likely won't work on any other machine.

Known problems:
- Power button doesn't work. Not sure why. Probably accidentally disabled something in ACPI 
  settings.

System
------

My portage configuration is under ``portage``, with the following layout:

- ``portage/env`` - special, per-package environment overrides
- ``portage/package.accept_keywords`` - contains files for globally setting ``~amd64``, unsetting it
  for specific packages, and enabling live ebuilds
- ``portage/package.use/main`` - main USE flags file
- ``portage/package.use/zz_autounmask`` - anything ``emerge --autounmask`` gives me
- ``portage/package.use/zz_steam`` - like above, but for steam autounmask
- ``portage/eselect-repo.conf`` - synched from portage dir, contains the list of overlays
- ``portage/make.conf`` - main make.conf flags
- ``portage/world`` - synched from portage dir, my ``@world`` set

I use limine for my bootloader; the config is at ``bootloader/limine.conf`` and my background
for it is at ``bootloader/background.png``.

Home
----

I use `uwsm <https://github.com/Vladimir-csp/uwsm>`_ to launch my Wayland compositor.

Current software stack:

- Window manager/compositor: ``gui-wm/labwc``. May switch to something else in the future.
- Terminal: ``gui-apps/foot`` via ``foot-server``.

Autostart
~~~~~~~~~

I don't use any compositor autostart features; instead, I use systemd user services. These can be
found in ``home/systemd``.

Some of these are specific to a WM.
