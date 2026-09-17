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
  makeDesktopItem
}:
let
  name = "Septabee";
  version = "B_T9";
    icon = fetchurl {
    url = "https://septabee.nekoweb.org/important_stuff/icon.png";
    sha256 = "sha256-snq/nOYU2gPzC4VR558VjeQ8oXmQE82IolNDDixvtTU=";
  };
  description = "A bespoke DAW filled with fruits and where Z stands for Pomegranate";
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
  '';

  desktopItems = [
    (makeDesktopItem {
      name = name;
      desktopName = name;
      icon = icon;
      categories = [
        "AudioVideo"
        "Audio"
        "Music"
        "Midi"
      ];
      comment = description;
      exec = "septabee";
    })
  ];

  meta = {
    homepage = "https://septabee.nekoweb.org";
    description = description;
    licenses = [ lib.licenses.unfreeRedistributable ];
    mainProgram = "septabee";
    platforms = [ "x86_64-linux" ];
  };
}
