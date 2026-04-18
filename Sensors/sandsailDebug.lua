local sensorInfo = {
	name = "sandsailDebug",
	desc = "Sends data to DrawLine widget to draw a debug Line in the direction of the Wind. (and draw a line of the formation) Builds on top of ExampleDebug",
	author = "Lukáš Hofman + PepeAmpere",
	date = "2026-04-17",
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
return function(mav, windData)
    units = units or {} 
    if #units > 0 and windData then
        local x, y, z = mav.x, mav.y, mav.z
        
        local angle = windData.angle
        local perpAngle = angle + (math.pi / 2)
        
        -- Length settings
        local arrowLen = 400 
        local perpLen = 300
        local headSize = 60
        local headAngle = 0.5 

        -- Arrow Shaft End position
        local tipX = x + (math.sin(angle) * arrowLen)
        local tipZ = z + (math.cos(angle) * arrowLen)
        
        local shaft = { startPos = Vec3(x, y, z), endPos = Vec3(tipX, y, tipZ) }
        local leftH = { startPos = Vec3(tipX, y, tipZ), endPos = Vec3(tipX - math.sin(angle - headAngle) * headSize, y, tipZ - math.cos(angle - headAngle) * headSize) }
        local rightH = { startPos = Vec3(tipX, y, tipZ), endPos = Vec3(tipX - math.sin(angle + headAngle) * headSize, y, tipZ - math.cos(angle + headAngle) * headSize) }

        -- Perpendicular Formation Line
        local px = math.sin(perpAngle) * perpLen
        local pz = math.cos(perpAngle) * perpLen
        local perpLine = { startPos = Vec3(x - px, y, z - pz), endPos = Vec3(x + px, y, z + pz) }

        if (Script.LuaUI('sandsail_DrawWindLine')) then
            local prefix = mav.id .. "_"
            Script.LuaUI.sandsail_DrawWindLine(prefix .. "arrowShaft", shaft)
            Script.LuaUI.sandsail_DrawWindLine(prefix .. "lArrowHead", leftH)
            Script.LuaUI.sandsail_DrawWindLine(prefix .. "rArrowHead", rightH)
            Script.LuaUI.sandsail_DrawWindLine(prefix .. "perpLine", perpLine)
        end

        return shaft -- Returns A Line of the wind direction from mav
    end
end