return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "auto",
            },
          },
        })
      end,
    },

    opts = function()
      return {
        strategies = {
          chat = {
            adapter = "copilot",
            completion_provider = nil,
          },
          inline = {
            adapter = "copilot",
          },
          cmd = {
            adapter = "copilot",
          },
        },

        tools = {
          opts = {
            auto_submit_success = true,
            auto_submit_errors = true,
          },

          ["fetch_webpage"] = {
            opts = {
              require_approval_before = false,
            },
          },

          ["file_search"] = {
            opts = {
              require_approval_before = false,
              max_results = 500,
            },
          },

          ["get_changed_files"] = {
            opts = {
              require_approval_before = false,
              max_lines = 1000,
            },
          },

          ["get_diagnostics"] = {
            opts = {
              require_approval_before = false,
            },
          },

          ["grep_search"] = {
            opts = {
              require_approval_before = false,
              max_results = 100,
              respect_gitignore = true,
            },
          },

          ["read_file"] = {
            opts = {
              require_approval_before = false,
            },
          },

          ["web_search"] = {
            opts = {
              require_approval_before = false,
            },
          },
        },

        display = {
          chat = {
            intro_message = "󰚩 CodeCompanion ready. Press ? for spells.",
            separator = "─",
            show_settings = true,

            window = {
              layout = "vertical",
              width = 0.42,
              border = "rounded",
              title = " 󰚩 CodeCompanion ",

              opts = {
                number = false,
                relativenumber = false,
                signcolumn = "no",
                foldcolumn = "0",
                cursorline = false,
                wrap = true,
                linebreak = true,
                breakindent = true,
                spell = false,
                list = false,
                colorcolumn = "",
              },
            },
          },
        },

        prompt_library = require("ai.codecompanion.prompts").load(),

        opts = {
          log_level = "INFO",
        },
      }
    end,

    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "codecompanion",
          "codecompanion-chat",
        },
        callback = function()
          pcall(vim.treesitter.stop)

          vim.bo.indentexpr = ""

          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.cursorline = false
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.breakindent = true
          vim.opt_local.spell = false
          vim.opt_local.list = false
          vim.opt_local.colorcolumn = ""
        end,
      })

      vim.api.nvim_set_hl(0, "CodeCompanionChatHeader", {
        bold = true,
        italic = false,
      })

      vim.api.nvim_set_hl(0, "CodeCompanionChatSeparator", {
        bold = true,
      })

      vim.api.nvim_set_hl(0, "CodeCompanionChatTokens", {
        italic = true,
      })
    end,
  },
}
