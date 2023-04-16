local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  sort_by = function(nodes) 
    -- ORDERING:
    -- Hidden Directories
    -- Directories
    -- Source files (sorted by extension)
    -- Dot files

    local hidden_directories = {}
    local directories = {}
    local files = {}
    local hidden_files = {}

    for _, v in pairs(nodes) do
      local first = v.name:sub(1, 1)
      if v.type == "directory" then
        if first == "." then
          hidden_directories[#hidden_directories + 1] = v
        else
          directories[#directories + 1] = v
        end
      elseif v.type == "file" then
        if first == "." then
          hidden_files[#hidden_files + 1] = v
        else
          files[#files + 1] = v
        end
      end
    end

    table.sort(files, function(a, b)
      if a.extension == b.extension then
        return a.name < b.name
      else
      return a.extension < b.extension
      end
    end)
    local ret = {}
    vim.list_extend(ret, hidden_directories)
    vim.list_extend(ret, directories)
    vim.list_extend(ret, files)
    vim.list_extend(ret, hidden_files)

    -- print(vim.inspect(ret))
    for k, v in pairs(ret) do
      nodes[k] = v
    end
    -- nodes = ret
 end,
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = false,
    ignore = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

return options
