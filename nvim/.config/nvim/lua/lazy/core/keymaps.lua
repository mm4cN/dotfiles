-- Editor

vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>pp', '"+p')
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>wt', [[:%s/\s\+$//e<CR>]],
  { noremap = true, silent = true, desc = "Trim trailing whitespaces" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = "Quit" })
vim.keymap.set('n', '<leader>qq', ':q!<CR>', { noremap = true, silent = true, desc = "Force quit" })
vim.keymap.set('n', '<leader>qqq', ':qa!<CR>', { noremap = true, silent = true, desc = "Quit that should've listened" })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = "Save" })
vim.keymap.set('n', '<leader>wq', ':wq!<CR>', { noremap = true, silent = true, desc = "Save and quit" })
vim.keymap.set('v', '>', '>gv', { noremap = true, desc = "Indent right" })
vim.keymap.set('v', '<', '<gv', { noremap = true, desc = "Unindent left" })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, desc = "Restart LSP" })

--- Plugins

--- CMake Tools
vim.keymap.set('n', '<leader>cmg', ':CMakeGenerate<CR>', { desc = "Generate Makefiles", noremap = true, silent = true })
vim.keymap.set('n', '<leader>cmb', ':CMakeBuild<CR>', { desc = "Build CMake target", noremap = true, silent = true })
vim.keymap.set('n', '<leader>cmr', ':CMakeRun<CR>', { desc = "Run CMake target", noremap = true, silent = true })
vim.keymap.set('n', '<leader>cmt', ':CMakeRunTest<CR>', { desc = "Execute CTest", noremap = true, silent = true })
vim.keymap.set('n', '<leader>cmc', ':CMakeClean<CR>', { desc = "Clean CMake cache", noremap = true, silent = true })

-- Conan
vim.keymap.set('n', "<leader>coi", ":Conan install<CR>", { desc = "Conan: install", noremap = true })
vim.keymap.set('n', "<leader>cob", ":Conan build<CR>", { desc = "Conan: build", noremap = true })
vim.keymap.set('n', "<leader>col", ":Conan lock<CR>", { desc = "Conan: lock", noremap = true })
vim.keymap.set('n', "<leader>coc", ":Conan create<CR>", { desc = "Conan: create", noremap = true })
vim.keymap.set('n', "<leader>coe", ":Conan export<CR>", { desc = "Conan: export", noremap = true })
vim.keymap.set('n', "<leader>cop", ":Conan export_package<CR>", { desc = "Conan: export_package", noremap = true })
vim.keymap.set('n', "<leader>cou", ":Conan upload<CR>", { desc = "Conan: upload", noremap = true })

--- DAP
local dap = require("dap")
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function() dap.toggle_breakpoint(vim.fn.input("Condition: ")) end,
  { desc = "DAP: Toggle conditional breakpoint" })
vim.keymap.set("n", "<leader>dso", function() dap.step_over() end, { desc = "DAP: Step over" })
vim.keymap.set("n", "<leader>dsi", function() dap.step_into() end, { desc = "DAP: Step into" })
vim.keymap.set("n", "<leader>dst", function() dap.step_out() end, { desc = "DAP: Step out" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>dt", function() dap.terminate() end, { desc = "DAP: Terminate " })

--- Floatterm
vim.keymap.set('n', '<leader>tt', ":FloatermToggle<CR>", { desc = "Floatterm: Toggle", noremap = true })

--- Lazygit
vim.keymap.set('n', "<C-l>g", ":LazyGit<cr>", { desc = "Open lazy git", noremap = true })

--- Move
vim.keymap.set({ 'n', 't' }, '<C-j>', ':MoveLine(1)<CR>', { noremap = true, silent = true, desc = "Move line down" })
vim.keymap.set({ 'n', 't' }, '<C-k>', ':MoveLine(-1)<CR>', { noremap = true, silent = true, desc = "Move line up" })

--- NvimTree
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>",
  { desc = "Toggle file explorer on current file", noremap = true })

--- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

-- PlatformIO
vim.keymap.set("n", "<leader>pin", ":Pioinit<CR>", { desc = "PlatformIO: Init", noremap = true })
vim.keymap.set("n", "<leader>pic", ":Piorun clean<CR>", { desc = "PlatformIO: Clean", noremap = true })
vim.keymap.set("n", "<leader>pib", ":Piorun build<CR>", { desc = "PlatformIO: Build", noremap = true })
vim.keymap.set("n", "<leader>piu", ":Piorun upload<CR>", { desc = "PlatformIO: Upload", noremap = true })

--- CodeCompanion
vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<CR>", {
  desc = "AI: Actions",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", {
  desc = "AI: Toggle chat",
  noremap = true,
  silent = true,
})

vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<CR>", {
  desc = "AI: Inline prompt",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>aC", "<cmd>CodeCompanionCLI<CR>", {
  desc = "AI: CLI agent",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>apc", function()
  require("codecompanion").prompt("cpp-conan")
end, {
  desc = "AI: C++ / Conan agent",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>apr", function()
  require("codecompanion").prompt("rust")
end, {
  desc = "AI: Rust agent",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>apg", function()
  require("codecompanion").prompt("gitlab-ci")
end, {
  desc = "AI: GitLab CI agent",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>apn", function()
  require("codecompanion").prompt("nvim-plugin")
end, {
  desc = "AI: Neovim plugin agent",
  noremap = true,
  silent = true,
})

--- Gitsigns

vim.keymap.set("n", "]h", function()
  require("gitsigns").nav_hunk("next")
end, {
  desc = "Git: Next hunk",
  silent = true,
})

vim.keymap.set("n", "[h", function()
  require("gitsigns").nav_hunk("prev")
end, {
  desc = "Git: Previous hunk",
  silent = true,
})

vim.keymap.set("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, {
  desc = "Git: Preview hunk",
  silent = true,
})

vim.keymap.set("n", "<leader>gi", function()
  require("gitsigns").preview_hunk_inline()
end, {
  desc = "Git: Preview hunk inline",
  silent = true,
})

vim.keymap.set("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, {
  desc = "Git: Stage/unstage hunk",
  silent = true,
})

vim.keymap.set("v", "<leader>gs", function()
  require("gitsigns").stage_hunk({
    vim.fn.line("v"),
    vim.fn.line("."),
  })
end, {
  desc = "Git: Stage selected lines",
  silent = true,
})

vim.keymap.set("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, {
  desc = "Git: Reset hunk",
  silent = true,
})

vim.keymap.set("v", "<leader>gr", function()
  require("gitsigns").reset_hunk({
    vim.fn.line("v"),
    vim.fn.line("."),
  })
end, {
  desc = "Git: Reset selected lines",
  silent = true,
})

vim.keymap.set("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, {
  desc = "Git: Stage buffer",
  silent = true,
})

vim.keymap.set("n", "<leader>gR", function()
  require("gitsigns").reset_buffer()
end, {
  desc = "Git: Reset buffer",
  silent = true,
})

vim.keymap.set("n", "<leader>gD", function()
  require("gitsigns").diffthis()
end, {
  desc = "Git: Diff current buffer",
  silent = true,
})

vim.keymap.set("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, {
  desc = "Git: Blame current line",
  silent = true,
})

vim.keymap.set({ "o", "x" }, "ih", function()
  require("gitsigns").select_hunk()
end, {
  desc = "Git: Select hunk",
  silent = true,
})

--- Diffview

vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", {
  desc = "Git Diffview: Open working tree",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", {
  desc = "Git Diffview: Close",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdt", "<cmd>DiffviewToggleFiles<CR>", {
  desc = "Git Diffview: Toggle files panel",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdf", "<cmd>DiffviewFocusFiles<CR>", {
  desc = "Git Diffview: Focus files panel",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdr", "<cmd>DiffviewRefresh<CR>", {
  desc = "Git Diffview: Refresh",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<CR>", {
  desc = "Git Diffview: Current file history",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdH", "<cmd>DiffviewFileHistory<CR>", {
  desc = "Git Diffview: Repository history",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gdm", "<cmd>DiffviewOpen origin/main...HEAD<CR>", {
  desc = "Git Diffview: Compare branch with origin/main",
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<leader>gds", "<cmd>DiffviewOpen --cached<CR>", {
  desc = "Git Diffview: Show staged changes",
  noremap = true,
  silent = true,
})
