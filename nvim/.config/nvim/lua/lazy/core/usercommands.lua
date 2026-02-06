vim.api.nvim_create_user_command("PlugReload",
  function(opts)
    local plugin_name = opts.args
    if plugin_name == nil then
      vim.notify("No plugin specified!", vim.log.levels.ERROR)
    end
    if package.loaded[plugin_name] ~= nil then
      package.loaded[plugin_name] = nil
      require(plugin_name).setup()
    end
  end,
  { nargs = 1, desc = "Plugin to reload" }
)

vim.api.nvim_create_user_command("LspRestart", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    vim.notify("No LSP clients attached", vim.log.levels.WARN)
    return
  end

  for _, client in ipairs(clients) do
    client.stop()
  end

  vim.cmd("edit")
  vim.notify("LSP restarted", vim.log.levels.INFO)
end, {})

