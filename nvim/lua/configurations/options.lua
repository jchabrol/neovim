-- Indent setup
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- File search
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest'
vim.o.wildignore = "node_modules/*,bower_components/*,*.swp,*.bak,*.pyc,*.class" .. vim.o.wildignore
vim.o.history = 1000         -- remember more commands and search history
vim.o.undolevels = 1000      -- use many muchos levels of undo

--  Misc
vim.o.scrolloff=3
vim.o.showmode     = true
vim.o.showcmd      = true
vim.o.showmatch    = true
vim.o.hidden       = true
vim.o.visualbell   = true
vim.o.cursorline   = true
vim.o.ttyfast      = true
vim.o.ruler        = true
vim.o.ignorecase   = true
vim.o.smartcase    = true
vim.o.smarttab     = true
vim.o.hlsearch     = true
vim.o.incsearch    = true

-- Always display status line
vim.o.laststatus = 2

vim.o.undofile = true
vim.o.updatetime = 2000

-- Refresh buffer
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.api.nvim_create_autocmd({"FileChangedShellPost"},{
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
  pattern = { "*" },
})

-- Enable spell checking with default english dictionnary
vim.api.nvim_create_autocmd("FileType",{
  pattern = {"markdown"},
  command = "setlocal spell spelllang=en",
})

-- Enable backup
local prefix = vim.fn.expand("~/.nvim")
vim.opt.backup = true
vim.opt.backupdir = { prefix .. "/backup//"}
vim.opt.directory = { prefix .. "/swap//"}
vim.opt.undodir = { prefix .. "/undo//"}
vim.opt.writebackup = true
vim.opt.backupcopy = "yes"
