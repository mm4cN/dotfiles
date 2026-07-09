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
    local copilot_config = home .. "/.copilot/mcp-config.json"

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

        memory = {
          command = "npx",
          args = {
            "-y",
            "@modelcontextprotocol/server-memory",
          },
        },
      },
    }

    -- Merge Copilot MCP servers if available
    if vim.fn.filereadable(copilot_config) == 1 then
      local ok, data = pcall(vim.fn.readfile, copilot_config)
      if ok then
        local ok_json, decoded = pcall(vim.json.decode, table.concat(data, "\n"))
        if ok_json and decoded and decoded.mcpServers then
          for name, server in pairs(decoded.mcpServers) do
            servers.mcpServers[name] = server
          end
        end
      end
    end

    vim.fn.writefile({
      vim.json.encode(servers),
    }, config_path)

    require("mcphub").setup({
      port = 3000,
      config = config_path,
    })
  end,
}
