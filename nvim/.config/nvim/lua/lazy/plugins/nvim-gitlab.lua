return {
  "mm4cN/nvim-gitlab",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('gitlab').setup({
      picker = "telescope",
    })
  end
}
