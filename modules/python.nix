{ pkgs, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    ipython
    sqlalchemy
    pandas
    numpy
    playwright
    selenium
  ]);
in
{
  # Python and its libraries are managed as one reproducible environment.
  environment.systemPackages = [
    pythonEnv
    pkgs.uv
  ];
}
