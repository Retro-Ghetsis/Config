#!/bin/zsh

pkill waybar
pkill swaync

waybar &
swaync &
