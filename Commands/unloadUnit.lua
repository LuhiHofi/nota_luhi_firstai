function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Unload the given unit from the given transporter to the given position.",
		parameterDefs = {
			{ 
				name = "transporter",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "unitToUnload",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
		}
	}
end

function Run(self, units, parameter)
    local transporter = parameter.transporter
    local unitToUnload = parameter.unitToUnload
    local position = parameter.position

-- initialization
    if not self.is_initialized then
    -- validation
        -- transporter is valid
        if not Spring.ValidUnitID(transporter) then
            Spring.Echo("FAILURE: transporter ID is invalid or nil.") 
            return FAILURE
        end
        if not Spring.ValidUnitID(unitToUnload) then
            Spring.Echo("FAILURE: unit ID is invalid or nil.") 
            return FAILURE
        end
        -- unitToUnload is loaded on the transporter
        if Spring.GetUnitTransporter(unitToUnload) ~= transporter then
            return FAILURE
        end

        -- issue unload command
        Spring.GiveOrderToUnit(transporter, CMD.UNLOAD_UNIT, {position.x, position.y, position.z}, {})
        
        self.is_initialized = true
    end

    -- unitToUnload is not loaded on transporter
    if Spring.GetUnitTransporter(unitToUnload) == nil then
        return SUCCESS
    end

    -- transporter is dead
    local unitIsDead = Spring.GetUnitIsDead(transporter)
    if unitIsDead == true or unitIsDead == nil then
        return FAILURE
    end
    -- unitToUnload is dead
    unitIsDead = Spring.GetUnitIsDead(unitToUnload)
    if unitIsDead == true or unitIsDead == nil then
        return FAILURE
    end

    return RUNNING

end

function Reset(self)
    self.is_initialized = false
end