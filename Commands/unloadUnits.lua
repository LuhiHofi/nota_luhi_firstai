-- This command is an updated version of the unloadUnit from nota_kahlan_ttdr project
function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Unload given unit",
		parameterDefs = {
			{ 
				name = "transporter",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			{ 
                name = "unitsToUnload",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "",
			},
			{	
				name = "unloadPos",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			}
		}
	}
end

function Run(self, units, parameter)
	local transporter = parameter.transporter -- UnitID
	local unitsToUnload = parameter.unitsToUnload -- UnitID
	local unloadPos = parameter.unloadPos
	local radius = 50

	-- Take only 1 transporter
    if type(transporter) == "table" then transporter = transporter[1] end    
    if not Spring.ValidUnitID(transporter) then 
        Spring.Echo("FAILURE: Transporter ID is invalid or nil.")
        return FAILURE 
    end

    if not unitsToUnload or (type(unitsToUnload) == "table" and #unitsToUnload == 0) then
        return SUCCESS
    end


	if not self.init then
		Spring.GiveOrderToUnit(transporter, CMD.UNLOAD_UNITS, {unloadPos.x, unloadPos.y, unloadPos.z, radius}, {"shift"})          
		self.init = true
	end

	local inside = 0
	for i = 1, #unitsToUnload do
		local uID = unitsToUnload[i]
		if Spring.ValidUnitID(uID) then
			if Spring.GetUnitTransporter(uID) then
				inside = inside + 1
			end
		end
	end

	if inside == 0 then
		return SUCCESS
	else
		return RUNNING
	end
end

function Reset(self)
	self.init = false
end

