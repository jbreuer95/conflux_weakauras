function()
    return aura_env.config["active"];
end

function()
    local active = aura_env.config["active"];
    if active then
        local activedays = aura_env.config["days"];    
        local day = date("*t").wday;
        if activedays[day] then
            local zoneName = GetRealZoneText();
            if zoneName == "Molten Core" or zoneName == "Onyxia's Lair" then
                return false;    
            else 
                local item = aura_env.config["name"];
                local count = GetItemCount(item);
                local amount = aura_env.config["amount"];
                return count < amount;                
            end
        else 
            return false;    
        end
    else
        return false;
    end
end

function()
    local item = aura_env.config["name"];
    return GetItemIcon(item);
end

function()
    local item = aura_env.config["name"];
    local amount = aura_env.config["amount"];
    local count = GetItemCount(item);    
    return amount - count;
end


function() 
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

function MouseoverTooltip(owner, item, amount)    
    GameTooltip:SetOwner(owner, "ANCHOR_BOTTOM");
    GameTooltip:SetPoint("TOP", owner, "BOTTOM");
    GameTooltip:ClearLines();
    GameTooltip:AddLine(item);
    GameTooltip:AddLine("Needed: " .. amount);
    GameTooltip:AddLine("In bag: " .. GetItemCount(item));
    GameTooltip:AddLine("In bank: " .. GetItemCount(item, true) -  GetItemCount(item));
    GameTooltip:AddLine("Remaining: " .. amount - GetItemCount(item, true));
    GameTooltip:Show();
end

local id=aura_env.id
local frame = WeakAuras.regions[id].region
local item = GetItemInfo(aura_env.config["name"]);
local amount = aura_env.config["amount"];

frame:EnableMouse(true)
frame:SetScript("OnEnter", function() MouseoverTooltip(frame, item, amount);end)
frame:SetScript("OnLeave", WeakAuras.HideTooltip);

PLAYER_ENTERING_WORLD, PLAYER_DEAD, UPDATE_INVENTORY_DURABILITY, ZONE_CHANGED, ZONE_CHANGED_INDOORS, ZONE_CHANGED_NEW_AREA
PLAYER_ENTERING_WORLD, UNIT_INVENTORY_CHANGED, BAG_UPDATE, ZONE_CHANGED, ZONE_CHANGED_INDOORS, ZONE_CHANGED_NEW_AREA
