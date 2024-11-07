local user_command = require('code7runner.user_commands')

user_command.setup()

local executor_map = {
  js = 'clear && node $fileName',
  ts = 'clear && ts-node $fileName',
  py = 'clear && python -u $fileName',
  java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
  c = 'cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
  cpp = 'cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
  robot = 'clear && robot $fileName',
  lua = 'clear && lua $fileName',
  php = 'clear && php $fileName',
  rb = 'clear && ruby $fileName',
}

local M = {}

function M.run()
  local filename = vim.fn.expand("%:t")
  local dir = vim.fn.expand("%:p:h")
  local filename_without_ext = vim.fn.expand("%:t:r")
  local extension = filename:lower():match('^.+%.(.+)$')

  local action = executor_map[extension]
  if action then
    action = action:gsub("%$fileName", filename)
        :gsub("%$dir", dir)
        :gsub("%$fileNameWithoutExt", filename_without_ext)
    vim.cmd("split | terminal " .. action)
  else
    print("Nenhum executor configurado para a extensão: " .. extension)
  end
end

return M

