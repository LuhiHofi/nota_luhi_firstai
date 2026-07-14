function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Load a given unit to a given transporter",
		parameterDefs = {
			{ 
				name = "transporter",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
				name = "unitToLoad",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
		}
	}
end

function Run(self, units, parameter)
    local transporter = parameter.transporter
    local unitToLoad = parameter.unitToLoad
    local IsCommandInQueue = Sensors.nota_luhi_firstai.IsCommandInQueue

    -- initialization
    if not self.is_initialized then
        -- transporter is valid
        if not Spring.ValidUnitID(transporter) then
            Spring.Echo("FAILURE: transporter ID is invalid or nil.") 
            return FAILURE
        end
        if not Spring.ValidUnitID(unitToLoad) then
            Spring.Echo("FAILURE: unit ID is invalid or nil.") 
            return FAILURE
        end

        Spring.GiveOrderToUnit(transporter, CMD.LOAD_UNITS, {unitToLoad}, {})
        
        self.is_initialized = true
    end

    if Spring.GetUnitTransporter(unitToLoad) == transporter then
        -- unitToLoad is loaded on transporter
        return SUCCESS
    end

    local unitIsDead = Spring.GetUnitIsDead(transporter)
    if unitIsDead == true or unitIsDead == nil then
        -- transporter is dead
        return FAILURE
    end
    unitIsDead = Spring.GetUnitIsDead(unitToLoad)
    if unitIsDead == true or unitIsDead == nil then
        -- unitToLoad is dead
        return FAILURE
    end

    local unitTransporter = Spring.GetUnitTransporter(unitToLoad) 
    if unitTransporter ~= nil and unitTransporter ~= transporter then
        -- unitToLoad already has a transporter
        return FAILURE
    end
    
    if #Spring.GetUnitIsTransporting(transporter) > 0 then
        -- transporter is full
        return FAILURE
    end
    
    if not IsCommandInQueue(transporter, CMD.LOAD_UNITS) then
        Spring.GiveOrderToUnit(transporter, CMD.LOAD_UNITS, {unitToLoad}, {})
    end
    
    return RUNNING
end

function Reset(self)
    self.is_initialized = false
end