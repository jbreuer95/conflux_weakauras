function(allstates, event, _, subEvent, _, _, sourceName, _, _, _, _, _, _, spellID)     
    if type(allstates) ~= "table" then
        return
    end

    if event == "PLAYER_ENTERING_WORLD" then
        aura_env.loaded = true
    end

    if aura_env.loaded ~= true then
        return
    end 


    local items = aura_env.config["items"]
    local lastIndex = 1
    for i = 1, #aura_env.config["items"] do
        local item = aura_env.config["items"][i]
        local id = item.id
        local amount = item.amount        
        local name = GetItemInfo(id)
        local icon =  GetItemIcon(id)
        local count = GetItemCount(id)
        local show = false
        local changed = false

        local alt_id = item.alt
        local alt_amount = item.alt_amount
        local alt_name, alt_icon = nil
        local alt_count = 0
        local alt_show, alt_changed = false   

        
        if alt_id ~= '' then
            alt_name = GetItemInfo(alt_id)
            alt_icon = GetItemIcon(alt_id)
            alt_count =  GetItemCount(alt_id)
        end

        local zoneName = GetRealZoneText()
        if zoneName ~= "Molten Core" and zoneName ~= "Onyxia's Lair" then
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

        local stacks = amount - count
        local alt_stacks = alt_amount - alt_count

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
                index = lastIndex,
            }
            lastIndex = lastIndex + 1
        end
            
    end

    return true
end
