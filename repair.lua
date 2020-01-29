-- PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY, PLAYER_ENTERING_WORLD, ZONE_CHANGED, ZONE_CHANGED_INDOORS, ZONE_CHANGED_NEW_AREA
function()
    local testmode = aura_env.config["testmode"]

    if testmode ~= true then
        local ginfo = GetGuildInfoText()
        local raid = aura_env.config["raid"]
        if string.match(ginfo, raid) then
            aura_env.raidday = true
        else
            aura_env.raidday = false
        end

        local zoneName = GetRealZoneText()
        if zoneName == raid then
            aura_env.raided = true
        end

        if aura_env.raided == true or aura_env.raidday == false then
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
