local vimrc = vim.fn.stdpath('config') .. '/vimrc'
vim.cmd.source(vimrc)

require("mason").setup()

vim.lsp.enable('omnisharp')
vim.lsp.enable('lua-language-server')
vim.lsp.enable('jdtls')

vim.lsp.config['vala-language-server'] = {
  cmd = { 'vala-language-server' },
  filetypes = { 'vala' }
}

vim.lsp.enable('vala-language-server')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local bufmap = function(mode, rhs, lhs)
      vim.keymap.set(mode, rhs, lhs, {buffer = event.buf})
    end

    bufmap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<leader>g.', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap({'i', 's'}, '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    bufmap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', '<leader>grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', '<leader>grd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap({'n', 'x'}, '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
  end,
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sp', builtin.live_grep, { desc = 'Telescope Live grep' })
vim.keymap.set('n', '<leader>g<leader>', builtin.git_files, { desc = 'Telescope git ls-files' })
vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>tp', builtin.tags, { desc = 'Telescope Tags' })
vim.keymap.set('n', '<leader>gS', builtin.lsp_workspace_symbols, { desc = 'Telescope WorkSpace Symbols' })
vim.keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, { desc = 'Telescope Document symbols tags' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'Telescope LSP References tags' })
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = 'Telescope LSP Implementations tags' })
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = 'Telescope LSP Definitions tags' })
