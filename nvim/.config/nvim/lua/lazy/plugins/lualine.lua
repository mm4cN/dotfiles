return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'yavorski/lualine-macro-recording.nvim',
  },
  config = function()
    vim.opt.laststatus = 3
    local function codecompanion_status()
      local meta = _G.codecompanion_chat_metadata
      if not meta then
        return ""
      end

      local bufnr = vim.api.nvim_get_current_buf()
      local chat = meta[bufnr]

      if not chat then
        return ""
      end

      local adapter = chat.adapter
      local adapter_name = type(adapter) == "table" and adapter.name or adapter
      local model =
          chat.model
          or chat.schema_model
          or chat.settings and chat.settings.model
          or type(adapter) == "table" and adapter.model

      if not adapter_name and not model then
        return ""
      end

      return string.format("󰚩 %s (%s)", adapter_name or "CodeCompanion", model or "?")
    end

    local conan_status = require("conan_status")

    local function gitlab_status()
      local status = require("gitlab.statusline").get()

      if not status or not status.text then
        return ""
      end

      return ": " .. status.text
    end
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = 'gruvbox',
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename", "filesize", "macro_recording", "%S" },
        lualine_x = { codecompanion_status, gitlab_status, conan_status.component, "selectioncount", "searchcount", "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }
    })
  end
}
