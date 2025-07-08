--- Extension point, called after PreInstall, can perform additional operations,
--- such as file operations for the SDK installation directory or compile source code
--- Currently can be left unimplemented!
function PLUGIN:PostInstall(ctx)
    -- ctx.rootPath SDK installation directory

    local util = require("util")
    local rootPath = ctx.rootPath
    local sdkInfo = ctx.sdkInfo['rust']
    local path = sdkInfo.path
    local version = sdkInfo.version
    local name = sdkInfo.name
    local note = sdkInfo.note

    -- run rustup script/exe
    local rustupScript = path .. (package.config:sub(1, 1) == '\\' and "/rustup-init.exe" or "/rustup-init.sh")
    if package.config:sub(1, 1) == '\\' then
        os.execute(string.format(
            "cmd /c \"%s -q -y --default-toolchain=%s\"", path,
            path, rustupScript, version))
    else
        os.execute(string.format(
            "sh -c \"cat %s | sh -s -- -q -y --default-toolchain=%s\"", path,
            path, rustupScript, version))
    end
end
