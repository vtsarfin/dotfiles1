#!/bin/bash
system=`uname`
Linux_config_list="
    kitty
    nvim
    zsh/.zprezto/runcoms
    "
Darwin_config_list="
    nvim
    "
copy_config()
{
    if [[ `uname`=='Linux' ]]
    then
        if [[ -d ~/.config/$config_dir ]] 
        then 
            mkdir -pv ./.config/$config_dir
            cp -av "~/.config/$config_dir" ./.config
        fi
    fi
}
config_dirs="${system}_config_list"
echo $config_dirs
for config_dir in ${!config_dirs}
do
    copy_config
done
