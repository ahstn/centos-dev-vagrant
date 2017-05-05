# centos-dev-vagrant
A vagrant box designed to create a modular development environment.

Uses a Chef cookbook for provisioning.
For more information on the cookbook view the README.md

## Requirements
* Virtualbox
* Vagrant

## Installation
```bash
git clone https://github.com/phazyy/centos-dev-vagrant.git
cd centos-dev-vagrant
vagrant up
```
*NB:* `vagrant up` should also install the required vagrant plugins 
(see Vagrantfile for more info).

## Usage
By default the cookbook will only setup common dev tools like git, mlocate, 
GNOME 3 and terminator. However it has the ability to provision the environment 
for java or chef development and setup zsh, vim and more tools.

To enable extra provisioning simply add the recipes you want to the role located 
[here](provision/role/vagrant.json). 
(A list of recipes can be found [here](provision/adam-vagrant/README.md)).

For example, to setup an environment for Java development with ZSH installed, 
the role would be the following:
```json
"run_list": [
    "recipe[adam-vagrant::yum_repos]",
    "recipe[adam-vagrant::common]",
    "recipe[adam-vagrant::java]"
    "recipe[adam-vagrant::zsh]"
  ]
```
