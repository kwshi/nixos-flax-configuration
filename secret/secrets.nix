let
  kiwi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/nhEnhhCt5cNl8rlph/TdywvY99C4eDHJFGy1Y/NV/";
in {
  "jupyter.age".publicKeys = [kiwi];
}
