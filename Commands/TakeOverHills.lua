local sensorInfo = {
	name = "TakeOverHills",
	desc = "Units secure positions on the selected hills",
	author = "Luhi",
	date = "2026-05-13",
	license = "notAlicense",
}

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Units secure hillPositions",
		parameterDefs = {
			{ 
				name = "hillPositions",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
                name = "capperUnitIDs",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "",
			}
		}
	}
end

function Run(self, units, parameter)
	local IsCommandInQueue = Sensors.nota_luhi_firstai.IsCommandInQueue
	local threshold_distance = 20
	local hillPositions = parameter.hillPositions
	local capperUnitIDs = parameter.capperUnitIDs
	
	if (#hillPositions > #capperUnitIDs) then
		local newhillPositions = {}
		for i = #capperUnitIDs, 1, -1 do
			newhillPositions[#newhillPositions + 1] = hillPositions[i]
		end
		hillPositions = newhillPositions
	end

	local destinationsReached = true

	for i, hillPosition in ipairs(hillPositions) do
		local unitPosition = Vec3(Spring.GetUnitPosition(capperUnitIDs[i]))
		if unitPosition:Distance(hillPosition) > threshold_distance then
			destinationsReached = false
			if not IsCommandInQueue(capperUnitIDs[i], CMD.MOVE) then
				local rawPos = {hillPosition.x, hillPosition.y, hillPosition.z}
				Spring.GiveOrderToUnit(capperUnitIDs[i], CMD.MOVE, rawPos, {})
			end
		end
	end

	if destinationsReached then
		return SUCCESS
	else
		return RUNNING
	end
end