return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  cmd = "MCPHub",
  config = function()
    local home = vim.env.HOME
    local config_dir = home .. "/.config/mcp"
    local config_path = config_dir .. "/servers.json"

    vim.fn.mkdir(config_dir, "p")

    local servers = {
      mcpServers = {
        filesystem = {
          command = "npx",
          args = {
            "-y",
            "@modelcontextprotocol/server-filesystem",
            home,
          },
        },

        git = {
          command = "uvx",
          args = {
            "mcp-server-git",
          },
        },

        memory = {
          command = "npx",
          args = {
            "-y",
            "@modelcontextprotocol/server-memory",
          },
        },
      },
    }

    vim.fn.writefile({
      vim.json.encode(servers),
    }, config_path)

    require("mcphub").setup({
      port = 3000,
      config = config_path,
    })
  end,
}
