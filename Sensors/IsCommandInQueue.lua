local sensorInfo = {
	name = "IsCommandInQueue",
	desc = "Checks if a given command is in command queue",
	author = "Luhi",
	date = "2026-05-19",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(unitID, commandID)
    local queue = Spring.GetUnitCommands(unitID)
    if (queue) then
        for i = 1, #queue do
            if (queue[i].id == commandID) then
                return true
            end
        end
    end
    return false
end