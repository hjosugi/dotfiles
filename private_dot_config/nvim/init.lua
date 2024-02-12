local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'jayp0521/mason-null-ls.nvim',
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets", 'saadparwaiz1/cmp_luasnip' },
  },
  'dinhhuy258/git.nvim',
  'lewis6991/gitsigns.nvim',
  'vim-jp/vimdoc-ja',
  'kylechui/nvim-surround',
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig',
  'nvimtools/none-ls.nvim',
  'tami5/lspsaga.nvim',
  'stevearc/dressing.nvim',
  'ray-x/lsp_signature.nvim',
  'onsails/lspkind-nvim',
  'j-hui/fidget.nvim',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'stevearc/oil.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-lua/telescope.nvim',
  'nvim-lualine/lualine.nvim',
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",       opts = {} },
  {
    "tversteeg/registers.nvim",
    cmd = "Registers",
    config = true,
    keys = {
      { "\"",    mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    name = "registers",
  },

  { "nvim-treesitter/nvim-treesitter",     build = ":TSUpdate" },
  'sainnhe/gruvbox-material',
  'github/copilot.vim',
  'ahmedkhalf/project.nvim',
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {

    },
    version = '^1.0.0',
  },
  {
    'numToStr/Comment.nvim',
    opts = {}
  }
})


require("project_nvim").setup()
-- set options
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.updatetime = 500
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.clipboard = unnamed

-- map prefix
vim.g.mapleader = ' '
vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>')
vim.keymap.set({ 'n', 'x' }, '<Plug>(lsp)', '<Nop>')
vim.keymap.set({ 'n', 'x' }, 'm', '<Plug>(lsp)')
vim.keymap.set({ 'n', 'x' }, '<Plug>(ff)', '<Nop>')
vim.keymap.set({ 'n', 'x' }, ';', '<Plug>(ff)')

-- telescope.nvim
require('telescope').setup({
  defaults = {
    mappings = {
      n = {
        ['<Esc>'] = require('telescope.actions').close,
        ['<C-g>'] = require('telescope.actions').close,
      },
      i = {
        ['<C-g>'] = require('telescope.actions').close,
      },
    },
  },
})
vim.keymap.set({ 'n' }, '<Plug>(ff)r', '<Cmd>Telescope find_files<CR>')
vim.keymap.set({ 'n' }, '<Plug>(ff)s', '<Cmd>Telescope git_status<CR>')
vim.keymap.set({ 'n' }, '<Plug>(ff)b', '<Cmd>Telescope buffers<CR>')
vim.keymap.set({ 'n' }, '<Plug>(ff)f', '<Cmd>Telescope live_grep<CR>')

-- nvim-lsp
local lsp_config = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local mason_null_ls = require('mason-null-ls')
local null_ls = require('null-ls')

require('dressing').setup()
require('lsp_signature').setup({ hint_enable = false })
require('fidget').setup()

mason.setup()
mason_null_ls.setup({
  ensure_installed = { 'prettier' },
  automatic_installation = true,
})
null_ls.setup({
  sources = { null_ls.builtins.formatting.prettier },
})


-- https://github.com/williamboman/mason-lspconfig.nvim
mason_lspconfig.setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'pyright',
    'lua_ls',
    'volar',
    'html',
    'cssmodules_ls',
    "gopls",
    "rust_analyzer",
    "taplo",

  },
  automatic_installation = true,
})

mason_lspconfig.setup_handlers({
  function(server_name)
    local opts = {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    }

    lsp_config[server_name].setup(opts)
  end,
})

vim.api.nvim_create_autocmd({ 'CursorHold' }, {
  pattern = { '*' },
  callback = function()
    require('lspsaga.diagnostic').show_cursor_diagnostics()
  end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  callback = function()
    vim.keymap.set({ 'n' }, '<Plug>(lsp)f', function()
      vim.cmd([[EslintFixAll]])
      vim.lsp.buf.format({ name = 'null-ls' })
    end)
  end,
})

local function show_documentation()
  local ft = vim.opt.filetype._value
  if ft == 'vim' or ft == 'help' then
    vim.cmd([[execute 'h ' . expand('<cword>') ]])
  else
    require('lspsaga.hover').render_hover_doc()
  end
end

vim.keymap.set({ 'n' }, 'K', show_documentation)
vim.keymap.set({ 'n' }, '<Plug>(lsp)a', require('lspsaga.codeaction').code_action)
vim.keymap.set({ 'n' }, '<Plug>(lsp)rn', require('lspsaga.rename').rename)
vim.keymap.set({ 'n' }, '<Plug>(lsp)q', '<Cmd>Telescope diagnostics<CR>')
vim.keymap.set({ 'n' }, '<Plug>(lsp)n', require('lspsaga.diagnostic').navigate('next'))
vim.keymap.set({ 'n' }, '<Plug>(lsp)p', require('lspsaga.diagnostic').navigate('prev'))
vim.keymap.set({ 'n' }, '<Plug>(lsp)f', vim.lsp.buf.format)
vim.keymap.set({ 'n' }, '<Plug>(lsp)i', '<Cmd>Telescope lsp_implementations<CR>')
vim.keymap.set({ 'n' }, '<Plug>(lsp)t', '<Cmd>Telescope lsp_type_definitions<CR>')
vim.keymap.set({ 'n' }, '<Plug>(lsp)rf', '<Cmd>Telescope lsp_references<CR>')


-- nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local map = cmp.mapping
require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

cmp.setup({
  enabled = true,
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = map(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = map(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  }),
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = lspkind.cmp_format({
      mode = 'text',
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
})


-- treesitter
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
  ensure_installed = { "vim",
    "dockerfile",
    "typescript",
    "tsx",
    "javascript",
    "json",
    "lua",
    "gitignore",
    "css",
    "scss",
    "yaml",
    "toml",
    "vue",
    "php",
    "html",
    "python",
    "rust",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- catpuucin用
    disable = {},
  },
  indent = {
    enable = true,
    disable = {
      -- "html"
    },
  },
  autotag = {
    enable = true,
  },
}

-- gruvbox
vim.cmd.colorscheme('gruvbox-material')


-- oil.nvim
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.opt.clipboard:append { 'unnamedplus' }


-- bufferline close setting
vim.keymap.set('n', '<leader>wl', '<CMD>BufferLineCloseRight<CR>')
vim.keymap.set('n', '<leader>wh', '<CMD>BufferLineCloseLeft<CR>')
vim.keymap.set('n', '<leader>wall', '<CMD>BufferLineCloseOthers<CR>')
vim.keymap.set('n', '<leader>we', '<CMD>BufferLinePickClose<CR>')

-- (reference)https://github.com/kazhala/dotfiles/blob/master/.config/nvim/lua/kaz/plugins/bufferline.lua
vim.keymap.set('n', 'gb', '<CMD>BufferLinePick<CR>')
vim.keymap.set('n', '<leader>ts', '<CMD>BufferLinePickClose<CR>')
vim.keymap.set('n', '<S-l>', '<CMD>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-h>', '<CMD>BufferLineCyclePrev<CR>')
vim.keymap.set('n', ']b', '<CMD>BufferLineMoveNext<CR>')
vim.keymap.set('n', '[b', '<CMD>BufferLineMovePrev<CR>')
vim.keymap.set('n', 'gs', '<CMD>BufferLineSortByDirectory<CR>')

require("ibl").setup()
