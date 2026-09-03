return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },

  opts = {
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },

    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },

    signs_staged_enable = true,
    signcolumn = true,

    numhl = false,
    linehl = false,
    word_diff = false,

    current_line_blame = false,

    watch_gitdir = {
      follow_files = true,
    },

    attach_to_untracked = true,
  },
}
