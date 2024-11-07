local user_cmds = require('code7runner.user_cmds')

user_cmds.setup()
local M = {}

function M.run()
  local filename = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")
  local filename_without_ext = vim.fn.expand("%:t:r")
  local extension = filename:lower():match('^.+%.(.+)$')

  local executor_map = {
    js = 'clear && node ' .. filename,
    ts = 'clear && ts-node ' .. filename,
    py = 'clear && python -u ' .. filename,
    java = 'cd ' .. dir .. ' && javac ' .. filename .. ' && java ' .. filename_without_ext,
    c = 'cd ' ..
        dir .. ' && gcc ' .. filename .. ' -o ' .. filename_without_ext .. ' && ' .. dir .. '/' .. filename_without_ext,
    cpp = 'cd ' ..
        dir .. ' && g++ ' .. filename .. ' -o ' .. filename_without_ext .. ' && ' .. dir .. '/' .. filename_without_ext,
    robot = 'clear && robot ' .. filename,
    lua = 'clear && lua ' .. filename,
    php = 'clear && php ' .. filename,
    rb = 'clear && ruby ' .. filename,
  }

  local action = executor_map[extension]
  if action then
    -- Configuração da janela flutuante
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

    vim.api.nvim_open_win(buf, true, opts)
    vim.fn.termopen(action)
  else
    print("Nenhum executor configurado para a extensão: " .. extension)
  end
end

return M

