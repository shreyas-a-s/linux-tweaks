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
  boot = {
    loader = {
      timeout = 1;
      grub = {
        enable = true;
        device = "/dev/vda";
        useOSProber = true;
      };
    };
    kernel.sysctl = { "vm.swappiness" = 10; };
  };

  # Networking.
  networking = {
    hostName = "nixos";
    networkmanager.enable = true; # Enable networking.
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDEConnect/GSConnect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDEConnect/GSConnect
      ];
    };
  };

  # Timezone.
  time.timeZone = "Asia/Kolkata";

  # Locale.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services = {
    xserver = {
      enable = true; # Enable the X11 windowing system.
      displayManager.gdm.enable = true; # Enable the GDM Display Manager.
      displayManager.sessionPackages = [ pkgs.gnome.gnome-session.sessions ]; # Enable Gnome.
      libinput.enable = true; # Enable touchpad support.
      layout = "us"; # Configure keymap in X11.
      xkbVariant = "";
      };
    auto-cpufreq.enable = true;
    thermald.enable = true;
    # printing.enable = true;
    # openssh.enable = true;
  };

  # Suoders tweak.
  security.sudo.extraConfig = "Defaults  pwfeedback";

  # Sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # User profile.
  users = {
    users.USERNAME = {
      isNormalUser = true;
      description = "USERNAME";
      extraGroups = [ "libvirtd" "networkmanager" "wheel" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # System profile.
  environment = {
    # Packages to be installed in system profile.
    systemPackages = with pkgs; [
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
    ];
    # Environment variables.
    sessionVariables = rec {
      ZDOTDIR = "$HOME/.config/zsh";
    };
  };

  # Virtualisation.
  virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;

  # Configuring programs.
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  # mtr.enable = true;
  # gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  };

  # Fonts.
  fonts.packages = with pkgs; [
    cantarell-fonts
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # System Optimization.
  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 1d";
    };
    extraOptions = ''
      min-free = ${toString (5120 * 1024 * 1024)}
      max-free = ${toString (10240 * 1024 * 1024)}
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
