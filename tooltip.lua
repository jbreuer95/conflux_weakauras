function MouseoverTooltip(owner)    
    GameTooltip:SetOwner(owner, "ANCHOR_BOTTOM");
    GameTooltip:SetPoint("TOP", owner, "BOTTOM");
    GameTooltip:ClearLines();
    GameTooltip:AddLine("test");
    GameTooltip:Show();
end

local frame = WeakAuras.GetRegion(aura_env.id, aura_env.cloneId)

frame:EnableMouse(true)
frame:SetScript("OnEnter", function() MouseoverTooltip(frame);end)
frame:SetScript("OnLeave", WeakAuras.HideTooltip);



local region = aura_env.regio
if not region.tooltipFrame then
    region.tooltipFrame = CreateFrame("frame", nil, region);
    region.tooltipFrame:SetAllPoints(region);
    region.tooltipFrame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(region, "ANCHOR_BOTTOM");
        GameTooltip:SetPoint("TOP", region, "BOTTOM");
        GameTooltip:ClearLines();
        GameTooltip:AddLine("test");
        GameTooltip:Show();
    end);
    region.tooltipFrame:SetScript("OnLeave", WeakAuras.HideTooltip);
end
region.tooltipFrame:EnableMouse(true);
