# NixOS
My NixOS configs
![](./docs/1.png)

## Installation
From a live NixOS ISO environment (with Internet connection), first clone the repo. Then in ```flake.nix``` change ```selectedHost``` variable to point to the folder with the correct machine. Then (assuming pwd is the repo):
```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./hosts/<HOST>/disk.nix
sudo nixos-install --flake .#<HOSTNAME>
sudo nixos-enter
passwd <USER>
exit
shutdown now
```
```HOST``` - the desired machine from hosts folder in the repo

```HOSTNAME``` - the machine's hostname (from info.nix)

```USER``` - the machine's user (from info.nix)