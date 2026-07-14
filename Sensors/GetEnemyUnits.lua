local sensorInfo = {
	name = "GetEnemyUnits",
	desc = "Returns a list of visible enemy units that are in range",
	author = "Luhi",
	date = "2026-07-14",
	license = "MIT",
}

VFS.Include("modules.lua")
VFS.Include(modules.attach.data.path .. modules.attach.data.head)

attach.Module(modules, "message")

local EVAL_PERIOD_DEFAULT = 0 -- instant, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

return function(enemyTeamIDs)
	local allEnemies = {}

	for j=1, #enemyTeamIDs do
		local teamID = enemyTeamIDs[j]
		local visibleUnits = Spring.GetTeamUnits(teamID)

		for i=1, #visibleUnits do
			local unitID = visibleUnits[i]
			local unitPos = Vec3(Spring.GetUnitPosition(unitID))
			allEnemies[unitID] = { pos = unitPos }
		end

	end 

	return allEnemies
end