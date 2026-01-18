local vimrc = vim.fn.stdpath('config') .. '/vimrc'
vim.cmd.source(vimrc)

vim.g.gutentags_project_root = { '.project_root' }

require("mason").setup()
require("mason-lspconfig").setup()

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
vim.lsp.enable('kotlin_language_server')

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
vim.keymap.set('n', '<leader>isf', function() builtin.find_files { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>isp', function() builtin.live_grep { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Live grep' })
vim.keymap.set('n', '<leader>ig<leader>', function() builtin.git_files { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope git ls-files' })
vim.keymap.set('n', '<leader>ss',
  function() builtin.current_buffer_fuzzy_find { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>itp', function() builtin.tags { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Tags' })
vim.keymap.set('n', '<leader>its', function() builtin.current_buffer_tags { default_text = vim.fn.expand("<cword>") } end)
vim.keymap.set('n', '<leader>igS',
  function() builtin.lsp_workspace_symbols { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope WorkSpace Symbols' })
vim.keymap.set('n', '<leader>igs',
  function() builtin.lsp_document_symbols { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Document symbols ' })
vim.keymap.set('n', '<leader>igr', function() builtin.lsp_references { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope LSP References ' })
vim.keymap.set('n', '<leader>igi', function() builtin.lsp_implementations { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope LSP Implementations ' })
vim.keymap.set('n', '<leader>igd', function() builtin.lsp_definitions { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope LSP Definitions ' })
vim.keymap.set('n', '<leader>ige', function() builtin.diagnostics { default_text = vim.fn.expand("<cword>") } end,
  { desc = 'Telescope Current Diagnostics ' })

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sp', builtin.live_grep, { desc = 'Telescope Live grep' })
vim.keymap.set('n', '<leader>g<leader>', builtin.git_files, { desc = 'Telescope git ls-files' })
vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>tp', builtin.tags, { desc = 'Telescope Tags' })
vim.keymap.set('n', '<leader>ts', builtin.current_buffer_tags, { desc = 'Current Buffer Tags' })
vim.keymap.set('n', '<leader>gS', builtin.lsp_workspace_symbols, { desc = 'Telescope WorkSpace Symbols' })
vim.keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, { desc = 'Telescope Document symbols ' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'Telescope LSP References ' })
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = 'Telescope LSP Implementations ' })
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = 'Telescope LSP Definitions ' })
vim.keymap.set('n', '<leader>ge', builtin.diagnostics, { desc = 'Telescope Current Diagnostics ' })

require("conform").setup({
  -- Map of filetype to formatters
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    go = { "goimports", "gofmt" },
    -- You can also customize some of the format options for the filetype
    rust = { "rustfmt", lsp_format = "fallback" },
    cs = { "csharpier", lsp_format = "prefer" },
    -- You can use a function here to determine the formatters dynamically
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- Set this to change the default values when calling conform.format()
  -- This will also affect the default values for format_on_save/format_after_save
  default_format_opts = {
    lsp_format = "fallback",
  },
  -- Set the log level. Use `:ConformInfo` to see the location of the log file.
  log_level = vim.log.levels.ERROR,
  -- Conform will notify you when a formatter errors
  notify_on_error = true,
  -- Conform will notify you when no formatters are available for the buffer
  notify_no_formatters = true,
})

vim.keymap.set('n', "<leader>cf", function()
  require('conform').format()
  end, { desc = "Format Buffer" })

local config_path = vim.fn.stdpath("config")
local site_vimrc_path = config_path .. "/lua/site_vimrc.lua"

if vim.fn.filereadable(site_vimrc_path) ~= 0 then
  require('site_vimrc')
end
