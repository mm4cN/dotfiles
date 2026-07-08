return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  main = "nvim-treesitter",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  opts = {
    install_dir = vim.fn.stdpath("data") .. "/site",

    autotag = {
      enable = true,
    },

    ensure_installed = {
      "json", "jsonc", "yaml", "html",
      "markdown", "markdown_inline",
      "bash", "lua", "vim",
      "dockerfile", "gitignore", "vimdoc",
      "c", "cpp", "rust", "python", "go",
      "gomod", "gosum", "gowork",
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },

    highlight = {
      enable = true,
      disable = { "markdown", "markdown_inline" },
    },

    indent = {
      enable = true,
      disable = { "markdown", "markdown_inline" },
    },
  },

  config = function(_, opts)
    require("nvim-treesitter").setup(opts)
  end,
}
