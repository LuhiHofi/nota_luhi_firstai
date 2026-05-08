local sensorInfo = {
	name = "FirstUnitPos",
	desc = "returns the position of the first unit in the behaviour",
	author = "Luhi",
	date = "2026-05-08",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- evaluate every tick

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

return function(units)
    if units and units[1] and Spring.ValidUnitID(units[1]) then
        local x, y, z = Spring.GetUnitPosition(units[1])
        return Vec3(x, y, z)
    end
    return Vec3(0, 0, 0)
end