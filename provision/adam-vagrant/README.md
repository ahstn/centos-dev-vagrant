# adam-vagrant
Chef cookbook for provisioning a Centos development vagrant box.

[//]: # (TODO: Credit dependency cookbooks)
[//]: # (TODO: Add Atom recipe and attributes)

## Recipes
| Name           | Description                                                                         |
|----------------|-------------------------------------------------------------------------------------|
| `common.rb`    | Installs common developer tools and GNOME 3 (depending on `['vagrant']['vm_type']`) |
| `chefdk.rb`    | Installs ChefDK, configures gem sources and installs specified ruby gems            |
| `java.rb`      | Installs JDK, Maven and Intellij                                                    |
| `vim.rb`       | Installs Vim, Vim-Plug (Plugin Manager) and a .vimrc with some sensible defaults    |
| `yum_repos.rb` | Installs Yum-Repos for extra packages                                               |
| `zsh.rb`       | Installs ZSH, oh-my-zsh and enables specified plugins                               |

## Attributes
| Name                       | Description                                                      | Default                                        |
|----------------------------|------------------------------------------------------------------|------------------------------------------------|
| `['vagrant']['vm_type']`   | Setting this to headless means the CB won't install GUI packages | `headed`                                       |
| `['vagrant']['user']`      | User to provision resources for                                  | `vagrant`                                      |
| `['vagrant']['home']`      | User's home directory (calculated from user's name)              | `/home/vagrant`                                |
| `['chefdk']['gem_sources']`| Array of sources to use for fetching gems                        | `%w(https://rubygems.org http://rubygems.org)` |
| `['chefdk']['gems']`       | Array of gems to install for chefdk                              | `%w(kitchen-docker rubocop inspec)`            |
| `['intellij']['version']`  | Version of Intellij to download                                  | `2017.1`                                       |
| `['intellij']['edition']`  | Edition of Intellij to download (U = Ultimate, C = Community)    | `C`                                            |
| `['intellij']['domain']`   | Base URL to use when downloading intellij                        | `https://download.jetbrains.com/idea/`         |
| `['intellij']['url']`      | Full URL to Intellij package (Calculated from the above 3 attrs) | ^^^^^                                          |
| `['oh-my-zsh']['theme']`   | oh-my-zsh theme to use for ZSH                                   | `robbyrussell`                                 |
| `['oh-my-zsh']['plugins']` | oh-my-zsh plugins to use for ZSH                                 | `%w(git knife sudo systemd)`                   |
| `['oh-my-zsh']['url']`     | Full URL pointing to oh-my-zsh's install script                  | `http://install.ohmyz.sh`                      |
| `['vim-plug']['url']`      | Full URL pointing to vim-plug's install script                   | `https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim` |

## Development and Testing
*Pre-Reqs:* ChefDK and Docker.

Unit tests are written using [ChefSpec] and can be ran using: `chef exec rspec -f d -c`.

Integration tests are written using [InSpec] with [kitchen-docker] and can be
executed by running: `chef exec kitchen test`. Documentation on all available
kitchen commands can be found [here](https://docs.chef.io/ctl_kitchen.html).

[ChefSpec]: https://github.com/sethvargo/chefspec
[InSpec]: https://github.com/chef/inspec
[kitchen-docker]: https://github.com/test-kitchen/kitchen-docker
