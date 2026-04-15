local opt = vim.opt

opt.number         = true
opt.relativenumber = true
opt.shiftwidth     = 4
opt.softtabstop    = 4
opt.tabstop        = 4
opt.expandtab      = true
opt.incsearch      = true
opt.ignorecase     = true
opt.smartcase      = true
opt.showcmd        = true
opt.showmode       = true
opt.history        = 1000
opt.linebreak      = true
opt.autoindent     = true
opt.wrap           = true
opt.wrapmargin     = 0
opt.textwidth      = 0
opt.breakindent    = true
opt.breakindentopt = "shift:2"
opt.hlsearch       = true
opt.showmatch      = true
opt.cursorline     = true
opt.spellfile      = vim.fn.expand("~/.vim/spell/en.utf-8.add")
opt.spell          = true
opt.spelllang      = { "en" }
opt.spellcapcheck  = ""
opt.signcolumn     = "yes"
opt.cmdheight=0 -- TODO: figure out how to set this to 0 but not lose all the recording, yanking, search info i need
opt.splitbelow = true
opt.splitright = true
opt.showcmdloc = "statusline"

-- mouse config (scrolling always enabled, any other functionality only enabled in terminal mode)
--opt.mouse = ""
vim.opt.mouse = "a"

local nop_clicks = {
  "<LeftMouse>", "<2-LeftMouse>", "<3-LeftMouse>",
  "<RightMouse>", "<MiddleMouse>",
  "<LeftDrag>", "<LeftRelease>",
}

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then return end
    local buf = vim.api.nvim_get_current_buf()
    for _, lhs in ipairs(nop_clicks) do
      vim.keymap.set({ "n", "i", "v" }, lhs, "<Nop>", { noremap = true, buffer = buf })
    end
    vim.keymap.set("n", "<ScrollWheelUp>",   "2k", { noremap = true, buffer = buf })
    vim.keymap.set("n", "<ScrollWheelDown>", "2j", { noremap = true, buffer = buf })
    vim.keymap.set("i", "<ScrollWheelUp>",   "<C-o>2k", { noremap = true, buffer = buf })
    vim.keymap.set("i", "<ScrollWheelDown>", "<C-o>2j", { noremap = true, buffer = buf })
  end,
})
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    for _, lhs in ipairs(nop_clicks) do
      pcall(vim.keymap.del, { "n", "i", "v" }, lhs, { buffer = buf })
    end
    pcall(vim.keymap.del, "n", "<ScrollWheelUp>", { buffer = buf })
    pcall(vim.keymap.del, "n", "<ScrollWheelDown>", { buffer = buf })
    pcall(vim.keymap.del, "i", "<ScrollWheelUp>", { buffer = buf })
    pcall(vim.keymap.del, "i", "<ScrollWheelDown>", { buffer = buf })
  end,
})

-- Disable auto-comment continuation on new lines
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Restore cursor to last known position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    local ft = vim.bo.filetype
    if mark[1] > 0
      and mark[1] <= lcount
      and ft ~= "commit"
      and ft ~= "xxd"
      and ft ~= "gitrebase"
      and not vim.wo.diff
    then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Racket/Lisp: use scmindent for = indentation operator
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lisp", "scheme", "racket" },
  callback = function()
    vim.opt_local.equalprg = "scmindent.rkt"
  end,
})

-- start treesitter for lisp like files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "racket", "scheme", "lisp" },
  callback = function()
    vim.treesitter.start()
  end,
})

-- closes nvim tree if it's the last buffer in a window
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_tabpage_list_wins(0) == 1
      and vim.bo.filetype == "NvimTree"
    then
      vim.schedule(function()
        vim.cmd("quit")
      end)
    end
  end,
})

-- toggles auto complete
vim.keymap.set("n", "<leader>cc", function()
  local cmp = require("cmp")
  cmp.setup({ enabled = not cmp.get_config().enabled })
end, { noremap = true })

-- configure yank output so i can send it to statusline with lualine
local yank_timer = nil
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local count = vim.v.event.regcontents and #vim.v.event.regcontents or 0
    if count > 0 then
      vim.g.yank_msg = count .. " line" .. (count == 1 and "" or "s") .. " yanked"
    end
    if yank_timer then yank_timer:stop() end
    yank_timer = vim.defer_fn(function()
      vim.g.yank_msg = ""
      vim.cmd("redrawstatus")
    end, 5000)
  end,
})

-- saves any given session managed by auto-session every 5 minutes
local timer = vim.loop.new_timer()
timer:start(5 * 60 * 1000, 5 * 60 * 1000, vim.schedule_wrap(function()
  require("auto-session").SaveSession()
end))
