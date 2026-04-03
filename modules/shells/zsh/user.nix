{ pkgs, config, assets, ... }: {
  home.file.".p10k.zsh".source = "${assets}/p10k.zsh";

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -a";

      ff = "fastfetch";
      icat = "kitten icat";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      bindkey "^[[1;5D" backward-word # ctrl left
      bindkey "^[[1;5C" forward-word # ctrl right
      bindkey "^H" backward-kill-word # ctrl back
      bindkey "^[[3;5~" kill-word # ctrl del

      zstyle ':completion*' menu select
      zstyle ':completion*' rehash true
    '';
  };
}
