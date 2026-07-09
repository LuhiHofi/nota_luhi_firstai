local sensorInfo = {
	name = "GetRescuableUnits",
	desc = "Returns a table of rescuable units",
	author = "Luhi",
	date = "2026-05-22",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(safeArea)
    local allUnits = Spring.GetTeamUnits(Spring.GetMyTeamID())
    local rescuableUnits = {}
    local noSafeArea = false
    local safePos = Vec3(0,0,0)
    local safeRadius = 0

    if not safeArea then 
        noSafeArea = true
    else
        safePos = safeArea.center
        safeRadius = safeArea.radius
    end

    for i = 1, #allUnits do
        local unitID = allUnits[i]
        local unitDefID = Spring.GetUnitDefID(unitID)
        local unit = UnitDefs[unitDefID]
		if not unit.cantBeTransported then  -- only transportable units are considered for rescue
            local ux, _, uz = Spring.GetUnitPosition(unitID)
            local dx = ux - safePos.x
            local dz = uz - safePos.z
            local PythagorasTheorem = (dx * dx) + (dz * dz)

            if noSafeArea or (not noSafeArea and (PythagorasTheorem > safeRadius * safeRadius )) then
                rescuableUnits[#rescuableUnits+1] = unitID
            end
        end
    end
    return rescuableUnits
end