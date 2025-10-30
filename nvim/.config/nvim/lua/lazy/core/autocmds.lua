vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('RemoveTrailingWhitespace', {clear = true}),
    pattern = {
        '*.c', '*.cpp', '*.h', '*.hpp',
        'CMake*',
        '*.lua',
        'Makefile',
        '*.rs',
    },
    command = '%s/\\s\\+$//e',
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = ".vscode/launch.json",
  callback = function()
    require('dap.ext.vscode').load_launchjs(nil, { lldb = { "c", "cpp", "rust" } })
    print("Reloaded launch.json file.")
  end
})

vim.opt.number = true
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  callback = function()
    vim.wo.relativenumber = true
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  callback = function()
    vim.wo.relativenumber = false
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    vim.diagnostic.config({
      underline = {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
      },
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    })
    vim.o.signcolumn = 'yes:1'
    local telescope = require('telescope.builtin')
    vim.keymap.set('n', '<leader>gd', telescope.lsp_definitions, { desc = "LSP: Definitions" })
    vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = "LSP: Declarations" })
    vim.keymap.set('n', '<leader>gt', telescope.lsp_type_definitions, { desc = "LSP: Type definitions" })
    vim.keymap.set('n', '<leader>gi', telescope.lsp_implementations, { desc = "LSP: Implementations" })
    vim.keymap.set('n', '<leader>gr', telescope.lsp_references, { desc = "LSP: References" })
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, { desc = "LSP: Hover info" })
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = "LSP: Rename" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP: Code action" })
    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = "LSP: Format file" })
    end
  end
})

