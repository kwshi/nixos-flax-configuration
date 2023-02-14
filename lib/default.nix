lib: rec {

  crawl = path:
    let contents = builtins.readDir path; in
    if builtins.hasAttr "default.nix" contents then path
    else
      let
        names = lib.attrsets.filterAttrs
          (name: type:
            type == "directory"
            || type == "regular" && lib.strings.hasSuffix ".nix" name)
          contents;
      in
      lib.attrsets.mapAttrs'
        (name: type:
          let path' = path + "/${name}"; in
          if type == "directory" then {
            inherit name;
            value = crawl path';
          } else {
            name = lib.strings.removeSuffix ".nix" name;
            value = path';
          }
        )
        names;

}
