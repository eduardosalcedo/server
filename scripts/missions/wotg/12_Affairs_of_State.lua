-----------------------------------
-- Affairs of State
-- Wings of the Goddess Mission 12
-----------------------------------
-- !addmission 5 11
-- Velda-Galda : !pos 138.631 -2.112 61.658 94
-- Radford     : !pos -205.303 -8.000 26.874 87
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.AFFAIRS_OF_STATE)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.BORNE_BY_THE_WIND },
}

local tryComplete = function(player, mission)
    -- If both are done:
    -- Obtained key item: Count Borel's letter
    -- Complete mission
end

mission.sections =
{
    -- Talk to these NPCs in either order:
    -- Velda-Galda (K-9) in Windurst Waters (S)
    -- Radford (H-6) in Bastok Markets (S)

    -- When you finish both cutscenes, you will be given Count Borel's letter and begin the next mission.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.WINDURST_WATERS_S] =
        {
            ['Velda-Galda'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    return mission:progressEvent(179, 2, 0, 1)
                end,

                -- TODO: Reminder?
            },

            onEventFinish =
            {
                [179] = function(player, csid, option, npc)
                    tryComplete(player, mission)
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS_S] =
        {
            ['Radford'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: What are these args from caps?
                    return mission:progressEvent(175, 2, 27, 0, 0, 0, 0, 1, 4095)
                end,

                -- TODO: After speaking:
                -- CS: 177, 87, 55, 0, 0, 0, 0, 1, 4095
            },

            onEventFinish =
            {
                [175] = function(player, csid, option, npc)
                    tryComplete(player, mission)
                end,
            },
        },
    },
}

return mission
