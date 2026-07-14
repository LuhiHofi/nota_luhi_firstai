local sensorInfo = {
	name = "UpdateUnitInfo",
	desc = "Update unit info",
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

return function(unitsGroups)
    local units = Spring.GetTeamUnits(Spring.GetMyTeamID())
    local unitCounts = {atlases = 0, seers = 0, lugers = 0, mavericks = 0}
    for i = 1, #units do
        local unitID = units[i]
        if unitsGroups.state[unitID] == nil then  -- fresh unit
            local unitDefID = Spring.GetUnitDefID(unitID)
            local name = UnitDefs[unitDefID].name
            if name == "armatlas" then
                unitsGroups.atlases[#unitsGroups.atlases+1] = unitID
                unitsGroups.state[unitID] = "free"
            elseif name == "armseer" then
                unitsGroups.seers[#unitsGroups.seers+1] = unitID
                unitsGroups.state[unitID] = "fresh"
            elseif name == "armmart" then
                unitsGroups.lugers[#unitsGroups.lugers+1] = unitID
                unitsGroups.state[unitID] = "fresh"
            elseif name == "armmav" then
                unitsGroups.mavericks[#unitsGroups.mavericks+1] = unitID
                unitsGroups.state[unitID] = "fresh"
            else
                unitsGroups.state[unitID] = "fresh"
            end
        end
    end
    -- update unitCounts
    for i = 1, #unitsGroups.atlases do
        local unitID = unitsGroups.atlases[i]
        local unitIsDead = Spring.GetUnitIsDead(unitID)
        if Spring.ValidUnitID(unitID) and unitIsDead == false and unitIsDead ~= nil  then
            unitCounts.atlases = unitCounts.atlases + 1
        else 
            unitsGroups.state[unitID] = "dead"
        end
    end
    for i = 1, #unitsGroups.seers do
        local unitID = unitsGroups.seers[i]
        local unitIsDead = Spring.GetUnitIsDead(unitID)
        if Spring.ValidUnitID(unitID) and unitIsDead == false and unitIsDead ~= nil  then
            unitCounts.seers = unitCounts.seers + 1
        else 
            unitsGroups.state[unitID] = "dead"
        end
    end
    for i = 1, #unitsGroups.lugers do
        local unitID = unitsGroups.lugers[i]
        local unitIsDead = Spring.GetUnitIsDead(unitID)
        if Spring.ValidUnitID(unitID) and unitIsDead == false and unitIsDead ~= nil  then
            unitCounts.lugers = unitCounts.lugers + 1
        else 
            unitsGroups.state[unitID] = "dead"
        end
    end
    for i = 1, #unitsGroups.mavericks do
        local unitID = unitsGroups.mavericks[i]
        local unitIsDead = Spring.GetUnitIsDead(unitID)
        if Spring.ValidUnitID(unitID) and unitIsDead == false and unitIsDead ~= nil  then
            unitCounts.mavericks = unitCounts.mavericks + 1
        else 
            unitsGroups.state[unitID] = "dead"
        end
    end

    return unitCounts
end