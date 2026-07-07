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
        return require("codecompanion.adapters").use("copilot")
      end,
    },
    opts = function()
      return {
        strategies = {
          chat = { adapter = "copilot" },
          inline = { adapter = "copilot" },
          cmd = { adapter = "copilot" },
        },
        display = {
          chat = {
            window = {
              layout = "vertical",
              width = 0.42,
            },
          },
        },
        prompt_library = require("ai.codecompanion.prompts").load(),
        opts = {
          log_level = "INFO",
        },
      }
    end,
  },
}
