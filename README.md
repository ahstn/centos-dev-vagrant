<img src="http://i.imgur.com/Nvycw2C.png" align="left" width="128px" height="128px"/>

### **centos-dev-vagrant**
> *A vagrant box designed to create a modular development environment.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


Uses a Chef cookbook for provisioning.
For more information on the cookbook view the [README.md](chef/adam-vagrant/README.md).

## Requirements
* Virtualbox
* Vagrant
* Berkshelf (via ChefDK or RubyGem)

## Installation
```bash
git clone https://github.com/phazyy/centos-dev-vagrant.git
cd centos-dev-vagrant
vagrant plugin install vagrant-berkshelf vagrant-vbguest
vagrant up
```
*NB:* `vagrant up` should also install the required vagrant plugins
(see Vagrantfile for more info).

## Usage
By default the cookbook will only setup common dev tools like git, mlocate,
GNOME 3 and terminator. However it has the ability to provision the environment
for java or chef development and setup zsh, vim and more tools.

To enable extra provisioning simply add the recipes you want to the role located
[here](chef/role/vagrant.json).
(A list of recipes can be found [here](chef/adam-vagrant/README.md)).

For example, to setup an environment for Java development with ZSH installed,
the role include be the following:
```json
"run_list": [
    "recipe[adam-vagrant::yum_repos]",
    "recipe[adam-vagrant::common]",
    "recipe[adam-vagrant::java]"
    "recipe[adam-vagrant::zsh]"
  ]
```

The role can also be used to override the attributes used when provisoning.
(A list of attributes can be found [here](chef/adam-vagrant/README.md)).

For example, to setup a headless VM with a custom URL for vim-plug, the role
would include the following:
```json
"override_attributes": {
  "vagrant": {
    "vm_type": "headless"
  },
  "vim-plug": {
    "url": "http://repo.company.com/plug.vim"
  }
}
```

