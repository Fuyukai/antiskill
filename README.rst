More Config Files
=================

Yet another configuration directory. This is for Antiskill V4.

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


