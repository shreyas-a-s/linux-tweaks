# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.timeout = 1;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GDM Display Manager.
  services.xserver.displayManager.gdm.enable = true;

  # Enable Gnome
  services.xserver.displayManager.sessionPackages = [ pkgs.gnome.gnome-session.sessions ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Suoders tweaks
  security.sudo.extraConfig = "Defaults  pwfeedback";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.dt = {
    isNormalUser = true;
    description = "dt";
    extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
#    packages = with pkgs; [
#      brave
#      gnome-console
#      neovim
#    ];
    };
  };
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages to be installed in system profile.
  environment.systemPackages = with pkgs; [
    auto-cpufreq
    baobab
    bat
    brave
    curl
    fragments
    fzf
    gcc
    gh
    git
    github-desktop
    gnome-console
    gnome.eog
    gnome.gnome-backgrounds
    gnome.gnome-boxes
    gnome.gnome-calculator
    gnome.gnome-clocks
    gnome.gnome-control-center
    gnome.gnome-keyring
    gnome.gnome-session
    gnome.gnome-settings-daemon
    gnome.gnome-tweaks
    gnome.nautilus
    gnome-secrets
    gnumake
    gparted
    htop
    joplin-desktop
    lsd
    man-db
    ncdu
    neofetch
    neovim
    obs-studio
    onlyoffice-bin
    qjackctl
    shellcheck
    starship
    thermald
    tldr
    trash-cli
    vlc
    vscodium
    wget
    xdg-desktop-portal
    xdg-desktop-portal-gnome
    xdg-user-dirs
    xsel
    zoxide
    zsh
  ];

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;

  # This way we can set environment variables
  environment.sessionVariables = rec {
    ZDOTDIR = "$HOME/.config/zsh";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  }; 
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect / GSConnect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect / GSConnect
    ];
  };

  # Install fonts
  fonts.packages = with pkgs; [
    cantarell-fonts
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Automation
  nix = {
    extraOptions = ''
      min-free = ${toString (5120 * 1024 * 1024)}
      max-free = ${toString (10240 * 1024 * 1024)}
    '';
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 1d";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
