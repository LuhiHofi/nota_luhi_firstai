local sensorInfo = {
	name = "unloadUnits",
	desc = "Unoads desired units from a transporter in a given area",
	author = "Luhi",
	date = "2026-05-13",
	license = "notAlicense",
}

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Unload given units at a given area",
		parameterDefs = {
			{ 
				name = "transporterID",
				variableType = "number",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
                name = "unitToUnloadIDs",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "",
			},
			{	
				name = "unloadArea", -- {Vec3 position, number radius}
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
	local unitToUnloadIDs = parameter.unitToUnloadIDs
	local unloadAreaRaw = parameter.unloadArea -- {Vec3, radius} 

    local pos = unloadAreaRaw[1]
    local radius = unloadAreaRaw[2]

	local unloadArea = {pos.x, pos.y, pos.z, radius}

	if not Spring.ValidUnitID(transporterID) then 
        Spring.Echo("FAILURE: transporterID ID is invalid or nil.")
        return FAILURE 
    end

    if not unitToUnloadIDs or (type(unitToUnloadIDs) == "table" and #unitToUnloadIDs == 0) then
        return SUCCESS
    end

	local stillInside = 0
	for i = 1, #unitToUnloadIDs do
		local uID = unitToUnloadIDs[i]
		if Spring.ValidUnitID(uID) then
			if Spring.GetUnitTransporter(uID) then
				stillInside = stillInside + 1
			end
		end
	end

	if (stillInside > 0 and not IsCommandInQueue(transporterID, CMD.UNLOAD_UNITS)) then
		Spring.GiveOrderToUnit(transporterID, CMD.UNLOAD_UNITS, unloadArea, {"shift"}) 
	end

	if stillInside == 0 then
		return SUCCESS
	else
		return RUNNING
	end
end
