local M = {}

local prompt_dir = vim.fn.stdpath("config") .. "/prompts/codecompanion"

local prompts = {
  {
    file = "cpp-conan.md",
    alias = "cpp-conan",
    title = "Agent: C++ / Conan",
    description = "C++17/20/23, CMake, Conan 2, tests, refactor, build errors",
  },
  {
    file = "rust.md",
    alias = "rust",
    title = "Agent: Rust",
    description = "Rust, Cargo, FFI, async, borrow checker issues",
  },
  {
    file = "gitlab-ci.md",
    alias = "gitlab-ci",
    title = "Agent: GitLab CI",
    description = "GitLab CI, runners, Docker, Conan cache, artifacts",
  },
  {
    file = "nvim-plugin.md",
    alias = "nvim-plugin",
    title = "Agent: Neovim plugin",
    description = "Lua, lazy.nvim, Telescope, DAP, plugin architecture",
  },
}

local function read_file(path)
  local lines = vim.fn.readfile(path)
  return table.concat(lines, "\n")
end

function M.load()
  local library = {}

  for _, p in ipairs(prompts) do
    local path = prompt_dir .. "/" .. p.file

    library[p.title] = {
      strategy = "chat",
      description = p.description,
      opts = {
        short_name = p.alias,
        auto_submit = false,
      },
      prompts = {
        {
          role = "system",
          content = function()
            return read_file(path)
          end,
        },
        {
          role = "user",
          content = [[
Use the current project and current buffer as context.

Start by briefly stating:
1. what you think the task is,
2. what files or commands you need,
3. what you will change or verify.

Prefer small, safe changes.
Use tools when available.
Do not invent project facts.
]],
        },
      },
    }
  end

  return library
end

return M
