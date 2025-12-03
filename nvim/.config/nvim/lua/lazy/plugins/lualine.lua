return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'yavorski/lualine-macro-recording.nvim',
  },
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = 'gruvbox',
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename", "filesize", "macro_recording", "%S" },
        lualine_x = { "selectioncount", "searchcount", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }
    })
  end
}
