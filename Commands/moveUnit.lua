function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Move a unit to a given position",
		parameterDefs = {
			{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			-- @parameter unit - unitID of the unit to move
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			-- @parameter position - Vec3 of position to move to
		}
	}
end

function Run(self, units, parameter)
    local unitID = parameter.unit
    local position = parameter.position
    local tolerance = 20

    -- initialization
    if not self.is_initialized then
        if not Spring.ValidUnitID(unitID) then
            return FAILURE
        end
        
        self.is_initialized = true
    end

	local unit_position = Vec3(Spring.GetUnitPosition(unitID))
	local diff = position - unit_position
	local dist = math.sqrt(diff.x * diff.x + diff.z * diff.z)
	if dist < tolerance then return SUCCESS end

	-- unit is dead
	unitIsDead = Spring.GetUnitIsDead(unitID)
    if unitIsDead == true or unitIsDead == nil then
        return FAILURE
    end

	Spring.GiveOrderToUnit(unitID, CMD.MOVE, position:AsSpringVector() , {})

    return RUNNING
end

function Reset(self)
    self.is_initialized = false
end