{ config, pkgs, ... }:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "ilya" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ilya" ];

  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [
      "vboxusers"
      "libvirtd"
      "wheel"
      "sudo"
      "networkmanager"
      "wireshark"
    ];
    shell = pkgs.fish;
  };
  security.pki.certificates = [
    ''
      Minky Studios kysCA
      ===================
      -----BEGIN CERTIFICATE-----
      MIIF4zCCA8ugAwIBAgIUZ4l/NP6zwpQkviJYN2nqMU5NZJ0wDQYJKoZIhvcNAQEL
      BQAwgYAxCzAJBgNVBAYTAlJVMRcwFQYDVQQIDA5LcmFzbm9kYXItS3JhaTENMAsG
      A1UEBwwERXlzazEWMBQGA1UECgwNTWlua3kgU3R1ZGlvczETMBEGA1UECwwKTWFu
      YWdlbWVudDEcMBoGA1UEAwwTTWlua3kgU3R1ZGlvcyBreXNDQTAeFw0yNDA4MDYx
      NjE2MDJaFw0yOTA4MDYxNjE2MDJaMIGAMQswCQYDVQQGEwJSVTEXMBUGA1UECAwO
      S3Jhc25vZGFyLUtyYWkxDTALBgNVBAcMBEV5c2sxFjAUBgNVBAoMDU1pbmt5IFN0
      dWRpb3MxEzARBgNVBAsMCk1hbmFnZW1lbnQxHDAaBgNVBAMME01pbmt5IFN0dWRp
      b3Mga3lzQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC+/7TWgKBz
      x9yujXCQv5GS2RQx7hM5DSEa9qfwaiV7gnK2BqqYtmkv6gYSAWJWaVdImj4pE5wb
      /yB6V4aSu+voZirb/H9fh6OuhrbiAAo2GN2OLSduJfVzcL/uFHWfH4CDFajnCXMW
      s7iXsFkWvf6Z0+RMZ2Q1X2tUtEnBVQ/kgWzQIo2LCdx9twBV4v5fdwHw189j1asn
      ssydyzkSZd/HnxHGKobrt/UdRsnxVbSuBc0roDE3FNSuuCY0Q98adgsEcipXS6Mp
      JdhwvATDVLhhN2dQiCmVmAgXqORqtKjieV228rRa3Jvc3+Ej3Rfo42L091eMxg8m
      XoDjW1cvt+4r7A6ZBUWlSsPr+xn1N6GYd+RjQgIGNTFc1fVpwpi6xVJk+F84cmWC
      2RbOU3h75vpKUJGJwwyw0M40Lx/7MKMvwBl9t+SFGUKBF0onHNQHiLAxkfqfFpp+
      Qw/x5FJI50mtAr02cpR4ySDqnYn7fvfgKyF6MGGjYtnOdBlZ4iWbD+14Ppg9/aIg
      7EmblGvxp/vcm4gDmV+uKQBErPUoH/NaIAHnk5d0lzR4unigqWpI2X8zK2FlF+Tk
      EQi7UmSNPIyRglu7vuomqIs0MgM9ShF3z0FX6FOJud2RINrqG/WWy7iMQuPbEhDK
      IIgJg/VXJxKN593CpVxlJiQBY9mSWUx+6QIDAQABo1MwUTAdBgNVHQ4EFgQUeqrT
      8k9x6w8TdAoY407eOfMY9jgwHwYDVR0jBBgwFoAUeqrT8k9x6w8TdAoY407eOfMY
      9jgwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAgEAloWurF5uwzLg
      +LLNab5dWxTu17OuuKb8kUp2DwHKxaDbHW2c500fNCj8O0k6fq5dP83W/gokK+ss
      enu9QVVUN9LwbXatJK+kt45keq9B5ufyYinbwTCsA6wNAp1jiquwhNmWpGwT/uFX
      4G+zREoluASsqT9YbmnUiQyrn3J8WW//sHGv92huGId7y2I141IwYZL+Cdfb1FJf
      dh6YP01qzv7B/pYX5pCAdMimPXLQNU9iMNolXlx7YvcuAZQZ7IYX/gzE7DUyH03s
      14QMKtTeTPeSJRYVBZaBF7Rq6VKfs1pszdE8cF3ZU092W0d8tjAgRMYhr81s//A4
      +SDdHUodTdo3c0/c7MsH50TH9+CClhc/2N3moWGVFFCCI0eDxzW1MakMpFatqq2N
      UkffRrGy8pLUBqG/IpwP6388slV276D3H/cYdObLZhz9VQtE31/vh+2gTUz7gbLg
      qofAi0+FxbtA0YSjcMyyUANscIcwWlfC5Vv7C6OHSoiRfbqO0qa2wyCT2UCK6Nab
      ricvASUbrtXq1EfuZHiN+UY1moyAhY6IeMVt8w/pVGFgZkI/fpBalko4HvW4b6I4
      L9ocvYS2VbMWVWNS2bIkSUH/X2e2Og0Wn0PuB7S9XmODFO9BXgxAtJvcFNsKVSAA
      fsY9BuVQJw8hcMWEKN5qBaqmYMe/gi0=
      -----END CERTIFICATE-----
    ''
  ];
  security.sudo.wheelNeedsPassword = false;
  users.users.root = {
    initialHashedPassword = "";
  };
}
