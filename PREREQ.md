# Prerequisites

## Required Packages
 * Virtualbox - Download the latest release for your operating system [here](https://www.virtualbox.org/wiki/Downloads).
 * Vagrant - Download the latest release for your operating system [here](https://www.vagrantup.com/downloads.html).
 * ChefDK - Download the latest stable release for your operating system [here](https://downloads.chef.io/chefdk/stable/1.5.0).

## Vagrant Plugins
[Vagrant-Berkshelf] and [Vagrant-VBGuest] are required for running this Vagrant box. 
Vagrant-Berkshelf resolves cookbook dependencies for Vagrant Chef provisioning and Vagrant-VBGuest keeps VirtualBox Guest Additions up to date.

To install these, run the following:
```bash
vagrant plugin install vagrant-berkshelf vagrant-vbguest
```
**NB:** You can add `-s <custom-repo.com>` if you prefer to use a custom gem repo

[Vagrant-Berkshelf]: https://github.com/berkshelf/vagrant-berkshelf
[Vagrant-VBGuest]: https://github.com/dotless-de/vagrant-vbguest
