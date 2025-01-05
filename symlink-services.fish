#!/usr/bin/env fish

for file in ./home/systemd/*.service
    if test -f $file
         ln -svf (realpath $file) ~/.config/systemd/user/
    end
end
