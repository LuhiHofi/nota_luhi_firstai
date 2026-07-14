local sensorInfo = {
	name = "GetUnitRange",
	desc = "Returns the range of a selected unit",
	author = "Luhi",
	date = "2026-07-11",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(unit)
    if not Spring.ValidUnitID(unit) then return 0 end
    local unitDefID = Spring.GetUnitDefID(unit)
    if not unitDefID then return 0 end
    
    local ud = UnitDefs[unitDefID]
    if not ud or not ud.weapons then return 0 end
    
    local maxRange = 0
    
    for _, weaponData in ipairs(ud.weapons) do
        local weaponDefID = weaponData.weaponDef
        if weaponDefID and WeaponDefs[weaponDefID] then
            local range = WeaponDefs[weaponDefID].range
            if range and range > maxRange then
                maxRange = range
            end
        end
    end
    
    return maxRange
end