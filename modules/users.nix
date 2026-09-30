{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.amos = {
    isNormalUser = true;
    description = "Amos";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "podman"
      "wheel"
    ];
    subGidRanges = [
      {
        count = 65536;
        startGid = 100000;
      }
    ];
    subUidRanges = [
      {
        count = 65536;
        startUid = 100000;
      }
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "amos" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
