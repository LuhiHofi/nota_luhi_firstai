local sensorInfo = {
	name = "Luhi",
	desc = "Check if a unit is alive",
	author = "Luhi",
	date = "2026-05-13",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(unitID)
	if not unitID then return false 
	end
	local isAlive = Spring.ValidUnitID(targetID)
	return isAlive
end