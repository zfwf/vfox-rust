## Copilot Instructions for Lua

### General Principles
- Write idiomatic Lua: prefer clear, concise, and readable code.
- Use local variables by default; avoid polluting the global namespace.
- Prefer functions and modules for code organization.
- Use tables for data structures and objects.
- Use `--` for comments and `---` for documentation comments.
- Avoid unnecessary dependencies; use standard Lua features when possible.

### Functions
- Define functions with `local` unless they must be global.
- Prefer explicit argument names and return values.
- Use `function name(args)` or `local function name(args)` for top-level functions.
- Use `function tbl:method(args)` for methods (self is implicit).

### Tables and Modules
- Use tables to group related functions and data.
- Return the table at the end of a module file.
- Example:
```lua
local M = {}

function M.add(a, b)
    return a + b
end

return M
```

### Object-Oriented Patterns
- Use tables and metatables for objects.
- Use the colon syntax for methods: `function MyClass:method(args)`.
- Example:
```lua
local MyClass = {}
MyClass.__index = MyClass

function MyClass.new(x)
    return setmetatable({x = x}, MyClass)
end

function MyClass:get()
    return self.x
end

return MyClass
```

### Error Handling
- Use `assert` for simple error checks.
- Use `pcall` for protected calls if needed.

### String Handling
- Prefer string library functions: `string.format`, `string.match`, etc.
- Use double square brackets for multiline strings if needed.

### Iteration
- Use `ipairs` for array-like tables, `pairs` for generic tables.

### Testing
- Write testable functions: avoid side effects, use return values.
- Use Lua's `busted` or `luaunit` for unit tests if available.

### Style
- Indent with 4 spaces or 2 spaces (be consistent with project).
- Limit line length to 80-100 characters.
- Use snake_case for variables and functions.

### Example: Idiomatic Lua Function
```lua
local function factorial(n)
    assert(n >= 0, "n must be non-negative")
    if n == 0 then return 1 end
    return n * factorial(n - 1)
end
```

### Example: Table as a Simple Module
```lua
local math_utils = {}

function math_utils.sum(t)
    local s = 0
    for _, v in ipairs(t) do s = s + v end
    return s
end

return math_utils
```

### Example: Testable Code
```lua
local function add(a, b)
    return a + b
end

assert(add(2, 3) == 5)
```


### Dependency Management 
- Use `require` to include modules. 
- Do not use external libraries unless necessary because this is a plugin and must work with the vfox app.
