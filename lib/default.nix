rec {
  flattenCss = prefix: css: let
    names = builtins.attrNames css;

    propNames =
      builtins.filter
      (name: builtins.isString css.${name})
      names;

    subtreeNames =
      builtins.filter
      (name: builtins.isAttrs css.${name})
      names;

    rootSelector = builtins.concatStringsSep " " prefix;
    rootProps =
      builtins.concatStringsSep ""
      (builtins.map
        (name: "${name}:${css.${name}};")
        propNames);

    rootSection = "${rootSelector}{${rootProps}}";

    subsections =
      builtins.concatMap
      (name: flattenCss (prefix ++ [name]) css.${name})
      subtreeNames;
  in
    [rootSection] ++ subsections;

  toCss = css:
    builtins.concatStringsSep ""
    (builtins.attrValues
      (builtins.mapAttrs
        (name: value:
          builtins.concatStringsSep ""
          (flattenCss [name] value))
        css));

  color = {
    gruvbox = {};
  };
}
