function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Scan the map with peepers to discover the positions of all the enemies",
		parameterDefs = {
			{ 
				name = "peepers",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
        }
	}
end

function Run(self, units, parameter)
    local peepers = parameter.peepers  -- array of unitID
    -- init
    if not self.is_initialized then
        self.progress = {}
        bb.enemiesInfo = {}

        local offset = Game.mapSizeX / #peepers
        for i, unitID in ipairs(peepers) do
            self.progress[unitID] = 0
            local x = offset * i - offset / 2
            Spring.GiveOrderToUnit(unitID, CMD.MOVE, Vec3(x, Spring.GetGroundHeight(x, (Game.mapSizeZ - 50) / 2), (Game.mapSizeZ - 50) / 2):AsSpringVector() , {})
            Spring.GiveOrderToUnit(unitID, CMD.MOVE, Vec3(x, Spring.GetGroundHeight(x, Game.mapSizeZ), Game.mapSizeZ):AsSpringVector() , {"shift"})    
            Spring.GiveOrderToUnit(unitID, CMD.MOVE, Vec3(x, Spring.GetGroundHeight(x, 50), 50):AsSpringVector() , {"shift"})
        end

        self.is_initialized = true
    end

    -- store enemy information
    local enemies = Sensors.core.EnemyUnits()
    for index, enemyUnitID in ipairs(enemies) do
        if bb.enemiesInfo[enemyUnitID] == nil then
            bb.enemiesInfo[enemyUnitID] = {}
        end
        bb.enemiesInfo[enemyUnitID].position = Vec3(Spring.GetUnitPosition(enemyUnitID))
        local unitDefID = Spring.GetUnitDefID(enemyUnitID)
        if unitDefID ~= nil then
            local unitDef = UnitDefs[unitDefID]
            if unitDef ~= nil then
                bb.enemiesInfo[enemyUnitID].unitDef = unitDef
            end
        end
    end

    for i, unitID in ipairs(peepers) do
        local GetUnitIsDead = Spring.GetUnitIsDead(unitID)
        if GetUnitIsDead == true or GetUnitIsDead == nil then
            self.progress[unitID] = 1
        else
            local unit_position = Vec3(Spring.GetUnitPosition(unitID))
            if unit_position.z > Game.mapSizeZ-256 then 
                self.progress[unitID] = 1 
            end
        end
    end    
    -- check all success conditions
    -- all units are either dead or returned
    local isSuccess = true
    for i, unitID in ipairs(peepers) do
        local unitProgress = self.progress[unitID]
        if unitProgress == 0 then
            isSuccess = false
            break
        end
    end
    if isSuccess then return SUCCESS end

-- otherwise running
    return RUNNING
end

function Reset(self)
    self.is_initialized = false
    self.progress = {}
end