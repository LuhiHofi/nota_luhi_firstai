function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Forbids air units to land while idle",
		parameterDefs = {
            { 
				name = "airUnits", -- unitIDs
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		}
	}
end

function Run(self, units, param)
	local airUnits = param.airUnits
	for i = 1, #airUnits do
		local unitID = airUnits[i]
		if UnitDefs[Spring.GetUnitDefID(unitID)].isAirUnit then
			Spring.GiveOrderToUnit(unitID, CMD.IDLEMODE, { 0 }, {})
		end
	end

	return SUCCESS
end
