local function map(mode, lhs, rhs, desc, opts)
  vim.keymap.set(
    mode,
    lhs,
    rhs,
    vim.tbl_extend("force", {
      noremap = true,
      silent = true,
      desc = desc,
    }, opts or {})
  )
end

local function cmd(mode, lhs, command, desc, opts)
  map(mode, lhs, ("<cmd>%s<CR>"):format(command), desc, opts)
end

-- Editor

map("v", "<leader>y", '"+y', "Yank to system clipboard")
map("n", "<leader>pp", '"+p', "Paste from system clipboard")

cmd("n", "<leader>h", "nohlsearch", "Clear search highlights")

cmd(
  "n",
  "<leader>wt",
  [[%s/\s\+$//e]],
  "Trim trailing whitespaces"
)

cmd("n", "<leader>q", "q", "Quit")
cmd("n", "<leader>qq", "q!", "Force quit")
cmd("n", "<leader>qqq", "qa!", "Quit that should've listened")

cmd("n", "<leader>w", "w", "Save")
cmd("n", "<leader>wq", "wq!", "Save and quit")

map("v", ">", ">gv", "Indent right")
map("v", "<", "<gv", "Unindent left")

map(
  "t",
  "<Esc><Esc>",
  "<C-\\><C-n>",
  "Exit terminal mode"
)

cmd("n", "<leader>lr", "LspRestart", "Restart LSP")

-- Plugins

-- CMake Tools

cmd(
  "n",
  "<leader>cmg",
  "CMakeGenerate",
  "Generate Makefiles"
)

cmd(
  "n",
  "<leader>cmb",
  "CMakeBuild",
  "Build CMake target"
)

cmd(
  "n",
  "<leader>cmr",
  "CMakeRun",
  "Run CMake target"
)

cmd(
  "n",
  "<leader>cmt",
  "CMakeRunTest",
  "Execute CTest"
)

cmd(
  "n",
  "<leader>cmc",
  "CMakeClean",
  "Clean CMake cache"
)

-- Conan

cmd(
  "n",
  "<leader>coi",
  "Conan install",
  "Conan: install"
)

cmd(
  "n",
  "<leader>cob",
  "Conan build",
  "Conan: build"
)

cmd(
  "n",
  "<leader>col",
  "Conan lock",
  "Conan: lock"
)

cmd(
  "n",
  "<leader>coc",
  "Conan create",
  "Conan: create"
)

cmd(
  "n",
  "<leader>coe",
  "Conan export",
  "Conan: export"
)

cmd(
  "n",
  "<leader>cop",
  "Conan export_package",
  "Conan: export_package"
)

cmd(
  "n",
  "<leader>cou",
  "Conan upload",
  "Conan: upload"
)

-- DAP

local dap = require("dap")

map("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, "DAP: Toggle breakpoint")

map("n", "<leader>dB", function()
  dap.toggle_breakpoint(vim.fn.input("Condition: "))
end, "DAP: Toggle conditional breakpoint")

map(
  "n",
  "<leader>dso",
  dap.step_over,
  "DAP: Step over"
)

map(
  "n",
  "<leader>dsi",
  dap.step_into,
  "DAP: Step into"
)

map(
  "n",
  "<leader>dst",
  dap.step_out,
  "DAP: Step out"
)

map(
  "n",
  "<leader>dc",
  dap.continue,
  "DAP: Continue"
)

map(
  "n",
  "<leader>dt",
  dap.terminate,
  "DAP: Terminate"
)

-- Floaterm

cmd(
  "n",
  "<leader>tt",
  "FloatermToggle",
  "Floaterm: Toggle"
)

-- Lazygit

cmd(
  "n",
  "<C-l>g",
  "LazyGit",
  "Open lazygit"
)

-- Move

cmd(
  { "n", "t" },
  "<C-j>",
  "MoveLine(1)",
  "Move line down"
)

cmd(
  { "n", "t" },
  "<C-k>",
  "MoveLine(-1)",
  "Move line up"
)

-- Telescope

cmd(
  "n",
  "<leader>ff",
  "Telescope find_files",
  "Fuzzy find files in cwd"
)

cmd(
  "n",
  "<leader><leader>",
  "Telescope oldfiles",
  "Fuzzy find recent files"
)

cmd(
  "n",
  "<leader>lg",
  "Telescope live_grep",
  "Find string in cwd"
)

cmd(
  "n",
  "<leader>fc",
  "Telescope grep_string",
  "Find string under cursor in cwd"
)

-- PlatformIO

cmd(
  "n",
  "<leader>pin",
  "Pioinit",
  "PlatformIO: Init"
)

cmd(
  "n",
  "<leader>pic",
  "Piorun clean",
  "PlatformIO: Clean"
)

cmd(
  "n",
  "<leader>pib",
  "Piorun build",
  "PlatformIO: Build"
)

cmd(
  "n",
  "<leader>piu",
  "Piorun upload",
  "PlatformIO: Upload"
)

-- CodeCompanion

cmd(
  "n",
  "<leader>aa",
  "CodeCompanionActions",
  "AI: Actions"
)

cmd(
  "n",
  "<leader>ac",
  "CodeCompanionChat Toggle",
  "AI: Toggle chat"
)

cmd(
  { "n", "v" },
  "<leader>ai",
  "CodeCompanion",
  "AI: Inline prompt"
)

cmd(
  "n",
  "<leader>aC",
  "CodeCompanionCLI",
  "AI: CLI agent"
)

map("n", "<leader>apc", function()
  require("codecompanion").prompt("cpp-conan")
end, "AI: C++ / Conan agent")

map("n", "<leader>apr", function()
  require("codecompanion").prompt("rust")
end, "AI: Rust agent")

map("n", "<leader>apg", function()
  require("codecompanion").prompt("gitlab-ci")
end, "AI: GitLab CI agent")

map("n", "<leader>apn", function()
  require("codecompanion").prompt("nvim-plugin")
end, "AI: Neovim plugin agent")

-- Gitsigns

map("n", "]h", function()
  require("gitsigns").nav_hunk("next")
end, "Git: Next hunk")

map("n", "[h", function()
  require("gitsigns").nav_hunk("prev")
end, "Git: Previous hunk")

map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, "Git: Preview hunk")

map("n", "<leader>gi", function()
  require("gitsigns").preview_hunk_inline()
end, "Git: Preview hunk inline")

map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, "Git: Stage/unstage hunk")

map("v", "<leader>gs", function()
  require("gitsigns").stage_hunk({
    vim.fn.line("v"),
    vim.fn.line("."),
  })
end, "Git: Stage selected lines")

map("n", "<leader>grh", function()
  require("gitsigns").reset_hunk()
end, "Git: Reset hunk")

map("v", "<leader>grh", function()
  require("gitsigns").reset_hunk({
    vim.fn.line("v"),
    vim.fn.line("."),
  })
end, "Git: Reset selected lines")

map("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, "Git: Stage buffer")

map("n", "<leader>gR", function()
  require("gitsigns").reset_buffer()
end, "Git: Reset buffer")

map("n", "<leader>gD", function()
  require("gitsigns").diffthis()
end, "Git: Diff current buffer")

map("n", "<leader>gb", function()
  require("gitsigns").blame_line({
    full = true,
  })
end, "Git: Blame current line")

map({ "o", "x" }, "ih", function()
  require("gitsigns").select_hunk()
end, "Git: Select hunk")

-- Diffview

cmd(
  "n",
  "<leader>gdo",
  "DiffviewOpen",
  "Git Diffview: Open working tree"
)

cmd(
  "n",
  "<leader>gdc",
  "DiffviewClose",
  "Git Diffview: Close"
)

cmd(
  "n",
  "<leader>gdt",
  "DiffviewToggleFiles",
  "Git Diffview: Toggle files panel"
)

cmd(
  "n",
  "<leader>gdf",
  "DiffviewFocusFiles",
  "Git Diffview: Focus files panel"
)

cmd(
  "n",
  "<leader>gdr",
  "DiffviewRefresh",
  "Git Diffview: Refresh"
)

cmd(
  "n",
  "<leader>gdh",
  "DiffviewFileHistory %",
  "Git Diffview: Current file history"
)

cmd(
  "n",
  "<leader>gdH",
  "DiffviewFileHistory",
  "Git Diffview: Repository history"
)

cmd(
  "n",
  "<leader>gdm",
  "DiffviewOpen origin/main...HEAD",
  "Git Diffview: Compare branch with origin/main"
)

cmd(
  "n",
  "<leader>gds",
  "DiffviewOpen --cached",
  "Git Diffview: Show staged changes"
)

-- GitLab

cmd(
  "n",
  "<leader>gla",
  "GitlabAuth",
  "GitLab: Authenticate"
)

cmd(
  "n",
  "<leader>glh",
  "GitlabHealth",
  "GitLab: Health check"
)

cmd(
  "n",
  "<leader>glv",
  "GitlabCiValidate",
  "GitLab CI: Validate"
)

cmd(
  "n",
  "<leader>glpr",
  "GitlabPipelineRun",
  "GitLab Pipeline: Run"
)

cmd(
  "n",
  "<leader>glpl",
  "GitlabPipelineList",
  "GitLab Pipeline: List"
)

cmd(
  "n",
  "<leader>gljl",
  "GitlabJobList",
  "GitLab Job: List"
)

-- Mini Files

map("n", "<leader>ee", function()
  require("mini.files").open()
end, "File explorer: Open")

map("n", "<leader>ef", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, "File explorer: Open current file")

-- Harpoon
local harpoon = require('harpoon')
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end
map("n", "<leader>a", function() harpoon:list():add() end)
map("n", "<leader>d", function() harpoon:list():remove() end)
map("n", "<leader>e", function() toggle_telescope(harpoon:list()) end, "Open harpoon window")
map("n", "<leader>P", function() harpoon:list():prev() end)
map("n", "<leader>N", function() harpoon:list():next() end)

map('n', '<C-j>', ':MoveLine(1)<CR>', "Move line down")
map('n', '<C-k>', ':MoveLine(-1)<CR>', "Move line up")
map('v', '<C-j>', ':MoveBlock(1)<CR>', "Move line down")
map('v', '<C-k>', ':MoveBlock(-1)<CR>', "Move line up")
