local M = {}
local util = require('lspconfig/util')

function M.find_go_ancestor(startpath)
  return util.search_ancestors(startpath, function(path)
    if util.path.is_file(util.path.join(path, 'go.mod')) or util.path.is_dir(util.path.join(path, '.git')) then
      return path
    end
  end)
end

function M.find_ancestor(startpath, filename)
  return util.search_ancestors(startpath, function(path)
    if util.path.is_file(util.path.join(path, filename)) then
      return path
    end
  end)
end

function M.find_git_or_pwd(startpath)
  return util.search_ancestors(startpath, function(path)
    if util.path.is_dir(util.path.join(path, '.git')) then
      return path
    end
  end) or vim.fn.getcwd()
end

return M
