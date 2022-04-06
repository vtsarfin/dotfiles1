#!/bin/bash
if [[ `uname`=='Darwin' ]]
then
    if  ! brew list| grep  nerd-font 2>&1 > /dev/null
    then 
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font
    else
        echo "font-hack-nerd-font already installed."
    fi
fi
