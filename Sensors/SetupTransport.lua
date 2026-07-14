local sensorInfo = {
	name = "SetupTransport",
	desc = "Returns a pair of an available Atlas and a unit waiting to be transported.",
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

-- @description pair up an atlas with an unit to be transported
return function()
    local transportPair = {
        atlas = nil,
        unitToTransport = nil
    }

    -- find a free Atlas
    for i = 1, #bb.units.atlases do
        local atlasID = bb.units.atlases[i]
        local atlasStatus = bb.units.state[atlasID]
        if atlasStatus == "free" then
            transportPair.atlas = atlasID
            break
        end
    end

    -- seer
    for i = 1, #bb.units.seers do
        local unitID = bb.units.seers[i]
        local unitStatus = bb.units.state[unitID]
        if unitStatus == "fresh" then
            transportPair.unitToTransport = unitID
            break
        end
    end
    -- lugers
    for i = 1, #bb.units.lugers do
        local unitID = bb.units.lugers[i]
        local unitStatus = bb.units.state[unitID]
        if unitStatus == "fresh" then
            transportPair.unitToTransport = unitID
            break
        end
    end
    if transportPair.atlas ~= nil and transportPair.unitToTransport ~= nil then
        bb.units.state[transportPair.atlas] = "transporting"
        bb.units.state[transportPair.unitToTransport] = "transported"
    end

    return transportPair
end