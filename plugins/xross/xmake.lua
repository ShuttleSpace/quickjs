task("xross")
  set_category("plugin")
  on_run("main")
  set_menu {
    usage = "xmake xross [platform] [arch]",
    description = "build cross platform",
    options = {
      {nil, "platform", "v", nil, "target platform.\n\tiphoneos|linux|macosx|mingw|android"},
      {nil, "arch", "v", nil, "target arch.\n\tiphoneos: armv7|armv7s|arm64|i386|x86_64\n\tlinux: arm64|x86_64\n\tmacosx: arm64|x86_64\n\tmingw: arm64|x86_64\n\tandroid: arm64-v8a|armeabi-v7a|x86_64"}
    }
  }