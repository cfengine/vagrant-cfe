Vagrant Launcher
===========

Start up Vagrant VMs with CFEngine installed.

Supports installation from:
- none (leave blank)
- community repos (APT/Yum)
- a package file
- source (core.git, to a given tag or branch)

Supports boxes: CentOS, Debian, Ubuntu, RHEL, etc.

Sample usage (see Vagrantfile and types.rb for all the details):

Tested types: `single_ubuntu_source`, `single_centos_source`

```shell
# set up a single Ubuntu box with CFEngine from source (master branch)
vagrant up -- --type=single_ubuntu_source
# ssh into it
vagrant ssh -- --type=single_ubuntu_source
# destroy it
vagrant destroy -- --type=single_ubuntu_source
```
