-- UNIT_INVENTORY_CHANGED, BAG_UPDATE, PLAYER_ENTERING_WORLD, ZONE_CHANGED, ZONE_CHANGED_INDOORS, ZONE_CHANGED_NEW_AREA
function(allstates, event, _, subEvent, _, _, sourceName, _, _, _, _, _, _, spellID)
    if type(allstates) ~= "table" then
        return
    end

    local lastIndex = 1
    for k, v in pairs(aura_env.config) do
        local raid = k
        local raidday = true
        local testmode = v.testmode
        if aura_env[raid] == nil then
            aura_env[raid] = {}
            aura_env[raid].raided = false
        end


        if testmode ~= true then
            local ginfo = GetGuildInfoText()
            local _, i = string.find(ginfo, raid)
            if i then
                local day = date("*t").wday
                i = i + 2
                local rday = tonumber(ginfo:sub(i,i))
                if rday ~= day then
                    raidday = false
                end
            else
                raidday = false
            end

            local zoneName = GetRealZoneText()
            if zoneName == raid then
                aura_env[raid].raided = true
            end
        end

        local items = v.items
        for i = 1, #items do
            local item = items[i]
            local id = item.id
            local active = item.active
            local amount = item.amount
            local name = GetItemInfo(id)
            local icon =  GetItemIcon(id)
            local count = GetItemCount(id)
            local stacks = amount - count
            local show = false
            local changed = false

            local alt_id = item.alt
            local alt_amount = item.alt_amount
            local alt_name, alt_icon = nil
            local alt_count, alt_stacks = 0
            local alt_show, alt_changed = false

            if alt_id ~= '' then
                alt_name = GetItemInfo(alt_id)
                alt_icon = GetItemIcon(alt_id)
                alt_count =  GetItemCount(alt_id)
                alt_stacks = alt_amount - alt_count
            end


            if aura_env[raid].raided == false and raidday == true then
                if active then
                    show = count < amount
                    if alt_id ~= '' then
                        alt_show = alt_count < alt_amount
                        if show and not alt_show then
                            show = false
                        end
                        if alt_show and not show then
                            alt_show = false
                        end
                    end
                end
            end


            if allstates[id] then
                if allstates[id].show ~= show or allstates[id].stacks ~= stacks then
                    changed = true
                end
            end

            if allstates[alt_id] then
                if allstates[alt_id].show ~= alt_show or allstates[alt_id].stacks ~= alt_stacks then
                    alt_changed = true
                end
            end

            allstates[id] = {
                show = show,
                changed = changed,
                name = name,
                icon = icon,
                stacks = stacks,
                itemId = id,
                alt = false,
                raid = raid,
                index = lastIndex,
            }
            lastIndex = lastIndex + 1

            if alt_id ~= '' then
                allstates[alt_id] = {
                    show = alt_show,
                    changed = alt_changed,
                    name = alt_name,
                    icon = alt_icon,
                    stacks = alt_stacks,
                    itemId = alt_id,
                    alt = true,
                    raid = raid,
                    index = lastIndex,
                }
                lastIndex = lastIndex + 1
            end
        end
    end
    return true
end
