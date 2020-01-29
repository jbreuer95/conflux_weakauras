function(newPositions, activeRegions)       
    local offset = 0       
    local main = 0
    
    for i = 1, #activeRegions do     
        if not activeRegions[i].region.state.alt then
            main = main + 1
        end
    end
    
    local mid = main / 2
    
    for i = 1, #activeRegions do            
        local width = activeRegions[1].data.width
        local height = activeRegions[1].data.height
        local state = activeRegions[i].region.state        
        
        if i ~= 1 then  
            if newPositions[i-1][2] ~= 0 then
                offset = offset + activeRegions[i-1].data.width
            end            
        end
        
        if state.alt and i ~= 1 then        
            local lastx = newPositions[i-1][1]                  
            newPositions[i] = {
                lastx,
                -activeRegions[i-1].data.height
            }
        else
            newPositions[i] = {
                (i - mid) * width - offset,
                0
            }
        end
    end
    
end
