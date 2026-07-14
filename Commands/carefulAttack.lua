function getInfo()
	return {
		onNoUnits = SUCCESS,
		tooltip = "Moves a unit toward an enemy position until within weapon range, then attacks.",
		parameterDefs = {
			{ 
				name = "unitID",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			-- @parameter unitID - the unit performing the action
			{ 
				name = "weaponRange",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "0",
			},
			-- @parameter weaponRange - the maximum weapon range of your unit
			{ 
				name = "enemy",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "",
			},
			-- @parameter enemyPosition - unit ID
		}
	}
end

function Run(self, units, parameter)
	local unitID = parameter.unitID
	local weaponRange = parameter.weaponRange
	local enemyID = parameter.enemy
	local enemyData = bb.enemies[enemyID]
	
	if not enemyData or not enemyData.pos then
		return FAILURE
	end

	local enemyPos = enemyData.pos
	-- Spring.Echo("Enemy position [" .. enemyPos.x .. ", " .. enemyPos.z .. "]")

	if not Spring.ValidUnitID(unitID) or Spring.GetUnitIsDead(unitID) then
		return FAILURE
	end

	if not Spring.ValidUnitID(enemyID) or Spring.GetUnitIsDead(enemyID) then
		return SUCCESS
	end

	local unitPos = Vec3(Spring.GetUnitPosition(unitID))	
	local distance = unitPos:Distance(enemyPos)

	if distance > weaponRange then
		if self.lastState ~= "MOVING" then
			Spring.GiveOrderToUnit(unitID, CMD.MOVE, enemyPos:AsSpringVector(), {})
			self.lastState = "MOVING"
		end
		return RUNNING
	else
		if self.lastState ~= "ATTACKING" then
			Spring.GiveOrderToUnit(unitID, CMD.FIGHT, enemyPos:AsSpringVector(), {})
			self.lastState = "ATTACKING"
		end		
		return RUNNING 
	end
end

function Reset(self)
	self.lastState = nil
end