local sensorInfo = {
	name = "Luhi",
	desc = "Get the ID of the enemy unit",
	author = "Luhi",
	date = "2026-05-13",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(position)
	Spring.Echo(position)
	local centerPos = position
	local radius = 10
    local unitsInArea = Spring.GetUnitsInSphere(centerPos.x, centerPos.y, centerPos.z, radius)
	Spring.Echo(unitsInArea)
    
    for i = 1, #unitsInArea do
        local unitID = unitsInArea[i]
        if not Spring.IsUnitAllied(unitID) then
            return unitID
        end
    end
    
    return nil
end