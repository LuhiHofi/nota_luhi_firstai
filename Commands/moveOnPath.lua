function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move a unit to a given position",
		parameterDefs = {
			{ 
				name = "unit", -- unitID
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "safePath", -- Vec3[]
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
		}
	}
end

function Run(self, units, parameter)
    local unitID = parameter.unit
    local safePath = parameter.safePath
    local tolerance = 20

    -- initialization
    if not self.is_initialized then
        if not Spring.ValidUnitID(unitID) then
            return FAILURE
        end
		
		for i = 1, #safePath do
			Spring.GiveOrderToUnit(unitID, CMD.MOVE, safePath[i]:AsSpringVector() , {'shift'})
		end
        
        self.is_initialized = true
    end

	local position = safePath[#safePath]
	local unit_position = Vec3(Spring.GetUnitPosition(unitID))
	local diff = position - unit_position
	local dist = math.sqrt(diff.x * diff.x + diff.z * diff.z)
	if dist < tolerance then return SUCCESS end

	-- unit died
	unitIsDead = Spring.GetUnitIsDead(unitID)
    if unitIsDead == true or unitIsDead == nil then
        return FAILURE
    end


	return RUNNING
end

function Reset(self)
    self.is_initialized = false
end