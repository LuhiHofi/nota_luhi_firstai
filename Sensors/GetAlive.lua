local sensorInfo = {
	name = "Luhi",
	desc = "Return unit that are alive",
	author = "Luhi",
	date = "2026-07-14",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(units)
	aliveUnits = {}
	for _, unitID in ipairs(units) do
		local isAlive = Spring.ValidUnitID(unitID)
		if isAlive then
			aliveUnits[#aliveUnits + 1] = unitID
		end
	end
	return aliveUnits
end