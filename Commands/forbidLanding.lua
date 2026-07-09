function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Forbids air units to land while idle",
	}
end

function Run(self, units)	
	for i = 1, #units do
		local unitID = units[i]
		if UnitDefs[Spring.GetUnitDefID(unitID)].isAirUnit then
			Spring.GiveOrderToUnit(unitID, CMD.IDLEMODE, { 0 }, {})
		end
	end

	return SUCCESS
end
