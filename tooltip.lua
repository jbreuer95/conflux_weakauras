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

local frame = WeakAuras.regions[id].region
local item = GetItemInfo(aura_env.config["name"]);
local amount = aura_env.config["amount"];

frame:EnableMouse(true)
frame:SetScript("OnEnter", function() MouseoverTooltip(frame, item, amount);end)
frame:SetScript("OnLeave", WeakAuras.HideTooltip);
