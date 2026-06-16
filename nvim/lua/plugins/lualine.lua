-- Set lualine as statusline
vim.pack.add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim'
 })

-- Catppuccin Mocha palette: https://github.com/catppuccin/catppuccin
local colors = {
  blue = '#89b4fa',
  green = '#a6e3a1',
  purple = '#cba6f7',
  cyan = '#94e2d5',
  red1 = '#f38ba8',
  red2 = '#eba0ac',
  yellow = '#f9e2af',
  fg = '#cdd6f4',
  bg = '#1e1e2e',
  gray1 = '#7f849c',
  gray2 = '#313244',
  gray3 = '#45475a',
}

local mocha_theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
  insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
  visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
  terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
  replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
  inactive = {
    a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.gray1, bg = colors.bg },
    c = { fg = colors.gray1, bg = colors.gray2 },
  },
}

-- Import color theme based on environment variable NVIM_THEME
local env_var_nvim_theme = os.getenv 'NVIM_THEME' or 'mocha'

-- Define a table of themes
local themes = {
  -- Hand-rolled mocha palette; avoids load-order issues with the named
  -- 'catppuccin' lualine theme, which may not be on the runtimepath yet.
  mocha = mocha_theme,
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 100
end

local mode = {
  'mode',
  fmt = function(str)
    if hide_in_width() then
      return '⚡ ' .. str
    else
      return '⚡ ' .. str:sub(1, 1) -- displays only the first character of the mode
    end
  end,
}

local filename = {
  'filename',
  file_status = true, -- displays file status (readonly status, modified status)
  path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  colored = false,
  update_in_insert = false,
  always_visible = false,
  cond = hide_in_width,
}

local diff = {
  'diff',
  colored = false,
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  cond = hide_in_width,
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = themes[env_var_nvim_theme] or mocha_theme, -- Set theme based on environment variable
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'neo-tree', 'Avante' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { 'branch' },
    lualine_c = { filename },
    lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
    lualine_y = { 'location' },
    lualine_z = { 'progress' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { { 'location', padding = 0 } },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'fugitive' },
}
