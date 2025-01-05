#!/usr/bin/env fish

for dir in ./patches/*
    if test -d $dir
         ln -svf (realpath $dir) /etc/portage/patches
    end
end
