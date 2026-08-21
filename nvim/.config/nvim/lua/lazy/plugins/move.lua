return {
  'fedepujol/move.nvim',
  opts = {
      --- Config
  },
  config = function()
    require('move').setup({
      line = {
        enable = true, -- Enables line movement
        indent = true  -- Toggles indentation
      },
      block = {
        enable = true, -- Enables block movement
        indent = true  -- Toggles indentation
      },
    })
  end
}
