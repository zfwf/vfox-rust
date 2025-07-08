--- Returns some pre-installed information, such as version number, download address, local files, etc.
--- If checksum is provided, vfox will automatically check it for you.
--- @param ctx table
--- @field ctx.version string User-input version
--- @return table Version information
function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    if not version or version == "" then
        return {}
    end
    local platform = "unknown-linux-gnu"
    local arch = "x86_64"
    local uname = io.popen("uname -m"):read("*l")
    if uname:match("^arm") or uname:match("^aarch64") then
        arch = "aarch64"
    elseif uname:match("^i[3-6]86$") then
        arch = "i686"
    elseif uname:match("^x86_64$") then
        arch = "x86_64"
    end

    return {
        version = version,
        url = "https://static.rust-lang.org/rustup/rustup-init.sh",
        note = "Rust toolchain " .. version,
    }
end
