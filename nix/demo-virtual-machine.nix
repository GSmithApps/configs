{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];

  # Let demo build as a trusted user.
# nix.settings.trusted-users = [ "demo" ];

# Mount a VirtualBox shared folder.
# This is configurable in the VirtualBox menu at
# Machine / Settings / Shared Folders.
fileSystems."/mnt/shared" = {
  fsType = "vboxsf";
  device = "vbox-xfer";
  options = [ "rw" ];
};

virtualisation.virtualbox.guest.enable = true;

# By default, the NixOS VirtualBox demo image includes SDDM and Plasma.
# If you prefer another desktop manager or display manager, you may want
# to disable the default.
# services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
# services.displayManager.sddm.enable = lib.mkForce false;

# Enable GDM/GNOME by uncommenting above two lines and two lines below.
# services.xserver.displayManager.gdm.enable = true;
# services.xserver.desktopManager.gnome.enable = true;

# Set your time zone.
time.timeZone = "America/Chicago";

users.users.demo = {
  shell = pkgs.zsh;
};

programs.zsh = {
  enable = true;
  enableCompletion = true;
};

nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# \$ nix search wget
environment.systemPackages = with pkgs; [
vscode
obsidian
python312
git
zsh
oh-my-zsh
];

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

}
