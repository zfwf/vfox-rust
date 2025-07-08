--- Each SDK may have different environment variable configurations.
--- This allows plugins to define custom environment variables (including PATH settings)
--- Note: Be sure to distinguish between environment variable settings for different platforms!
--- @param ctx table Context information
--- @field ctx.path string SDK installation directory
function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path or (ctx.main and ctx.main.path) or ""
    return {
        {
            key = "RUST_TOOLCHAIN",
            value = ctx.version
        },
    }
end
