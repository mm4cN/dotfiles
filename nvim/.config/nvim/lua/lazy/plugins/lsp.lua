return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
  },

  config = function()
    local servers = {
      rust_analyzer = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      },
      lua_ls = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          telementry = { enable = false },
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = {
              "${3rd}/luv/library",
              unpack(vim.api.nvim_get_runtime_file("", true)),
            },
          },
          completion = { callSnippet = "Replace" },
        },
      },
      clangd = { source = "ccls" },
      neocmake = {},
      pyright = {},
      gopls = {},
      dockerls = {},
      ts_ls = {},
    }

    require('mason').setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      }
    })

    require('mason-lspconfig').setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
      automatic_enable = false,
    })

    for server_name, server_settings in pairs(servers) do
      vim.lsp.config[server_name] = {
        settings = server_settings,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      }
      vim.lsp.enable(server_name)
    end
  end,
}
