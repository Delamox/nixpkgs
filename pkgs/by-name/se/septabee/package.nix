{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  p7zip,
  libgcc,
  libx11,
  kdePackages,
  libxkbcommon,
  vulkan-loader,
  libdecor,
  zstd,
  libdrm,
  xz,
  bzip2,
  libxcb-keysyms,
  systemd,
  glibc
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
    kdePackages.wayland
    libxkbcommon
    vulkan-loader
    libdecor
    zstd
    libdrm
    xz
    bzip2
    libxcb-keysyms
    systemd
    glibc
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
  postFixup = ''
    patchelf --add-needed libwayland-client.so.0 $out/share/septabee/septabee
    patchelf --add-needed libxkbcommon.so.0 $out/share/septabee/septabee
    patchelf --add-needed libvulkan.so $out/share/septabee/septabee
    patchelf --add-needed librt.so.1 $out/share/septabee/septabee
    patchelf --add-needed libdecor-0.so.0 $out/share/septabee/septabee
    patchelf --add-needed libdrm_amdgpu.so.1 $out/share/septabee/septabee
    patchelf --add-needed librt.so.1 $out/share/septabee/septabee
    patchelf --add-needed libzstd.so.1 $out/share/septabee/septabee
    patchelf --add-needed liblzma.so.5 $out/share/septabee/septabee
    patchelf --add-needed libbz2.so.1 $out/share/septabee/septabee
    patchelf --add-needed libxcb-keysyms.so.1 $out/share/septabee/septabee
    patchelf --add-needed libsystemd.so.0 $out/share/septabee/septabee

    patchelf --add-needed libwayland-client.so.0 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libxkbcommon.so.0 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libvulkan.so $out/share/septabee/septabee-watchdawg
    patchelf --add-needed librt.so.1 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libdecor-0.so.0 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libdrm_amdgpu.so.1 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed librt.so.1 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libzstd.so.1 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed liblzma.so.5 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libbz2.so.1 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libxcb-keysyms.so.1 $out/share/septabee/septabee-watchdawg
    patchelf --add-needed libsystemd.so.0 $out/share/septabee/septabee-watchdawg

    patchelf --add-needed libwayland-client.so.0 $out/share/septabee/septabee-sounds
    patchelf --add-needed libxkbcommon.so.0 $out/share/septabee/septabee-sounds
    patchelf --add-needed libvulkan.so $out/share/septabee/septabee-sounds
    patchelf --add-needed librt.so.1 $out/share/septabee/septabee-sounds
    patchelf --add-needed libdecor-0.so.0 $out/share/septabee/septabee-sounds
    patchelf --add-needed libdrm_amdgpu.so.1 $out/share/septabee/septabee-sounds
    patchelf --add-needed librt.so.1 $out/share/septabee/septabee-sounds
    patchelf --add-needed libzstd.so.1 $out/share/septabee/septabee-sounds
    patchelf --add-needed liblzma.so.5 $out/share/septabee/septabee-sounds
    patchelf --add-needed libbz2.so.1 $out/share/septabee/septabee-sounds
    patchelf --add-needed libxcb-keysyms.so.1 $out/share/septabee/septabee-sounds
    patchelf --add-needed libsystemd.so.0 $out/share/septabee/septabee-sounds
  '';
}
