# adam-vagrant
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Chef cookbook for provisioning a Centos development vagrant box.

[//]: # (TODO: Add recipe for installing docker)

## Dependency Cookbooks
  - [`java`] for installing the JDK
  - [`chefdk`] for installing and setting up the ChefDK

## Recipes
| Name              | Description                                                                         |
|-------------------|-------------------------------------------------------------------------------------|
| `common.rb`       | Installs common developer tools and GNOME 3 (depending on `['vagrant']['vm_type']`) |
| `chefdk.rb`       | Installs ChefDK, configures gem sources and installs specified ruby gems            |
| `java.rb`         | Installs JDK, Maven and Intellij                                                    |
| `sublime_text.rb` | Installs Sublime Text 3 and [Package Control]                                       |
| `vim.rb`          | Installs Vim, Vim-Plug (Plugin Manager) and a .vimrc with some sensible defaults    |
| `yum_repos.rb`    | Installs Yum-Repos for extra packages                                               |
| `zsh.rb`          | Installs ZSH, oh-my-zsh and enables specified plugins                               |

## Attributes
Node attributes for this cookbook are logically separated into different files.

**`['vagrant']` namespace**
 - `['vagrant']['vm_type']`    - Setting this to headless means the CB won't install GUI packages
 - `['vagrant']['user']`       - User to provision resources for
 - `['vagrant']['home']`       - User's home directory (calculated from user's name)

**`['chefdk']` namespace**
 - `['chefdk']['gem_sources']` - Array of sources to use for fetching gems
 - `['chefdk']['gems']`        - Array of gems to install for chefdk

**`['git']` namespace**
 - `['git']['name']`           - Name to use for global git config
 - `['git']['email']`          - Email to use for global git config

**`['intellij']` namespace**
 - `['intellij']['version']`   - Version of Intellij to download
 - `['intellij']['edition']`   - Edition of Intellij to download (U = Ultimate, C = Community)
 - `['intellij']['domain']`    - Base URL to use when downloading intellij
 - `['intellij']['url']`       - Full URL to Intellij package (Calculated from the above 3 attrs)

**`['oh-my-zsh']` namespace**
 - `['oh-my-zsh']['theme']`    - oh-my-zsh theme to use for ZSH
 - `['oh-my-zsh']['plugins']`  - oh-my-zsh plugins to use for ZSH
 - `['oh-my-zsh']['url']`      - Full URL pointing to oh-my-zsh's install script

**`['sublime']` namespace**
 - `['sublime']['url']`        - URL to use when downloading Sublime Text 3
 - `['sublime']['dir']`        - Directory to unpack ST3 to
 - `['sublime']['path']`       - Path to symlink ST3 binary to
 - `['sublime']['archive']`    - Temporary path to store the ST3 archive/package
 - `['sublime']['pc']['url']`  - URL to use when downloading Package Control
 - `['sublime']['pc']['dir']`  - ST3 installed packages directory
 - `['sublime']['pc']['path']` - Path to Package Control plugin

**`['vim-plug']` namespace**
 - `['vim-plug']['url']`       - Full URL pointing to vim-plug's install script

## Development and Testing
*Pre-Reqs:* ChefDK and Docker.

Unit tests are written using [ChefSpec] and can be ran using: `chef exec rspec -f d -c`.

Integration tests are written using [InSpec] with [kitchen-docker] and can be
executed by running: `chef exec kitchen test`. Documentation on all available
kitchen commands can be found [here](https://docs.chef.io/ctl_kitchen.html).

[`java`]: https://github.com/agileorbit-cookbooks/java
[`chefdk`]: https://github.com/RoboticCheese/chef-dk-chef
[Package Control]: https://PackageControl.io
[ChefSpec]: https://github.com/sethvargo/chefspec
[InSpec]: https://github.com/chef/inspec
[kitchen-docker]: https://github.com/test-kitchen/kitchen-docker
