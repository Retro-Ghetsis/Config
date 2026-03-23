if status is-interactive
# Commands to run in interactive sessions can go here
end

alias s="yay -Ss"
alias i="sudo pacman -S --needed"
alias r="sudo pacman -R"

set -g fish_greeting

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

zoxide init --cmd cd fish | source
