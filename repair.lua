-- PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY, PLAYER_ENTERING_WORLD, ZONE_CHANGED, ZONE_CHANGED_INDOORS, ZONE_CHANGED_NEW_AREA
function()
    local testmode = aura_env.config.testmode

    if testmode ~= true then
        local raidday = false
        local ginfo = GetGuildInfoText()

        local raids = aura_env.config.raids
        for raid in raids:gmatch("([^,]+)") do
            local _, i = string.find(ginfo, raid)
            if i then
                local day = date("*t").wday
                i = i + 2
                local rday = tonumber(ginfo:sub(i,i))
                if  rday == day then
                    raidday = true
                end
            end
        end

        local zoneName = GetRealZoneText()
        if zoneName == raid then
            aura_env.raided = true
        end

        if aura_env.raided == true or raidday == false then
            return false
        end
    end

    local i,cur,max;
    for i=1,20 do
        cur,max=GetInventoryItemDurability(i);
        if cur and max then
            if (cur/max) < 1 then
                return true;
            end
        end
    end
    return false;
end
