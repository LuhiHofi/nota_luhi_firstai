local sensorInfo = {
    name = "MaverickInfo",
    desc = "Returns the X, Y, Z and ID of Maverick",
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

return function(units)
    for i=1, #units do
        local unitID = units[i]
        local unitDefID = Spring.GetUnitDefID(unitID)
        local uDef = UnitDefs[unitDefID]
        
        if uDef.name == "armmav" then
			local x, y, z = Spring.GetUnitPosition(unitID)
            return { x = x, y = y, z = z, id = unitID }
        end
    end
    return nil
end