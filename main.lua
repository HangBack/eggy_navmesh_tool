LuaAPI.global_register_trigger_event({ EVENT.GAME_INIT }, function()
    NavMesh = require "NavMesh.__init"
    Path = require "NavMesh.Path"
    local mesh = NavMesh.build(require "mesh_data")
    NavMesh.render()
    NavMesh.start_edit()
end)