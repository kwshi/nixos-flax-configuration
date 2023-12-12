pkgs: let
  opkgs = pkgs.ocamlPackages;

  runtime-libs = with opkgs; [
    z3
    containers
    yojson
    zarith
    #wayland # error: 'wayland-2.0' is not available for ocaml 4.14.1

    vg
    lambdasoup
    tyxml
    cairo2
  ];

  # https://github.com/NixOS/nixpkgs/blob/8f7b4e88946c61da4cd43d1bcc1c982bb96d9ee8/pkgs/development/tools/ocaml/utop/default.nix#L27
  runtime-env = pkgs.stdenv.mkDerivation {
    name = "ocaml-jupyter-runtime";
    propagatedBuildInputs = runtime-libs ++ [opkgs.findlib opkgs.ppx_yojson_conv_lib];
    dontUnpack = true;
    installPhase = ''
      mkdir -p "$out/etc/ocaml-jupyter-runtime"
      echo "$CAML_LD_LIBRARY_PATH" > "$out/etc/ocaml-jupyter-runtime/CAML_LD_LIBRARY_PATH"
      echo "$OCAMLPATH" > "$out/etc/ocaml-jupyter-runtime/OCAMLPATH"
    '';
  };

  ocaml-jupyter = opkgs.buildDunePackage rec {
    pname = "jupyter";
    version = "2.8.3";
    src = pkgs.fetchFromGitHub {
      owner = "akabe";
      repo = "ocaml-jupyter";
      rev = "v${version}";
      sha256 = "sha256-uMk0rsLqlwkkzB52V5khMyr3rYsn7Mfyq31ybH69KgI=";
    };

    nativeBuildInputs = [opkgs.cppo opkgs.findlib pkgs.makeWrapper];

    buildInputs = with opkgs; [
      runtime-env

      ppx_yojson_conv
      ppx_deriving

      base
      uuidm
      base64
      lwt
      lwt_ppx
      stdint
      zmq
      zmq-lwt
      yojson
      cryptokit
      logs
    ];

    # https://github.com/tweag/jupyenv/blob/3ad2c9512c9efd586cf63adde454e734a8ce049c/modules/kernels/ocaml/default.nix#L82
    postFixup = ''
      wrapProgram "$out/bin/ocaml-jupyter-kernel" \
        --prefix CAML_LD_LIBRARY_PATH : "$CAML_LD_LIBRARY_PATH" \
        --prefix CAML_LD_LIBRARY_PATH : "$(cat '${runtime-env}/etc/ocaml-jupyter-runtime/CAML_LD_LIBRARY_PATH')" \
        --prefix CAML_LD_LIBRARY_PATH : "$out/lib/ocaml/${opkgs.ocaml.version}/site-lib/stublibs" \
        --prefix OCAMLPATH : "$OCAMLPATH" \
        --prefix OCAMLPATH : "$out/lib/ocaml/${opkgs.ocaml.version}/site-lib/" \
        --prefix OCAMLPATH : "$(cat '${runtime-env}/etc/ocaml-jupyter-runtime/OCAMLPATH')"
    '';
  };

  # https://github.com/tweag/jupyenv/blob/3ad2c9512c9efd586cf63adde454e734a8ce049c/modules/kernels/ocaml/default.nix#L78
  init-script = ''
    #use "${opkgs.findlib}/lib/ocaml/${opkgs.ocaml.version}/site-lib/topfind";;
    Topfind.log := ignore;;
  '';
in {
  displayName = "OCaml ${opkgs.ocaml.version}";
  argv = [
    "${ocaml-jupyter}/bin/ocaml-jupyter-kernel"
    "--init"
    "${pkgs.writeText "ocaml-jupyter-kernel-init-script" init-script}"
    "--merlin"
    "${opkgs.merlin}/bin/ocamlmerlin"
    "--verbosity"
    "app"
    "--connection-file"
    "{connection_file}"
  ];
  language = "ocaml";
  logo32 = ./sage.svg;
  logo64 = ./sage.svg;
}
