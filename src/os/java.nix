{ pkgs, ... }:
{
  environment.etc."jvm/8".source = pkgs.temurin-bin-8;
  environment.etc."jvm/17".source = pkgs.temurin-bin-17;
  environment.etc."jvm/21".source = pkgs.temurin-bin-21;
  environment.etc."jvm/23".source = pkgs.temurin-bin-23;
  environment.etc."jvm/jbr21".source = pkgs.jetbrains.jdk-no-jcef;
  environment.etc."jvm/jbr17".source = pkgs.jetbrains.jdk-no-jcef-17;
  environment.etc."jvm/gr22".source = pkgs.graalvmPackages.graalvm-oracle_22;
  environment.systemPackages = [
    pkgs.graalvmPackages.graalvm-oracle_22
  ];
  environment.etc."jvm/cef".source = pkgs.libcef;
}
