local tabsize = 4
local opt = vim.opt
local global = vim.g

local options = {
	clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
	completeopt = { 'menuone', 'noselect', 'menu' }, -- mostly just for cmp
	fileencoding = 'utf-8', -- the encoding written to a file
	undolevels = 10000,

	mouse = 'a', -- allow the mouse to be used in neovim
	guicursor = 'n-v-c-sm:block',

	showmode = true, -- we don't need to see things like -- INSERT -- anymore
	cmdheight = 0, -- No height for cmd commands (plugin Noice)
	sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },

	backspace = "indent,eol,start",
	background = "dark",

	backup = false, -- creates a backup file
	swapfile = false, -- creates a swapfile
	undofile = true, -- enable persistent undo

	-- Fold
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again

	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	pumblend = 10,  -- Popup blend
	pumheight = 10,  -- Maximum number of entries in a popup
	winminwidth = 5,  -- Minimum window width

	updatetime = 200, -- Save swap file and trigger CursorHold
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	autowrite = true,
	timeoutlen = 300,

	nu = true, -- set numbered lines
	rnu = true, -- set relktive numbered lines

	-- Cursors
	cursorline = true, -- highlight the current line cursorcolumn = true,

	-- Tabs
	expandtab = false, -- convert tabs to spaces
	numberwidth = tabsize, -- set number column width to 2 {default 4}
	softtabstop = tabsize,
	shiftwidth = tabsize, -- the number of spaces inserted for each indentation
	tabstop = tabsize, -- insert 4 spaces for a table

	grepformat = "%f:%l:%c:%m",
	grepprg= "rg --vimgrep",

	showmatch = true,

	wrap = false, -- display lines as one long line
	linebreak = true,
	breakindent = true,
	conceallevel = 3,

	scrolloff = 8, -- Don't make the cursor reach the bottom edge
	sidescrolloff = 8, -- Don't make the cursor reach the side edge

	list = true,
	showbreak = '⤥ ',
	hidden = true, -- Required to keep multiple buffers open multiple buffers

	incsearch = true, -- Enables a better search, don't causing conflict if result doesn't exist
	hlsearch = false, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	inccommand = "nosplit",

	foldlevel = 99,

	signcolumn = 'yes',
	foldenable = true,
	foldcolumn = '0',
}

local globals = {
	mapleader = ' ',
	maplocalleader = ' ',
	loaded_python3_provider = 0,
	loaded_perl_provider = 0,
	markdown_recommended_style = 0,
	netrw_altfile = 1,
	netrw_usetab = 1,
	netrw_banner = 0,
	netrw_cursor = 0,
	netrw_liststyle = 3,
	netrw_ftp_list_cmd = 'ls -tlF',
	netrw_timefmt = '%I-%M-%S %p',
}

opt.shortmess:append({ W = true, I = true, c = true })
opt.listchars = "eol: ,trail:·,tab:   ,space: ,extends:⤦,precedes:«,conceal:↳,nbsp:%"

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end

for k, v in pairs(options) do
	opt[k] = v
end
for k, v in pairs(globals) do
	global[k] = v
end

