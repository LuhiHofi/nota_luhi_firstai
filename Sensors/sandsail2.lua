local sensorInfo = {
	name = "sandsail2",
	desc = "Setup group and create a windLine formation",
	author = "Lukáš Hofman",
	date = "2026-04-14",
	license = "notAlicense",
}

EVAL_PERIOD_DEFAULT = 0

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function()
    return {
        getGroupDef = function(units, leaderID)
            local g = {}
            g[leaderID] = 1 -- Maverick is always pointman
            
            local slot = 2
            for i=1, #units do
                local id = units[i]
                if id ~= leaderID then
                    g[id] = slot
                    slot = slot + 1
                end
            end
            return g
        end,

        getWindLine = function(angle, count, spacing)
            local f = {}
            local perpAngle = angle + (math.pi / 2)
            f[1] = Vec3(0, 0, 0) -- Maverick's offset
            for i = 2, count do
                local side = (i % 2 == 0) and 1 or -1
                local dist = math.ceil((i - 1) / 2) * (spacing or 50) * side
                f[i] = Vec3(dist * math.sin(perpAngle), 0, dist * math.cos(perpAngle))
            end
            return f
        end
    }
end