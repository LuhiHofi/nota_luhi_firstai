local sensorInfo = {
	name = "loadUnits",
	desc = "Loads desired units to a transporter",
	author = "Luhi",
	date = "2026-05-13",
	license = "notAlicense",
}

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Load given units",
		parameterDefs = {
			{ 
				name = "transporterID",
				variableType = "number",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
                name = "unitToLoadIDs",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "",
			}
		}
	}
end

local function IsCommandInQueue(unitID, commandID)
    local queue = Spring.GetUnitCommands(unitID)
    if (queue) then
        for i = 1, #queue do
            if (queue[i].id == commandID) then
                return true
            end
        end
    end
    return false
end

function Run(self, units, parameter)
	local transporterID = parameter.transporterID
	local unitToLoadIDs = parameter.unitToLoadIDs

    if not Spring.ValidUnitID(transporterID) then 
        Spring.Echo("FAILURE: transporterID ID is invalid or nil.")
        return FAILURE 
    end

    if not unitToLoadIDs or (type(unitToLoadIDs) == "table" and #unitToLoadIDs == 0) then
        return SUCCESS
    end

	local stillOutside = 0
	for i = 1, #unitToLoadIDs do
		local uID = unitToLoadIDs[i]
		if Spring.ValidUnitID(uID) then
			if not Spring.GetUnitTransporter(uID) then
				stillOutside = stillOutside + 1
			end
		end
	end

	if (stillOutside > 0 and not IsCommandInQueue(transporterID, CMD.LOAD_UNITS)) then
		for i=1, #unitToLoadIDs do
            Spring.GiveOrderToUnit(transporterID, CMD.LOAD_UNITS, {unitToLoadIDs[i]}, {"shift"})          
        end
	end

	if stillOutside == 0 then
		return SUCCESS
	else
		return RUNNING
	end
end