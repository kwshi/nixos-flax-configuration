{
  age = {
    identityPaths = [ "/home/kiwi/.ssh/keys/agenix" ];
    secrets = {
      jupyter = {
        file = ./secret/jupyter.age;
        owner = "jupyter";
      };
    };
  };
}
