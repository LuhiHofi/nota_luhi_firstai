local sensorInfo = {
	name = "DoubleLineFormation",
	desc = "Return a DoubleLineFormation",
	author = "Luhi",
	date = "2026-05-13",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- instant, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

local DoubleLineFormation =	{
        positions = {
            -- back line
            [1]  = { 0, 0},   -- Pointman
            [3]  = {-1, 0},
            [5]  = { 1, 0},
            [7]  = {-2, 0},
            [9]  = { 2, 0},

            -- front line
            [2]  = { 0, 1},
            [4]  = {-1, 1},
            [6]  = { 1, 1},
            [8]  = {-2, 1},
            [10] = { 2, 1},
        }
}

return function()
	local formation = {}
	local formationCounts = 1
	
	for i=1, #DoubleLineFormation.positions do
		formation[formationCounts] = Vec3(DoubleLineFormation.positions[i][1], 0, -DoubleLineFormation.positions[i][2])
		formationCounts = formationCounts + 1
	end	
	return formation
end