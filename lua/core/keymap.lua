local opts = { noremap = true, silent = true }
--
-- Set map leader
vim.g.mapleader = " "

-- Navigation
--[[ vim.keymap.set({ "n", "v" }, "h", "h") ]]
--[[ vim.keymap.set({ "n", "v" }, "j", "k") ]]
--[[ vim.keymap.set({ "n", "v" }, "k", "j") ]]
--[[ vim.keymap.set({ "n", "v" }, "l", "l") ]]

-- File management keybind
vim.keymap.set({ "n", "v", "x" }, "<C-s>", ":silent write<CR>", opts)
vim.keymap.set("n", "<leader>sw", ":silent write<CR>", opts)

-- General keybind
--[[ vim.keymap.set({ "i", "n", "v", "x" }, "<A-n>", "<ESC>") ]]
vim.keymap.set("n", "<leader>nh", vim.cmd.nohlsearch, opts)
vim.keymap.set({ "n", "v", "x" }, "x", '"_x')
vim.keymap.set({ "n" }, "<c-h>", ":tabprevious<CR>", opts)
vim.keymap.set({ "n" }, "<c-h>", ":tabnext<CR>", opts)

-- Buffer
--[[ vim.keymap.set("n", "<C-l>", ":bnext<CR>", { silent = true, remap = true }) ]]
--[[ vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { silent = true, remap = true }) ]]

-- Window management keybind
vim.keymap.set("n", "<leader>sv", "<C-w>v", opts)
vim.keymap.set("n", "<leader>sh", "<C-w>s", opts)
vim.keymap.set("n", "<leader>se", "<C-w>=", opts)
vim.keymap.set("n", "<leader>sx", ":close<CR>", opts)
vim.keymap.set("n", "<A-h>", "<C-w>h<CR>", opts)
vim.keymap.set("n", "<A-l>", "<C-w>l<CR>", opts)
vim.keymap.set("n", "<A-j>", "<C-w>j<CR>", opts)
vim.keymap.set("n", "<A-k>", "<C-w>k<CR>", opts)

-- Resize with arrows when using multiple windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { silent = true, remap = true })
vim.keymap.set("n", "<c-down>", ":resize +2<cr>", { silent = true, remap = true })
vim.keymap.set("n", "<c-right>", ":vertical resize -2<cr>", { silent = true, remap = true })
vim.keymap.set("n", "<c-left>", ":vertical resize +2<cr>", { silent = true, remap = true })

--- Keymap Stolen from https://github.com/ThePrimeagen/
-- Move highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, remap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, remap = true })

vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Greatest remap ever
vim.keymap.set("v", "p", '"_dP', opts)

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)

vim.keymap.set("n", "Q", "<nop>", opts)
--vim.keymap.set("n", "K", "<nop>", opts)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
