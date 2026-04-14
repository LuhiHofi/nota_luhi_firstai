local sensorInfo = {
	name = "Wind",
	desc = "Return data of actual wind.",
	author = "PepeAmpere + Lukáš Hofman",
	date = "2026-04-09",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
local SpringGetWind = Spring.GetWind
local deg = math.deg
local atan2 = math.atan2

-- @description return current wind statistics
return function()
	local dirX, _, dirZ, strength = SpringGetWind()
	local angle = atan2(dirX, dirZ)

	return {
		angle = angle,
		strength = strength
	}
end