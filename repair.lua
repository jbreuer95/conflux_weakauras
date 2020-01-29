-- PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY, PLAYER_ENTERING_WORLD, ZONE_CHANGED, ZONE_CHANGED_INDOORS, ZONE_CHANGED_NEW_AREA
function() 
    local active = aura_env.config["active"];
    if active then
        local activeday = aura_env.config["day"];    
        local day = date("*t").wday;
        if day == activeday then
            if zoneName == "Molten Core" or zoneName == "Onyxia's Lair" then
                return false;    
            else 
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
        else 
            return false;    
        end
    else
        return false;
    end  
end

function() 
    local total = 0;
    local totalmax = 0;
    local i,cur,max;
    for i=1,20 do
        cur,max=GetInventoryItemDurability(i);
        if cur and max then            
            total = total + cur;
            totalmax = totalmax + max;
        end
    end
    return math.floor(total / totalmax * 100);
end
