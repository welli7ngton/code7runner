local M = {}

M.setup = function()
  vim.api.nvim_create_user_command('Code7Run',
    function()
      require('code7runner').run()
    end,
    {}
  )
end

return M
