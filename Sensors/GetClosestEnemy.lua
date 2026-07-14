local sensorInfo = {
	name = "GetClosestEnemy",
	desc = "Returns a position of the closest enemy",
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

return function(position, enemies)
	local closestDistance = 10000
	local closestEnemyPosition = Vec3(0,0,0)
	local closestEnemy = nil
	for enemyID, enemyData in pairs(enemies) do
		local unitPos = enemyData.pos
		local distance = position:Distance(unitPos)
		if (distance < closestDistance) then
			closestEnemyPosition = unitPos
			closestDistance = distance
			closestEnemy = enemyID
		end
	end 

	return closestEnemy
end