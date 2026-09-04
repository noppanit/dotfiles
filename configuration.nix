{ user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;

  # Deliberately no system.defaults block: this repo mirrors this Mac as it
  # already is, not a fresh opinionated setup. Add entries here if you want
  # Nix to start managing specific macOS UI defaults (dark mode, dock, etc).

  nix-homebrew = {
    enable = true;
    inherit user;
  };
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # Deliberately no onActivation.cleanup = "zap" here. That setting removes
    # any brew package/cask not listed below on every switch. Turn it on once
    # you've confirmed the lists below are the complete, correct set you want.
    brews = [
      # what `brew leaves` reported on this machine, unchanged
      "cairo"
      "fswatch"
      "gh"
      "git"
      "git-lfs"
      "jupyterlab"
      "libomp"
      "ollama"
      "python@3.13"
      "rbenv"
      "rustup"
      "sshpass"
      "telnet"
      "tmux"
      "uv"
      "vim"
      "watch"
      "wget"
      # newly added
      "herdr"          # terminal agent multiplexer, https://herdr.dev
      "pi-coding-agent" # Pi coding agent CLI, https://pi.dev
    ];
    casks = [
      "wezterm"
    ];
  };
}
