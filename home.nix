{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/${user}";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    jq        # json on the command line
    lazygit
    neovim
    nerd-fonts.hack # font for wezterm/nvim
  ];
  fonts.fontconfig.enable = true;

  # Matches this machine's current default; not switched to nvim.
  home.sessionVariables.EDITOR = "vim";

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
    shellAliases = {
      ls = "ls -G";
      ll = "ls -lhG";
      la = "ls -lahG";
      cc = "claude --dangerously-skip-permissions";
    };
    initContent = ''
      # rbenv
      eval "$(${pkgs.rbenv}/bin/rbenv init - zsh)"

      # Local bin
      if [ -f "$HOME/.local/bin/env" ]; then
        . "$HOME/.local/bin/env"
      fi

      # Colors
      export LSCOLORS="GxFxCxDxBxEgEdabagacad"
    '';
  };

  # Edit-in-place: the real file stays in this repo, home-manager just points at it.
  home.file.".gitconfig".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.gitconfig";
  home.file.".vimrc".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.vimrc";
  home.file.".tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.tmux.conf";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
}
