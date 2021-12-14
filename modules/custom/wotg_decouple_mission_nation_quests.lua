-----------------------------------
-- Allow WOTG Missions to be completed without the accompanying WOTG Nation Quests
-----------------------------------
require("modules/module_utils")
require("scripts/missions/wotg/helpers")
-----------------------------------
local m = Module:new("wotg_decouple_mission_nation_quests")
m:setEnabled(false)

m:addOverride("xi.wotg.helpers.meetsMission3Reqs", function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

m:addOverride("xi.wotg.helpers.meetsMission4Reqs", function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

m:addOverride("xi.wotg.helpers.meetsMission8Reqs", function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

m:addOverride("xi.wotg.helpers.meetsMission15Reqs", function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

m:addOverride("xi.wotg.helpers.meetsMission26Reqs", function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

m:addOverride("xi.wotg.helpers.meetsMission38Reqs", function(player)
    -- Ignore the quest requirements, just return true
    return true
end)

return m
