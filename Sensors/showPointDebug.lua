local sensorInfo = {
	name = "sandsailDebug",
	desc = "Sends data to DrawLine widget to draw a debug point. Builds on top of ExampleDebug",
	author = "Luhi",
	date = "2026-07-11",
	license = "MIT",
}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- @description Sensor to draw an Arrow AND a Perpendicular Line
return function(point, prefix)
    local x, y, z = point.x, point.y, point.z
    
    -- Point size
    local length = 50

    local line1 = { startPos = Vec3(x - length, y, z), endPos = Vec3(x + length, y, z) }
    local line2 = { startPos = Vec3(x, y, z - length), endPos = Vec3(x, y, z + length) }

    if (Script.LuaUI('exampleDebug_update')) then
        Script.LuaUI.exampleDebug_update(prefix .. "line1", line1)
        Script.LuaUI.exampleDebug_update(prefix .. "line2", line2)
    end
    return point
end