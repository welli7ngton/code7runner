local user_command = require('code7runner.user_commands')

user_command.setup()

local executor_map = {
  js = 'clear; node $fileName',
  ts = 'clear; ts-node $fileName',
  py = 'clear; python -u $fileName',
  java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
  c = 'cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
  cpp = 'cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
  robot = 'clear; robot $fileName',
  lua = 'clear; lua $fileName',
  php = 'clear; php $fileName',
  rb = 'clear; ruby $fileName',
}

local filename = vim.fn.expand("%:t")
local dir = vim.fn.expand("%:p:h")
local filename_without_ext = vim.fn.expand("%:t:r")
local extention = filename:lower():match('^.+%.(.+)$')

local action = executor_map[extention]

local M = {}

function M.run()
  if action then
    action = action:gsub("%$fileName", filename)
        :gsub("%$dir", dir)
        :gsub("%$fileNameWithoutExt", filename_without_ext)
    vim.fn.system(action)
  end
end

return M
