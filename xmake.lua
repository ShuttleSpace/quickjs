add_rules("mode.debug", "mode.release")
add_plugindirs("plugins")
target("qjs")
  set_kind("shared")
  add_files("quickjs.c", "libregexp.c", "libunicode.c", "cutils.c", "quickjs-libc.c", "libbf.c")
  add_headerfiles("*.h")
  add_includedirs(".")
  -- add_cflags("-g", "-O2", "-DEBUG", {force=true})
  -- if is_plat("macosx") then
  --   set_config("framework", true)
  --   add_values("xcode.framework.infoplist", "Info.plist")
  --   set_kind("binary")
  --   add_links("AppKit")
  -- elseif is_plat("iphoneos", "iphonesimulator") then
  --   set_kind("static")
  --   add_links("UIKit")
  --   set_config("framework", true)
  --   add_values("xcode.framework.infoplist", "Info.plist")
  -- end
  if is_plat("linux") and get_config("arch") == "x86_64" then
    -- 使用 add_toolchain 来设置工具链
    set_arch("x86_64")
    set_toolchains("gcc")
  end
  if is_plat("macosx", "iphoneos", "iphonesimulator") then 
    -- add_rules("xcode.framework")
  elseif is_plat("mingw") then
    -- target:add("defines",  "WIN32_LEAN_AND_MEAN" .. "_WIN32_WINNT=0x0602" )
  end
  on_load(function (target)
    target:add("defines",  "_GNU_SOURCE" )
  end)