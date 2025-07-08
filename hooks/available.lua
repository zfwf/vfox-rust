local http = require("http")

-- Return all available Rust versions from GitHub tags (public API, no auth)
function PLUGIN:Available(ctx)
    local url = "https://api.github.com/repos/rust-lang/rust/tags"
    local resp, err = http.get({ url = url })
    if not resp or not resp.body then
        return {}
    end
    local body = resp.body
    local versions = {}
    for tag in body:gmatch('"name"%s*:%s*"([^"]+)"') do
        if not tag:find("nightly") and not tag:find("beta") and tag:match("^%d+%.%d+%.%d+$") then
            table.insert(versions, tag)
        end
    end
    table.sort(versions, function(a, b)
        local function split(v)
            local t = {}
            for n in v:gmatch("%d+") do table.insert(t, tonumber(n)) end
            return t
        end
        local va, vb = split(a), split(b)
        for i = 1, math.max(#va, #vb) do
            if (va[i] or 0) ~= (vb[i] or 0) then
                return (va[i] or 0) > (vb[i] or 0)
            end
        end
        return false
    end)
    local result = {}
    for _, v in ipairs(versions) do
        table.insert(result, {
            version = v,
            note = (v == versions[1]) and "Latest" or nil,
        })
    end
    return result
end
