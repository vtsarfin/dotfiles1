ssh-add ak/test/apr_id_rsa_test_01
ssh-add .ssh/id_rsa
if [[ -e /etc/bashrc ]]
then
	. /etc/bashrc
fi
if [[ `uname` == 'Linux' ]]
then
	alias ls="ls --color"
elif [[ `uname` == 'Darwin' ]]
then
	alias ls='ls -w'
	export CLICOLOR=1
fi
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
LESSCHARSET=utf-8; export LESSCHARSET


