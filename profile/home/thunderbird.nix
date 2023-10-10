let
  common-settings = {pass ? null}:
    {
      realName = "Kye Shi";

      thunderbird = {
        enable = true;
        settings = id:
          {
            # TODO this won't needed once upstream release updates: https://github.com/nix-community/home-manager/commit/2b02f8c7cb71098e21f8d67674562c9977caf007
            "mail.server.server_${id}.directory" = ".thunderbird/default/ImapMail/${id}";
            "mail.server.server_${id}.directory-rel" = "[ProfD]ImapMail/${id}";
          }
          // (
            if pass != null
            then {}
            else {
              # no password supplied, use oauth settings (method 10 is oauth2, found via trial and error)
              "mail.server.server_${id}.authMethod" = 10;
              "mail.smtpserver.smtp_${id}.authMethod" = 10;
            }
          );
      };

      gpg = {
        key = "2B3729028457E0AE";
        signByDefault = false;
        encryptByDefault = false;
      };
    }
    // (
      if pass == null
      then {}
      else {
        passwordCommand = "pass show ${pass} | head -n 1";
      }
    );
in {
  accounts.email.accounts = {
    ucla-math =
      {
        primary = true;
        address = "kwshi@ucla.edu";
        userName = "kwshi@ucla.edu";
        flavor = "outlook.office365.com";
      }
      // common-settings {};
    ucla-google =
      {
        address = "kwshi@g.ucla.edu";
        userName = "kwshi@g.ucla.edu";
        flavor = "gmail.com";
      }
      // common-settings {};
    google =
      {
        address = "shi.kye@gmail.com";
        userName = "shi.kye";
        flavor = "gmail.com";
      }
      // common-settings {
        #pass = "google.com/shi.kye@gmail.com";
      };
    hmc =
      {
        address = "kwshi@g.hmc.edu";
        userName = "kwshi@g.hmc.edu";
        flavor = "gmail.com";
      }
      // common-settings {};
  };
  programs.thunderbird = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
      };
    };
  };
}
