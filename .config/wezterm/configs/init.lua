local M = {}

function M.configure(config)
    require("configs.font").configure(config)
    require("configs.appearance").configure(config)
    require("configs.keys").configure(config)
    require("configs.tab").configure(config)
    require("configs.general").configure(config)
end

return M
