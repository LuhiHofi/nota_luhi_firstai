local sensorInfo = {
	name = "TransportFinished",
	desc = "Update unit states after a finished transportation.",
	author = "Luhi",
	date = "2026-07-11",
	license = "MIT",

}

-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(transporter, transportedUnit, success)
    if success then 
        bb.units.state[transporter] = "finished"
        bb.units.state[transportedUnit] = "ready"
    else
        local transportIsDead = Spring.GetUnitIsDead(transporter)
        if not Spring.ValidUnitID(transporter) or transportIsDead == false or transportIsDead ~= nil  then
            unitsGroups.state[transporter] = "dead"
        else 
            unitsGroups.state[transporter] = "free"
        end
        local unitIsDead = Spring.GetUnitIsDead(transportedUnit)
        if not Spring.ValidUnitID(transportedUnit) or unitIsDead == false or unitIsDead ~= nil  then
            unitsGroups.state[transportedUnit] = "dead"
        else 
            unitsGroups.state[transportedUnit] = "fresh"
        end
    end
    return nil
end