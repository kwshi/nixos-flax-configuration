rec {
  generateBlocks = paths:
    builtins.concatMap ({
      patterns,
      properties,
      children,
    }: let
      selectors = builtins.concatMap (path:
        builtins.map
        (builtins.replaceStrings ["&"] [path])
        patterns)
      paths;
    in
      [{inherit selectors properties;}]
      ++ generateBlocks selectors children);

  stringifyBlock = {
    selectors,
    properties,
  }: let
    selectorsStr = builtins.concatStringsSep "," selectors;
    propertiesStr =
      builtins.concatStringsSep ""
      (builtins.map (name: "${name}:${builtins.getAttr name properties};")
        (builtins.attrNames properties));
  in "${selectorsStr}{${propertiesStr}}";

  stringifyBlocks = blocks:
    builtins.concatStringsSep "" (builtins.map stringifyBlock blocks);

  shorthand = let
    expand =
      builtins.map
      (nodePartial: let
        node =
          if builtins.isFunction nodePartial
          then nodePartial []
          else nodePartial;
      in
        node // {children = expand node.children;});

    make = patterns: properties: children: {
      patterns =
        if builtins.isString patterns
        then [patterns]
        else patterns;
      inherit properties children;
    };
  in
    f: expand (f make);

  compileCss = f: stringifyBlocks (generateBlocks [""] (shorthand f));
}
