#!/bin/bash
system=`uname`
Linux_config_list="
    kitty
    nvim
    zsh/.zprezto/runcoms
"
Darwin_config_list="
    nvim
    zsh/.zprezto/runcoms
    mac
"
copy_config()
{
    if [[ -d ~/.config/$config_dir ]] 
    then 
        if [[ "$config_dir" =~ "prezto" ]]
        then
            mkdir -pv ./.config/$config_dir
            cp -av ~/.config/$config_dir ./.config/zsh/.zprezto/
        else
            cp -av ~/.config/$config_dir ./.config
        fi
    fi
}
config_dirs="${system}_config_list"
echo -e $config_dirs"\n"
for config_dir in ${!config_dirs}
do
    copy_config
done
