atuin init fish | source

function ls
    eza $argv
end

# Customized fish greeting
function fish_greeting
    echo
    shuf -n1 $HOME/.config/fish/quotes.txt | lolcat -f 0.35
    echo
    uptime
end

function fish_right_prompt
end

set -gx TERMINFO /usr/share/terminfo

fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path /home/lura/.spicetify
fish_add_path ~/.pyenv/bin

set -g theme_display_group no

if command -q code
    string match -q "$TERM_PROGRAM" vscode and . (code --locate-shell-integration-path fish)
end

# pnpm
set -gx PNPM_HOME "/home/lura/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end


function envsource
    for line in (cat $argv | grep -v '^#' | grep -v '^\s*$')
        set item (string split -m 1 '=' $line)
        set -gx $item[1] $item[2]
        echo "Exported key $item[1]"
    end
end
