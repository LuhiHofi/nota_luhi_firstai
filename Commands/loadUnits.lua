-- This command is an updated version of the loadUnit from nota_kahlan_ttdr project
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
                name = "unitsToLoad",
                variableType = "expression",
                componentType = "editBox",
                defaultValue = "",
			}
		}
	}
end

function Run(self, units, parameter)
	local transporter = parameter.transporter -- UnitID
	local unitsToLoad = parameter.unitsToLoad -- UnitID
	local unloadPos = parameter.unloadPos
	local radius = 50

	-- Take only 1 transporter
    if type(transporter) == "table" then transporter = transporter[1] end    
    if not Spring.ValidUnitID(transporter) then 
        Spring.Echo("FAILURE: Transporter ID is invalid or nil.")
        return FAILURE 
    end

    if not unitsToLoad or (type(unitsToLoad) == "table" and #unitsToLoad == 0) then
        return SUCCESS
    end


	if not self.init then
		 for i=1, #unitsToLoad do
            Spring.GiveOrderToUnit(transporter, CMD.LOAD_UNITS, {unitsToLoad[i]}, {"shift"})          
        end
		self.init = true
	end
	local outside = 0
	for i = 1, #unitsToLoad do
		local uID = unitsToLoad[i]
		if Spring.ValidUnitID(uID) then
			if not Spring.GetUnitTransporter(uID) then
				outside = outside + 1
			end
		end
	end

	if outside == 0 then
		return SUCCESS
	else
		return RUNNING
	end
end

function Reset(self)
	self.init = false
end
