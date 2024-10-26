import("core.base.option")

local pari = {
  iphoneos = { "armv7", "armv7s", "arm64", "i386", "x86_64" },
  linux = { "arm64", "x86_64" },
  macosx = { "arm64", "x86_64" },
  mingw = {  "arm64", "x86_64" },
  android = { "armeabi", "arm64-v8a", "armeabi-v7a", "x86_64", "x86", "mips", "mips64" }
}

function indexOf(array, value)
  for i, v in ipairs(array) do
      if v == value then
          return i  
      end
  end
  return nil
end

function xmakeBuild(platf, archf)
  if platf and archf then
    print("🔥 ".. platf .. "🌹 " .. archf)
  end
  local config = { "f" }
  if platf then
    table.insert(config, "-p")
    table.insert(config, platf)
  end
  if archf then
    table.insert(config, "-a")
    table.insert(config, archf)
  end
  print("⛰️ xmakeBuild: " .. table.concat(config, ", "))
  os.execv("xmake", config)
  os.execv("xmake", { "package", "-P", ".", "--verbose"})
end

function buildForPlatformArch(platf, archf)
  local hasTarget = false
  local archs = pari[platf]
  if archs then
    if archf then
      if indexOf(archs, archf) then
        xmakeBuild(platf, archf)
        hasTarget = true
      end
    else
      for _, arch in ipairs(archs) do
        xmakeBuild(platf, arch)
      end
      hasTarget = true
    end
  end
  if not hasTarget then
    platf = platf or "Unknown platform"
    archf = archf or "Unknown architecture"
    print("🍄" .. platf .. "-".. archf .. " not supported!") 
  end
end

function main()
  local platf = option.get("platform")
  local archf = option.get("arch")
  if platf or arch then
    buildForPlatformArch(platf, archf)
  else
    xmakeBuild()
  end
end