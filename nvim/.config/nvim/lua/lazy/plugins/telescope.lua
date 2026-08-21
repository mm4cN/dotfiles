return {
  "nvim-telescope/telescope.nvim",
  branch = "master",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        layout_strategy = "vertical",

        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist
                + actions.open_qflist,
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          file_ignore_patterns = {
            "^%.git/",
            "^%.cache/",
            "^%.clangd/",
            "%.venv/",
            "node_modules/",
            "venv/",
            "build/",
            "target/",
            "__pycache__/",
          },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
