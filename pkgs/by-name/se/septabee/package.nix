{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  p7zip,
  libgcc,
  libx11,
}:

stdenv.mkDerivation {
  pname = "septabee";
  version = "0.0";
  src = fetchurl {
    url = "https://septabee.nekoweb.org/important_stuff/SEPTABEE_DOWNLOADS/version_B/septabee_linux_B_T9_offline.7z";
    hash = "sha256-3sFcqSShKTokOHXsKkP/rpGsIOQeDKsqlq0G/gNkPt0=";
  };
  nativeBuildInputs = [
    autoPatchelfHook
    p7zip
  ];
  buildInputs = [
    libx11
    libgcc
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mkdir -p $out/share/septabee
    cp -r * $out/share/septabee
    echo "cd $out/share/septabee;./septabee" > $out/bin/septabee
    chmod +x $out/bin/septabee
    runHook postInstall
  '';

}
