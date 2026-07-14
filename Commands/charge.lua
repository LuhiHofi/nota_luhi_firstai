function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move selected units in a formation to a defined position",
		parameterDefs = {
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "formation", -- relative formation
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "units",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		}
	}
end

-- constants
local THRESHOLD = 50

function Run(self, units, parameter)
	local position = parameter.position -- Vec3
	local formation = parameter.formation -- array of Vec3
	local attackUnits = parameter.units -- unitIDs
	
	-- validation
	if (#attackUnits > #formation) then
		Logger.warn("There are more units [" .. #attackUnits .. "] than formations slots [" .. #formation .. "]") 
		return FAILURE
	end

	if (#attackUnits == 0) then
		Logger.warn("There are units for the attack") 
		return FAILURE
	end

	local leader = attackUnits[1] -- while this is running, we know that #units > 0, so leader is valid
	local pointX, pointY, pointZ = Spring.GetUnitPosition(leader)
	local leader_pos = Vec3(pointX, pointY, pointZ)
		
	-- leader on position
	if (leader_pos:Distance(position) < THRESHOLD) then
		return SUCCESS
	else
		Spring.GiveOrderToUnit(leader, CMD.FIGHT, position:AsSpringVector(), {})
		
		for i=2, #attackUnits do
			local thisUnitWantedPosition = leader_pos + formation[i]
			Spring.GiveOrderToUnit(attackUnits[i], CMD.FIGHT, thisUnitWantedPosition:AsSpringVector(), {})
		end
		
		return RUNNING
	end
end


function Reset(self)
end
