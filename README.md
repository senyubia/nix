# NixOS
My NixOS configs for single-user systems
![](./docs/1.png)

## Installation
From a live NixOS ISO environment (with Internet connection), first clone the repo. Then, set preferred values in ```./config.nix```, and after that (assuming pwd is the repo):
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./hosts/<HOST>/disk.nix
sudo nixos-install --flake .#<HOSTNAME>
sudo nixos-enter
passwd <USER>
exit
shutdown now
```
- ```HOST``` - the desired machine from hosts folder in the repo
- ```HOSTNAME``` - the machine's hostname (from info.nix)
- ```USER``` - the machine's user (from info.nix)

## Repository structure
Directories:
- ```assets``` - static files used in modules
- ```docs``` - static files used in markdown
- ```hosts``` - configuration for specific hosts; if creating a new one, some files must be present, see ```hosts/laptop```
- ```lib``` - custom helper libraries
- ```modules``` - tree of nodes, categorised; a node is a module if it contains ```default.nix```, which returns a set or a function taking ```modules``` as arg and returning a set containing at least one of attributes: ```dependsOn``` - list, other modules this module requires, ```system``` - a set or a function taking ```specialArgs``` as args and returning a set containing NixOS configuration, ```home``` - same as system but for home-manager; a node can be a module and have children

Files:
- ```config.nix``` - configuration for the deployment
- ```flake.nix``` - flake, contains inputs only
- ```outputs.nix``` - outputs of the flake

## How to use modules
- need to use ```lib/moduleImporter.nix``` in flake outputs to work
- use module name (e.g. ```modules.bootloader.grub```)
- bulk import of modules requested by the host (e.g. ```./hosts/laptop/modules.nix```) done in ```outputs.nix```
- importing a module from another module (extensions, dependency) - put imported module in ```dependsOn``` list