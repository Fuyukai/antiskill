#!/usr/bin/env fish

for file in ./home/systemd/*.service ./home/systemd/*.path
    if test -f $file
         ln -svf (realpath $file) ~/.config/systemd/user/
    end
end
