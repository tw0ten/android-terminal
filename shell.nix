{ pkgs ? import <nixpkgs> {
  config.android_sdk.accept_license = true;
  config.allowUnfree = true;
} }:

let
  jdk = pkgs.openjdk21;

  android = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "35.0.0" "36.0.0" ];
    platformVersions = [ "35" "36" ];
    includeNDK = true;
    ndkVersion = "29.0.14206865";
  };

  ANDROID_SDK_ROOT = "${android.androidsdk}/libexec/android-sdk";

in pkgs.mkShell {
  buildInputs = [
    jdk
    android.androidsdk
  ];
  JAVA_HOME = jdk.home;
  TERMUX_APK_VERSION_TAG = "2.10";
  inherit ANDROID_SDK_ROOT;
}
