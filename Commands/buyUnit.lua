-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module
-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Buys a unit",
		parameterDefs = {
			{ 
				name = "unitName",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "'armbox'",
			},
		}
	}
end
function Run(self, units, parameter)
	local unitName = parameter.unitName
    local metal = Spring.GetTeamResources(Spring.GetMyTeamID(), "metal")

	if bb.missionInfo.buy[unitName] > metal then
        return FAILURE
    end

    message.SendRules({
        subject = "swampdota_buyUnit",
        data = {
			unitName = parameter.unitName
		},
    })
	return SUCCESS
end
function Reset(self)
	return self
end
