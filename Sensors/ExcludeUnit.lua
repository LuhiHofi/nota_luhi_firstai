local sensorInfo = {
    name = "MaverickInfo",
    desc = "Returns a list of units without the excluded one",
	author = "Lukáš Hofman",
	date = "2026-04-14",
	license = "notAlicense",
}

EVAL_PERIOD_DEFAULT = 0

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(units, excludedUnitId)
    local newUnits = {}
    j = 1 
    if not units then return {} end
    
    for i=1, #units do
        local unitID = units[i]
        if unitID ~= excludedUnitId then
            newUnits[j] = units[i]
            j = j + 1
        end
    end
    return newUnits 
end