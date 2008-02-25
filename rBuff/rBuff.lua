  
  ---------------------------
  -- based on p3lim pbuffs --
  ---------------------------

  local addon = CreateFrame"Frame"
  local _G = getfenv(0)
  
  addon:SetScript("OnEvent", function()
    
    if(event=="PLAYER_LOGIN") then
      
      --TemporaryEnchantFrame:ClearAllPoints()
      --TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -12, 3)
      --TemporaryEnchantFrame.SetPoint = function() end
      
      BuffFrame:ClearAllPoints()
      BuffFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -15, 1)
      BuffFrame.SetPoint = function() end

      TicketStatusFrame:Hide()
      TicketStatusFrame.Show = function() end
    elseif(event=="PLAYER_AURAS_CHANGED") then
      local i
      i = 1
      while _G["BuffButton"..i] do addon:Update("BuffButton"..i) i = i + 1 end
      i = 1
      while _G["DebuffButton"..i] do addon:Update("DebuffButton"..i, true) i = i + 1 end
      i = 1
      while _G["TempEnchant"..i] do addon:Update("TempEnchant"..i, true) i = i + 1 end
    end
    
  end)
  
  function addon:Update(name, isDebuff)
  
    local b = _G[name.."Border"]
    local i = _G[name.."Icon"]
    local f = _G[name]
    local c = _G[name.."Gloss"]

    --DEFAULT_CHAT_FRAME:AddMessage(name.."Gloss");
    
    if name == "DebuffButton1" then
    
      DebuffButton1:ClearAllPoints()
      DebuffButton1:SetPoint("TOPRIGHT", BuffFrame, "BOTTOMRIGHT", 0, 0)
      --DebuffButton1.SetPoint = function() end
    
    end
    
    
    if not c then
   
      local fg = CreateFrame("Frame", name.."Gloss", f)
      fg:SetAllPoints(f)
      
      f:SetScale(1)
      
      local t = f:CreateTexture(nil,"ARTWORK")
      t:SetTexture("Interface\\AddOns\\rTextures\\gloss")
      t:SetPoint("TOPLEFT", fg, "TOPLEFT", -0, 0)
      t:SetPoint("BOTTOMRIGHT", fg, "BOTTOMRIGHT", 0, -0)
      fg.texture = t
      
      i:SetTexCoord(0.1,0.9,0.1,0.9)
      i:SetPoint("TOPLEFT", fg, "TOPLEFT", 2, -2)
      i:SetPoint("BOTTOMRIGHT", fg, "BOTTOMRIGHT", -2, 2)
        
    end
    
    
    
    if b then b:Hide() end
  
  end
  
  SecondsToTimeAbbrev = function(time)
    local hr, m, s, text
    if time <= 0 then text = ""
    elseif(time < 3600 and time > 40) then
      m = floor(time / 60)
      s = mod(time, 60)
      text = (m == 0 and format("|cffffffff%d|r", s)) or format("|cffffffff%d:%02d|r", m, s)
    elseif time < 40 then
      m = floor(time / 60)
      s = mod(time, 60)
      text = (m == 0 and format("|cffffffff%d|r", s))
    else
      hr = floor(time / 3600)
      m = floor(mod(time, 3600) / 60)
      text = format("%d:%2d", hr, m)
    end
    return text
  end
  
  addon:RegisterEvent"PLAYER_AURAS_CHANGED"
  addon:RegisterEvent"PLAYER_LOGIN"