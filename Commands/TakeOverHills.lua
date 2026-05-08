local sensorInfo = {
	name = "TakeOverHills",
	desc = "Split units up and make them move to given position",
	author = "MianenCZ + Luhi",
	date = "2026-05-01",
	license = "notAlicense",
}

-- Luhi additions: 
-- Added functionality even if #capperUnits < #position
-- choose which units should cap the hills (For the option to exclude transporter)

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move to defined position",
		parameterDefs = {
			{ 
				name = "positions",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
                name = "capperUnits",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "",
			}
		}
	}
end

-- constants
local THRESHOLD_STEP = 25

-- speed-ups
local SpringGetUnitPosition = Spring.GetUnitPosition
local SpringGiveOrderToUnit = Spring.GiveOrderToUnit

local function ClearState(self)

end

function Run(self, units, parameter)
	local positions = parameter.positions -- Vec3[]
	local capperUnits = parameter.capperUnits
	local cmdID = CMD.MOVE
	if (#positions > #capperUnits) then
		local newPositions = {}
		for i = 1, #capperUnits do
			table.insert(newPositions, positions[#positions + 1 - i])
		end
		positions = newPositions
	end

	local destinationsReached = true

	for i, position in ipairs(positions) do
		local unitX, unitY, unitZ = SpringGetUnitPosition(capperUnits[i])
		local unitPosition = Vec3(unitX, unitY, unitZ)
		if unitPosition:Distance(position) > THRESHOLD_STEP then
			destinationsReached = false
			SpringGiveOrderToUnit(capperUnits[i], cmdID, position:AsSpringVector(), {})
		end
	end

	if destinationsReached then
		return SUCCESS
	else
		return RUNNING
	end
end


function Reset(self)
	ClearState(self)
end
