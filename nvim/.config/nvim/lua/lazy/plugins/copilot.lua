return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_filetypes = {
      c = false,
      cpp = false,
    }
  end,
}
