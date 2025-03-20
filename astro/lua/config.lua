-- ability to render icons in markdown
vim.opt.conceallevel = 2

-- Need this for copying text
vim.api.nvim_set_keymap("i", "<Menu>", "<Nop>", { noremap = true, silent = true })

vim.o.completeopt = "menu,menuone,noselect"

-- enable treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.spellfile = vim.fn.stdpath "config" .. "/spell/en.utf-8.add"
vim.opt.spellfile = vim.fn.stdpath "config" .. "/spell/es.utf-8.add"

-- snacks
-- vim.o.statuscolumn = "%{%v:lua.require'heirline'.eval_statuscolumn()%}"
