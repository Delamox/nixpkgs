{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  p7zip,
  makeWrapper,
  libx11,
  wayland,
  libxkbcommon,
  vulkan-loader,
  libdecor,
  zstd,
  libdrm,
  xz,
  bzip2,
  libxcb-keysyms,
  systemd,
  alsa-lib,
  libpulseaudio,
  pipewire,
  libjack2,
  libGL,
}:
let
  name = "septabee";
  version = "B_T9";
in stdenv.mkDerivation {
  name = name;
  pname = name;
  version = version;
  src = fetchurl {
    url = "https://septabee.nekoweb.org/important_stuff/SEPTABEE_DOWNLOADS/version_B/septabee_linux_${version}_offline.7z";
    hash = "sha256-3sFcqSShKTokOHXsKkP/rpGsIOQeDKsqlq0G/gNkPt0=";
  };
  nativeBuildInputs = [
    autoPatchelfHook
    p7zip
    makeWrapper
  ];
  buildInputs = [
    libx11
    stdenv.cc.cc.lib
    wayland
    libxkbcommon
    vulkan-loader
    libdecor
    zstd
    libdrm
    xz
    bzip2
    libxcb-keysyms
    systemd
    alsa-lib
    libpulseaudio
    pipewire
    libjack2
    libGL
  ];
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/septabee
    cp -r * $out/share/septabee/

    chmod +x $out/share/septabee/septabee

    makeWrapper $out/share/septabee/septabee $out/bin/septabee \
      --chdir "$out/share/septabee" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [
        vulkan-loader
        alsa-lib
        libpulseaudio
        pipewire
        libjack2
        libGL
        libx11
        wayland
        libxkbcommon
      ]}:/run/opengl-driver/lib:/run/opengl-driver-32/lib"
    runHook postInstall
    cat <<INI > $out/share/applications/septabee.desktop
    [Desktop Entry]
    Name=septabee
    Exec=$out/bin/septabee %f
    Type=Application
    Terminal=false
    INI
  '';
    # Icon=$out/share/hypatia/img/Hypatia_48.ico

  # mkDesktopItem = {
  #   name = name;
  #   desktopName = name;
  #   comment = "A DAW built around audio rate parameter modulation and a ridiculous amount of optimization.";
  #   exec = "$out/bin/septabee";
  # };

  meta = {
    homepage = "https://septabee.nekoweb.org";
    description = "A DAW built around audio rate parameter modulation and a ridiculous amount of optimization.";
    licenses = [ lib.licenses.unfreeRedistributable ];
    platforms = [ "x86_64-linux" ];
  };
}
