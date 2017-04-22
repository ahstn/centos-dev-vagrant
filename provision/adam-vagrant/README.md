# adam-vagrant
Chef cookbook for provisioning a Centos development vagrant box.
Uses kitchen-docker and inspec for integration testing.

## Recipes
### dev_tools
Installs terminator, chromium, git, mlocate and the yum group 'GNOME Desktop'

### yum_repos
Installs the the 'Extra Packages for Enterprise Linux' repo

### dev_chef
Installs the necessary packages needed for Chef development

### dev_adam
Installs and configures extra tools for my personal use (zsh and vim)

## Attributes
| Name                      | Description                                                      | Default  |
|---------------------------|------------------------------------------------------------------|----------|
| `['dev_tools']['vm_type'] | Setting this to headless means the CB won't install GUI packages | `headed` |
