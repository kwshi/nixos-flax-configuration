pkgs:
let
  py = pkgs.python3;
  env = py.withPackages (pyPkgs: with pyPkgs; [
    ipykernel
    ipywidgets
    ipympl

    numpy
    sympy
    scipy

    matplotlib
    seaborn
    bokeh

    pandas

    requests
  ]);
in
{
  displayName = "Python ${py.version}";
  argv = [
    "${env.interpreter}"
    "-m"
    "ipykernel_launcher"
    "-f"
    "{connection_file}"
  ];
  language = "python";
  logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
  logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
}
