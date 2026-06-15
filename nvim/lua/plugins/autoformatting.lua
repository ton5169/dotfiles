vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

-- Formatters not available via Mason (must be installed separately):
--   rustfmt    — ships with Rust toolchain via `rustup component add rustfmt`
--   terraform_fmt — ships with the Terraform/OpenTofu CLI
--
-- Formatters Mason can install: prettier, stylua, sqlfmt
-- Add them to ensure_installed in lsp.lua, or run :MasonInstall <name>
require('conform').setup {
  formatters = {
    ruff_format = {
      prepend_args = {
        '--line-length', '80',
        '--target-version', 'py313',
        '--config', 'format.quote-style = "single"',
      },
    },
  },
  formatters_by_ft = {
    python     = { 'ruff_format' },
    lua        = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    html       = { 'prettier' },
    css        = { 'prettier' },
    scss       = { 'prettier' },
    json       = { 'prettier' },
    jsonc      = { 'prettier' },
    yaml       = { 'prettier' },
    markdown   = { 'prettier' },
    rust       = { 'rustfmt' },
    sql        = { 'sqlfmt' },
    terraform  = { 'terraform_fmt' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback', -- use LSP formatting when no formatter is configured above
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
