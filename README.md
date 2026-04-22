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
- ```modules``` - tree of nodes, categorised; a node is a module if it contains at least one of: ```system.nix``` (system configuration), ```user.nix``` (home-manager configuration); a node can be a module and have children

Files:
- ```config.nix``` - configuration for the deployment
- ```flake.nix``` - flake, contains inputs only
- ```outputs.nix``` - outputs of the flake