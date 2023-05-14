-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
-- Array of file names indicating root directory. Modify to your liking.
-- 0 -> directory only
-- 1 -> file only
-- 2 -> Either
local root_names = {
  [".git"] = 0
}

function toboolean(val)
  if type(val) == "number" then
    if val == 0 then
      return false
    else 
      return true
    end
  else
    return false
  end
end

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then return end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(
      function(name, path) 
        local is_dir = vim.fn.isdirectory(path.."/"..name)
        if root_names[name] then
          local action = root_names[name]
          if action == 0 then
            return toboolean(is_dir)
          elseif action == 1 then
              return not toboolean(is_dir)
          else
              return true
          end
        else
          return false
        end
      end, { path = path, upward = true })[1]
    if root_file == nil then return end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
