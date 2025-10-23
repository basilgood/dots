{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    moonlight-qt
    fd
    duf
    ripgrep
    tldr
    wl-clipboard # Copy-paste in Wayland
    gh
    exiftool # To get exif data of files.
    ffmpegthumbnailer # For thumbnails.
    ffmpeg
    file
    glow # For previewing markdown files.
    jq # For previewing JSON files.
    poppler
    ripgrep # For fg.yazi plugin.
    ripdrag # Drag and Drop utilty
    unar # for previewing archive files.
    ouch # for previewing archive files.
    mupdf # for pdf
    archivemount
    qimgv
    tmuxinator
    audio-recorder
    bitwarden-desktop
    blanket
    difftastic
    gh-dash
    gtimelog
    jq
    kind
    kubectl
    kube-linter
    kubernetes-helm
    lazydocker
    libnotify
    minikube
    motrix
    nextcloud-client
    pavucontrol
    playerctl
    pulsemixer
    qbittorrent
    sops
    age
    element-desktop
    telegram-desktop
    terraform
    thunderbird
    vlc
    vlc-bittorrent
    zk
    yt-dlp
    ytfzf
  ];
}
