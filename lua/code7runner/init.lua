local user_cmds = require('code7runner.user_cmds')

user_cmds.setup()

local M = {}

function M.run()
  local file_path = vim.fn.expand('%:p')
  local project_dir = vim.fn.fnamemodify(file_path, ':h')
  local filename = vim.fn.fnamemodify(file_path, ':t')
  local filename_without_ext = vim.fn.fnamemodify(filename, ':r')
  local extension = vim.fn.fnamemodify(filename, ':e')

  local executor_map = {
    js = 'clear && node ' .. file_path,
    ts = 'clear && ts-node ' .. file_path,
    py = 'clear && python3 ' .. file_path,
    java = 'cd ' .. project_dir .. ' && javac ' .. filename .. ' && java ' .. filename_without_ext,
    c = 'cd ' ..
        project_dir ..
        ' && gcc ' .. filename .. ' -o ' .. filename_without_ext .. ' && ' .. project_dir .. '/' .. filename_without_ext,
    cpp = 'cd ' ..
        project_dir ..
        ' && g++ ' .. filename .. ' -o ' .. filename_without_ext .. ' && ' .. project_dir .. '/' .. filename_without_ext,
    robot = 'clear && robot ' .. '-d ' .. project_dir .. '/results ' .. file_path,
    lua = 'clear && lua ' .. file_path,
    php = 'clear && php ' .. file_path,
    rb = 'clear && ruby ' .. file_path,
  }

  local action = executor_map[extension]
  if action then
    vim.notify(action, vim.log.levels.INFO)

    local buf = vim.api.nvim_create_buf(false, true)

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local opts = {
      relative = 'editor',
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
      style = 'minimal',
      border = 'rounded',
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    vim.fn.termopen(action)
  else
    print("Nenhum executor configurado para a extensão: " .. extension)
  end
end

return M
