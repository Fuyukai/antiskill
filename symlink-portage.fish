#!/usr/bin/env fish

if test -d /etc/portage/env
    rm -r /etc/portage/env
    ln -sv (realpath ./portage/env) /etc/portage/env
end

if test -f /etc/portage/make.conf 
    rm /etc/portage/make.conf
    ln -sv (realpath ./portage/make.conf) /etc/portage/make.conf
end

if test -f /etc/portage/package.accept_keywords || test -d /etc/portage/package.accept_keywords
    rm -r /etc/portage/package.accept_keywords
    ln -sv (realpath ./portage/package.accept_keywords) /etc/portage/package.accept_keywords
end

if test -f /etc/portage/package.use || test -d /etc/portage/package.use
    rm -r /etc/portage/package.use
    ln -sv (realpath ./portage/package.use) /etc/portage/package.use
end

if test -f /etc/portage/package.env || test -d /etc/portage/package.env
    rm -r /etc/portage/package.env
    ln -sv (realpath ./portage/package.env) /etc/portage/package.env
end
