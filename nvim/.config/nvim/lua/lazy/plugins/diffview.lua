return {
  "sindrets/diffview.nvim",

  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    enhanced_diff_hl = true,

    use_icons = true,

    icons = {
      folder_closed = "",
      folder_open = "",
    },

    signs = {
      fold_closed = "",
      fold_open = "",
      done = "✓",
    },

    view = {
      default = {
        layout = "diff2_horizontal",
        winbar_info = false,
      },

      merge_tool = {
        layout = "diff3_horizontal",
        disable_diagnostics = true,
        winbar_info = true,
      },

      file_history = {
        layout = "diff2_horizontal",
        winbar_info = false,
      },
    },

    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },

      win_config = {
        position = "left",
        width = 35,
      },
    },

    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = "combined",
          },

          multi_file = {
            diff_merges = "first-parent",
          },
        },
      },

      win_config = {
        position = "bottom",
        height = 16,
      },
    },

    commit_log_panel = {
      win_config = {
        position = "bottom",
        height = 16,
      },
    },

    default_args = {
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },

    hooks = {
      diff_buf_read = function()
        vim.opt_local.wrap = false
        vim.opt_local.list = false
        vim.opt_local.relativenumber = false
      end,
    },
  },
}
