with import <nixpkgs> {};

runCommand "wifi-toggle" {
  src = ../bin/wifi-toggle.sh;
  buildInputs = [ bash makeWrapper ];
} ''
  mkdir -p $out/bin
  cp $src $out/bin/wifi-toggle
  chmod +x $out/bin/wifi-toggle
''
# Source: https://discourse.nixos.org/t/usr-local-bin-equivalent-in-nixos-filesystem/3776/7
