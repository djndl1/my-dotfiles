local vimrc = vim.fn.stdpath('config') .. '/vimrc'
vim.cmd.source(vimrc)

vim.g.gutentags_project_root = {'.project_root'}

require("mason").setup()
require("mason-lspconfig").setup()

vim.g.coq_settings = {
  ['auto_start'] = false,
  keymap = {
    pre_select = true
  }
}
require("coq")

local cmp = require 'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      vim.snippet.expand(args.body)       -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ctags' },
    { name = 'ultisnips' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
      vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
    end

    bufmap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<leader>g.', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap({ 'i', 's' }, '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    bufmap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', '<leader>grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', '<leader>grd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap({ 'n', 'x' }, '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap({ 'n' }, '<leader>gl', '<cmd>lua vim.diagnostic.setloclist()<cr>')
  end,
})

require('telescope').setup {
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      height = 0.8,
      width = 0.95
    }
  }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', function() builtin.find_files { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sp', function() builtin.live_grep { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Live grep' })
vim.keymap.set('n', '<leader>g<leader>', function() builtin.git_files { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope git ls-files' })
vim.keymap.set('n', '<leader>ss',
  function() builtin.current_buffer_fuzzy_find { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>tp', function() builtin.tags { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Tags' })
vim.keymap.set('n', '<leader>ts', function() builtin.current_buffer_tags { ctags_file = 'ctags', default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Current Buffer Tags' })
vim.keymap.set('n', '<leader>gS',
  function() builtin.lsp_workspace_symbols { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope WorkSpace Symbols' })
vim.keymap.set('n', '<leader>gs', function() builtin.lsp_document_symbols { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Document symbols ' })
vim.keymap.set('n', '<leader>gr', function() builtin.lsp_references { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope LSP References ' })
vim.keymap.set('n', '<leader>gi', function() builtin.lsp_implementations { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope LSP Implementations ' })
vim.keymap.set('n', '<leader>gd', function() builtin.lsp_definitions { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope LSP Definitions ' })
vim.keymap.set('n', '<leader>ge', function() builtin.diagnostics { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Current Diagnostics ' })

local config_path = vim.fn.stdpath("config")
local site_vimrc_path = config_path .. "/lua/site_vimrc.lua"

if vim.fn.filereadable(site_vimrc_path) ~= 0 then
  require('site_vimrc')
end


