---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- Buffers
    ["<leader>w"] = { "<cmd> :w! <CR>", "Write the current buffer" },
    ["<leader>q"] = { "<cmd> :wq <CR>", "Close the current buffer (with saving)" },
    ["<leader>qq"] = { "<cmd> :q! <CR>", "Close the current buffer (no saving)" },

    ["<leader>bb"] = { "<cmd>:vnew<CR>", "Create a new buffer on the X axis" },
    ["<leader>bv"] = { "<cmd>:new<CR>", "Create a new buffer on the Y axis" },

    ["<leader>bs"] = { "<cmd> :vsp <CR>", "Split the current buffer to the right" },
    ["<leader>bd"] = { "<cmd> :sp <CR>", "Split the current buffer downwards" },


    ["<C-Left>"] = { "<cmd> vertical resize +5 <CR>", "Grow the buffer Horizontally" },
    ["<C-Right>"] = { "<cmd> vertical resize -5 <CR>", "Shrink the buffer Horizontally" },
    ["<C-Up>"] = {"<cmd> resize +5 <CR>", "Grow the buffer Vertically"},
    ["<C-Down>"] = {"<cmd> resize -5 <CR>", "Shrink the buffer Vertically"},

    -- LSP Bindings
    ["<leader>ld"] = { "<cmd> :lua vim.diagnostic.goto_next() <CR>", "Jump to next LSP diagnostic" },
    ["<leader>lD"] = { "<cmd> :lua vim.diagnostic.goto_prev() <CR>", "Jump to previous LSP diagnostic" },
    -- ["<leader>ll"] = { "<S-k>", "Show hover diagnostics"},
    ["<leader>ll"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover"
    },
    ["<leader>lr"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP Rename Symbol"
    },
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format{async = true}
      end,
      "LSP Format Buffer"
    }
  },
}

-- more keybinds!

return M
