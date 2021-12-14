-----------------------------------
-- Daughter of a Knight
-- Wings of the Goddess Mission 10
-----------------------------------
-- !addmission 5 10
-- Amaura                     : !pos -84.367 -6.949 91.148 229
-- CERNUNNOS_BULB             : !additem 2728
-- Humus-rich Earth (past)    : !pos -510.535 7.568 289.283 82
-- Humus-rich Earth (present) : !pos -510.535 7.568 289.283 104
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local pastJugnerID = require('scripts/zones/Jugner_Forest_[S]/IDs')
local presentJugnerID = require('scripts/zones/Jugner_Forest/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.DAUGHTER_OF_A_KNIGHT)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_SPOONFUL_OF_SUGAR },
}

mission.sections =
{
    -- 0: Talk to Amaura at (G-6) in present day Southern San d'Oria.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(935, 0, 2) -- TODO: What is this 2?
                end,
            },

            onEventFinish =
            {
                [935] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 1: Trade a Cernunnos Bulb to Amaura.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 1
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CERNUNNOS_BULB) then
                        return mission:progressEvent(937, 0, 2)
                    end
                end,

                -- TODO: Is 936 a reminder?
                -- onTrigger = function(player, npc)
                -- end,
            },

            onEventFinish =
            {
                [937] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- 2. After the cutscene, go to the Maiden's Spring at (E-6) in Jugner Forest (S),
    -- and trade the Cernunnos Bulb to the "Humus-rich Earth." The message "You plant a Cernunnos Bulb."
    -- will display in the chat log.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 2
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.CERNUNNOS_BULB) then
                        -- TODO: You plant a Cernunnon bulb.
                        player:confirmTrade()
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,

                -- TODO: messageSpecial: "This seems like an ideal place to plant a Cernunnos bulb."
                --onTrigger = function(player, npc)
                --end,
            },
        },
    },

    -- 3. Go to present day Jugner Forest at the same spot and examine the "Humus-rich Earth" for a cutscene.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 3
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(33, 104, 0, 0, 53) -- TODO: What is this?
                end,
            },

            onEventFinish =
            {
                [33] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,
            },
        },
    },

    -- 4. Examine it again to fight the Cernunnos NM.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 4
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    -- Message: Your presence has drawn unwanted attention! (11924)
                    -- Spawn Cernunnos (13000hp)
                    return mission:progressEvent(33, 104, 0, 0, 53) -- TODO: What is this?
                end,
            },
        },
    },

    -- 5. Once Cernunnos is defeated, check the "Humus-rich Earth" again for a cutscene and Cernunnos Resin.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 5
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(34, 104, 300, 200, 100, 0, 1648, 0, 0) -- TODO: What is this?
                end,
            },

            onEventFinish =
            {
                [34] = function(player, csid, option, npc)
                    -- Obtained key item: Cernunnos resin.
                    player:setMissionStatus(mission.areaId, 6)
                end,
            },
        },
    },

    -- 6. Go back to Southern San d'Oria talk to Amaura for a cutscene.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 6
        end,

        [xi.zone.JUGNER_FOREST_S] =
        {
            ['Humus-rich_Earth'] =
            {
                -- Reminder: You must deliver the Cernunnos resin to Amaura in S.Sandoria
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                -- TODO: Check 938
                onTrigger = function(player, npc)
                    return mission:progressEvent(939, 0, 0, 0, 31, 0, 0, 1) -- TODO: What is this?
                end,
            },

            onEventFinish =
            {
                [939] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- 7. Wait until the next game day, zone, and talk to her again for a cutscene and the Bottle of Treant Tonic.
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 7
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Amaura'] =
            {
                -- TODO: Check 940
                onTrigger = function(player, npc)
                    return mission:progressEvent(941, 0, 2964, 3585, 4416) -- TODO: What is this?
                end,
            },

            onEventFinish =
            {
                [941] = function(player, csid, option, npc)
                    -- Obtain key item: Bottle of treant tonic
                    -- Complete mission
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },
    },

    -- TODO:
    -- 8. If you talk to her too soon, you must zone before trying again. Talking to her at exactly 0:00 will reset the clock.
}

return mission
