return {
  "bahaaza/mcphub.nvim",
  branch = "main",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  build = "bundled_build.lua",
  cmd = "MCPHub",

  opts = {
    use_bundled_binary = true,

    config = vim.fn.expand("~/.config/mcphub/servers.json"),

    workspace = {
      enabled = true,
      reload_on_dir_changed = true,

      look_for = {
        ".mcphub/servers.json",
        ".vscode/mcp.json",
        ".cursor/mcp.json",
        ".mcp.json",
        ".github/mcp.json",
      },
    },
  },
}
