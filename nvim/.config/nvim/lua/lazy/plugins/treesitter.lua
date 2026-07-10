return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      local parsers = {
        "bash",
        "c",
        "cpp",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "vim",
        "vimdoc",
        "yaml",
        "zsh",
      }

      ts.install(parsers)

      local disabled = {
        markdown = true,
        markdown_inline = true,
      }

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype

          if disabled[ft] then
            return
          end

          pcall(vim.treesitter.start, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype

          if disabled[ft] then
            return
          end

          vim.bo[args.buf].indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
}
