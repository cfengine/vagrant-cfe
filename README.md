Vagrant Launcher
===========

Start up Vagrant VMs with CFEngine installed.

Supports installation from:
- none (leave blank): `single_ubuntu`, `single_centos`
- community repos (APT/Yum): `single_ubuntu_cclient`, `single_centos_cclient`
- a package file:  `single_ubuntu_eclient`, `single_centos_eclient`, `single_ubuntu_hub`, `single_centos_hub`
- source (core.git, to a given tag or branch if you add --install_version=X): `single_ubuntu_source`, `single_centos_source`

Supports boxes: CentOS, Debian, Ubuntu, RHEL, etc.

Sample usage (see Vagrantfile and types.rb for all the details):

```shell
# set up a single Ubuntu box with CFEngine from source (master branch)
vagrant up -- --type=single_ubuntu_source
# ssh into it
vagrant ssh -- --type=single_ubuntu_source
# destroy it
vagrant destroy -- --type=single_ubuntu_source
```
