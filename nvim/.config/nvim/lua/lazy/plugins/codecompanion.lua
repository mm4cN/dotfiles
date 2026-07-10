return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      "j-hui/fidget.nvim",
    },

    opts = function()
      return {
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

        strategies = {
          chat = {
            adapter = "copilot",
            completion_provider = nil,
            roles = {
              user = "mm4cn",
            },
          },
          inline = {
            adapter = "copilot",
          },
          cmd = {
            adapter = "copilot",
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = false,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },

          history = {
            enabled = true,
            opts = {
              keymap = "gh",
              save_chat_keymap = "sc",
              auto_save = true,
              expiration_days = 0,
              picker = "telescope",
              auto_generate_title = true,
              continue_last_chat = false,
              delete_on_clearing_chat = false,
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",

              title_generation_opts = {
                adapter = "copilot",
                model = nil,
                refresh_every_n_prompts = 0,
                max_refreshes = 3,
                format_title = function(original_title)
                  return original_title
                end,
              },

              summary = {
                create_summary_keymap = "gcs",
                browse_summaries_keymap = "gbs",
                generation_opts = {
                  adapter = nil,
                  model = nil,
                  context_size = 90000,
                  include_references = true,
                  include_tool_outputs = true,
                },
              },

              memory = {
                auto_create_memories_on_summary_generation = true,
                vectorcode_exe = "vectorcode",
                tool_opts = {
                  default_num = 10,
                },
                notify = true,
                index_on_startup = false,
              },
            },
          },
        },

        tools = {
          opts = {
            auto_submit_success = true,
            auto_submit_errors = true,
          },
        },

        display = {
          action_palette = {
            provider = "telescope",
            title = " CodeCompanion actions ",
            show_action_kind = true,
          },

          chat = {
            intro_message = "󰚩 CodeCompanion ready. Press ? for spells.",
            separator = "─",
            show_settings = true,
            show_token_count = true,
            show_reasoning = false,
            fold_context = true,

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
        pattern = "codecompanion",
        callback = function()
          vim.treesitter.start(0, "markdown")
        end,
      })
      require("codecompanion.config").display.chat.window.opts.laststatus = nil

      local spinner = {
        completed = "󰗡 Completed",
        error = " Error",
        cancelled = "󰜺 Cancelled",
      }

      local function format_adapter(adapter)
        local parts = {}

        if adapter.formatted_name then
          table.insert(parts, adapter.formatted_name)
        elseif adapter.name then
          table.insert(parts, adapter.name)
        else
          table.insert(parts, "CodeCompanion")
        end

        if adapter.model and adapter.model ~= "" then
          table.insert(parts, "(" .. adapter.model .. ")")
        end

        return table.concat(parts, " ")
      end

      local function codecompanion_spinner()
        local ok, progress = pcall(require, "fidget.progress")
        if not ok then
          return
        end

        spinner.handles = {}

        local group = vim.api.nvim_create_augroup("mm4cn.codecompanion.spinner", {
          clear = true,
        })

        vim.api.nvim_create_autocmd("User", {
          pattern = "CodeCompanionRequestStarted",
          group = group,
          callback = function(args)
            local handle = progress.handle.create({
              title = "",
              message = " Sending...",
              lsp_client = {
                name = format_adapter(args.data.adapter),
              },
            })

            spinner.handles[args.data.id] = handle
          end,
        })

        vim.api.nvim_create_autocmd("User", {
          pattern = "CodeCompanionRequestFinished",
          group = group,
          callback = function(args)
            local handle = spinner.handles[args.data.id]
            spinner.handles[args.data.id] = nil

            if not handle then
              return
            end

            if args.data.status == "success" then
              handle.message = spinner.completed
            elseif args.data.status == "error" then
              handle.message = spinner.error
            else
              handle.message = spinner.cancelled
            end

            handle:finish()
          end,
        })
      end

      codecompanion_spinner()
    end,
  },
}
