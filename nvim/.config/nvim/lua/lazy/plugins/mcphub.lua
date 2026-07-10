return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  cmd = "MCPHub",

  config = function()
    local home = assert(vim.env.HOME, "$HOME is not defined")

    local config_dir = home .. "/.config/mcp"
    local config_path = config_dir .. "/servers.json"
    local copilot_config = home .. "/.copilot/mcp-config.json"

    vim.fn.mkdir(config_dir, "p")

    local function merge_mcp_config(servers, path)
      if vim.fn.filereadable(path) ~= 1 then
        return false
      end

      local ok_read, data = pcall(vim.fn.readfile, path)
      if not ok_read then
        vim.notify(
          "Could not read MCP config: " .. path,
          vim.log.levels.WARN
        )
        return false
      end

      local ok_decode, decoded = pcall(
        vim.json.decode,
        table.concat(data, "\n")
      )

      if
        not ok_decode
        or type(decoded) ~= "table"
        or type(decoded.mcpServers) ~= "table"
      then
        vim.notify(
          "Invalid MCP config: " .. path,
          vim.log.levels.WARN
        )
        return false
      end

      for name, server in pairs(decoded.mcpServers) do
        servers.mcpServers[name] = server
      end

      return true
    end

    local function find_project_root()
      return vim.fs.root(vim.fn.getcwd(), ".git")
        or vim.fn.getcwd()
    end

    local function find_project_mcp_config()
      local root = find_project_root()

      local candidates = {
        root .. "/.mcp.json",
        root .. "/.github/mcp.json",
      }

      for _, path in ipairs(candidates) do
        if vim.fn.filereadable(path) == 1 then
          return path
        end
      end

      return nil
    end

    local function build_config()
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

      -- Globalne MCP Copilot CLI.
      merge_mcp_config(servers, copilot_config)

      -- Projektowe MCP nadpisują globalne serwery o tej samej nazwie.
      local project_config = find_project_mcp_config()
      if project_config then
        merge_mcp_config(servers, project_config)
      end

      vim.fn.writefile({
        vim.json.encode(servers),
      }, config_path)

      return project_config
    end

    local project_config = build_config()

    require("mcphub").setup({
      port = 3000,
      config = config_path,
    })

    vim.api.nvim_create_user_command("MCPHubRebuildConfig", function()
      local detected = build_config()

      if detected then
        vim.notify(
          "MCPHub config rebuilt with " .. detected,
          vim.log.levels.INFO
        )
      else
        vim.notify(
          "MCPHub config rebuilt without project MCP config",
          vim.log.levels.INFO
        )
      end
    end, {
      desc = "Rebuild MCPHub config from global and project MCP files",
    })

    local group = vim.api.nvim_create_augroup(
      "mm4cn.mcphub.project_config",
      { clear = true }
    )

    vim.api.nvim_create_autocmd("DirChanged", {
      group = group,
      callback = function()
        build_config()
      end,
    })

    if project_config then
      vim.schedule(function()
        vim.notify(
          "MCPHub loaded project config: " .. project_config,
          vim.log.levels.INFO
        )
      end)
    end
  end,
}
