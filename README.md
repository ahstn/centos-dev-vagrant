<img src="http://i.imgur.com/Nvycw2C.png" align="left" width="128px" height="128px"/>

### **fedora-dev-vagrant**
> *A vagrant box designed to create a modular development environment.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


# Table of Contents

* [Introduction](#introduction)
* [Configuration](#Configuration)
* [Ansible Provisioning](#ansible-provisioning)
* [Vagrant Customization](#vagrant-customization)
  * [Changing the VM Hostname](#changing-the-vm-hostname)
  * [Sharing a folder](#sharing-a-folder)


## Introduction
Flexible VM aimed primarily at developing apps for Kubernetes, Docker deployments.

This VM makes building reliable, reproducable environments quick and easy with
customization baked in from the start using [Nugrant] and [Ansible].
While the main focus of this environment is to help developers working with Kubernetes cluster(s) day-to-day, it has
support for most major languages including their development environments.

# Configuration
[.vagrantuser.example](./.vagrantuser.example)

# Ansible Provisioning
If your favourite language or tool is missing, the Anisble provisioning used
makes it simple to add and configure. Rather than running multiple, repetitive
bash commands for every fresh setup, You can add a new [Ansible module] or role.
Roles exist for almost anything you can think of and can be sourced from the
community, public [Ansible Galaxy], which then get downloaded and executed
inside the VM without you needing Ansible or any runtime dependencies
installed on the host.

# Vagrant Customization
Vagrant itself has many different customization options, which you can read
about on the [Vagrant documentation], however some of the most common personal
customization options are as follows.

## Changing the VM Hostname
`config.vm.hostname (string)`

Should you need to change the VM hostname to a custom value for development,
the setting above will allow you to do so.

Optionally, the [vagrant-hostmanager] plugin allows more granular control or
the Ansible role [ansible-role-hosts] will also configure /etc/hosts.

## Sharing a folder
`config.vm.synced_folder '../data', '/vagrant_data'`

Vagrant synced folders allow you to share files between the host and guest.
Basic usage is shown in the setting above with the order `$host_dir`,
'$guest_dir', but more advanced usage, including mount options, type and owner,
can be found on the [shared folder documentation].

[Nugrant]: https://github.com/maoueh/nugrant
[Ansible]: https://github.com/ansible/ansible
[Ansible module]: https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html
[Ansible Galaxy]: https://galaxy.ansible.com/
[Vagrant documentation]: https://www.vagrantup.com/docs/vagrantfile/
[vagrant-hostmanager]: https://github.com/devopsgroup-io/vagrant-hostmanager/
[ansible-role-hosts]: https://github.com/bertvv/ansible-role-hosts
[shared folder documentation]: https://www.vagrantup.com/docs/synced-folders/basic_usage.html
