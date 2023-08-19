lib: rec {

  crawl = path:
    let contents = builtins.readDir path; in
    if builtins.hasAttr "default.nix" contents then path
    else
      lib.trivial.pipe contents [
        (lib.attrsets.filterAttrs
          (name: type:
            type == "directory"
            || type == "regular" && lib.strings.hasSuffix ".nix" name)
        )
        (lib.attrsets.mapAttrs'
          (name: type:
            let path' = path + "/${name}"; in
            if type == "directory" then {
              inherit name;
              value = crawl path';
            } else {
              name = lib.strings.removeSuffix ".nix" name;
              value = path';
            }
          ))
      ];

  flattenCss = prefix: css:
    let
      names = builtins.attrNames css;

      propNames = builtins.filter
        (name: builtins.isString css.${name})
        names;

      subtreeNames = builtins.filter
        (name: builtins.isAttrs css.${name})
        names;

      selectAttrs = names: builtins.listToAttrs
        (builtins.map
          (name: { inherit name; value = css.${name}; })
          names);


      rootSelector = builtins.concatStringsSep " " prefix;
      rootProps =
        builtins.concatStringsSep ""
          (builtins.map
            (name: "${name}:${css.${name}};")
            propNames);

      rootSection = "${rootSelector}{${rootProps}}";

      subsections = builtins.concatMap
        (name: flattenCss (prefix ++ [ name ]) css.${name})
        subtreeNames;
    in
    [ rootSection ] ++ subsections;

  toCss = css: builtins.concatStringsSep ""
    (builtins.attrValues
      (builtins.mapAttrs
        (name: value:
          builtins.concatStringsSep ""
            (flattenCss [ name ] value))
        css));

  color = {
    gruvbox = { };
  };


}
