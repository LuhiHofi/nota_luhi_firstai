local sensorInfo = {
    name = "MaverickInfo",
    desc = "Returns the X, Y, Z and ID of Maverick",
	author = "Luhi",
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
        
        if uDef.name == "armthovr" then
			local x, y, z = Spring.GetUnitPosition(unitID)
            return unitID
        end
    end
    return nil
end