nixpkgsLib: rec {
  crawl = path: let
    contents = builtins.readDir path;
  in
    if builtins.hasAttr "default.nix" contents
    then path
    else
      nixpkgsLib.trivial.pipe contents [
        (
          nixpkgsLib.attrsets.filterAttrs
          (name: type:
            type
            == "directory"
            || type == "regular" && nixpkgsLib.strings.hasSuffix ".nix" name)
        )
        (nixpkgsLib.attrsets.mapAttrs'
          (
            name: type: let
              path' = path + "/${name}";
            in
              if type == "directory"
              then {
                inherit name;
                value = crawl path';
              }
              else {
                name = nixpkgsLib.strings.removeSuffix ".nix" name;
                value = path';
              }
          ))
      ];
}
