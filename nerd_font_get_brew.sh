#!/bin/bash
if [[ `uname`=='Darwin' ]]
then
    if  ! brew list font-hack-nerd-font 2>&1 > /dev/null
    then 
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font
    else
        echo "font-hack-nerd-font already installed."
    fi
fi
