local function copilot()
  return {
    name = "copilot",
    model = "claude-haiku-4.5",
  }
end

return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    event = "VeryLazy",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      "cairijun/codecompanion-agentskills.nvim",
      {
        "bahaaza/mcphub.nvim",
        name = "mcphub.nvim",
      },
      "j-hui/fidget.nvim",
    },

    opts = function()
      return {
        interactions = {
          chat = {
            adapter = copilot(),

            roles = {
              user = "mm4cn",
            },

            tools = {
              file_search = {
                opts = {
                  max_results = 500,
                },
              },

              grep_search = {
                opts = {
                  max_results = 100,
                  respect_gitignore = true,
                  require_approval_before = false,
                },
              },

              read_file = {
                opts = {
                  require_approval_before = false,
                },
              },

              get_changed_files = {
                opts = {
                  max_lines = 1000,
                },
              },

              get_diagnostics = {},

              run_command = {
                opts = {
                  allowed_in_yolo_mode = false,
                  require_approval_before = true,
                  require_cmd_approval = true,
                  judge_in_yolo_mode = false,
                  timeout = 300000,
                },
              },

              opts = {
                default_tools = {
                  "file_search",
                  "grep_search",
                  "read_file",
                  "get_changed_files",
                  "get_diagnostics",
                  "run_command",
                  "agent_skills",
                },

                auto_submit_success = true,
                auto_submit_errors = true,
                notify_on_approval = true,
              },
            },
          },

          inline = {
            adapter = copilot(),
          },

          cmd = {
            adapter = copilot(),
          },
        },

        rules = {
          default = {
            description = "Default rules applicable for project",
            files = {
              ".rules",
              ".github/copilot-instructions.md",
              "AGENT.md",
              "AGENTS.md",
              { path = "CLAUDE.md",           parser = "claude" },
              { path = "CLAUDE.local.md",     parser = "claude" },
              { path = "~/.claude/CLAUDE.md", parser = "claude" },
            },
          },
        },

        extensions = {
          agentskills = {
            opts = {
              disable_demo_skill = true,
              paths = {
                { vim.fn.stdpath('data') .. "/agent-skills", recursive = true },
                { ".skills",                                 recursive = true },
              },
            },
          },

          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = false,
              make_tools = true,
              make_slash_commands = true,
              show_result_in_chat = true,
              show_server_tools_in_chat = true,
              add_mcp_prefix_to_tool_names = false,
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
              dir_to_save = vim.fn.stdpath("data")
                  .. "/codecompanion-history",
              title_generation_opts = {
                adapter = "copilot",
                model = "claude-haiku-4.5",
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
                  adapter = "copilot",
                  model = "claude-haiku-4.5",
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

        display = {
          action_palette = {
            provider = "telescope",
            title = " CodeCompanion actions ",
            show_action_kind = true,
          },

          chat = {
            intro_message = "󰚩 CodeCompanion ready. Press ? for spells.",
            separator = "─",
            show_settings = false,
            show_token_count = true,
            show_reasoning = true,
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

      local ok, progress = pcall(require, "fidget.progress")
      if not ok then
        return
      end

      local spinner = {
        handles = {},
        completed = "󰗡 Completed",
        error = " Error",
        cancelled = "󰜺 Cancelled",
      }

      local function format_adapter(adapter)
        if type(adapter) ~= "table" then
          return "CodeCompanion"
        end

        local parts = {
          adapter.formatted_name
          or adapter.name
          or "CodeCompanion",
        }

        local model = adapter.model

        if type(model) == "table" then
          model = model.name
        end

        if type(model) == "string" and model ~= "" then
          table.insert(parts, "(" .. model .. ")")
        end

        return table.concat(parts, " ")
      end

      local spinner_group = vim.api.nvim_create_augroup(
        "mm4cn.codecompanion.spinner",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequestStarted",
        group = spinner_group,

        callback = function(args)
          local data = args.data or {}

          if not data.id or not data.adapter then
            return
          end

          local old_handle = spinner.handles[data.id]
          if old_handle then
            old_handle:finish()
          end

          spinner.handles[data.id] = progress.handle.create({
            title = "",
            message = " Sending...",

            lsp_client = {
              name = format_adapter(data.adapter),
            },
          })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeCompanionRequestFinished",
        group = spinner_group,

        callback = function(args)
          local data = args.data or {}

          if not data.id then
            return
          end

          local handle = spinner.handles[data.id]
          spinner.handles[data.id] = nil

          if not handle then
            return
          end

          if data.status == "success" then
            handle.message = spinner.completed
          elseif data.status == "error" then
            handle.message = spinner.error
          else
            handle.message = spinner.cancelled
          end

          handle:finish()
        end,
      })
    end,
  },
}
