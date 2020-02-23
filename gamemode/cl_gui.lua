-- local PANEL = {}
--
-- function PANEL:Init()
--     self:SetSize( 1000, 720 )
--     self:Center()
-- end
--
-- function PANEL:Paint( w, h )
--     draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,255) )
-- end
--
-- vgui.Register( "MyFirstPanel", PANEL, "Panel")



function show_infection_gui(client, com, args, full)
  local frame=vgui.Create("DFrame")
  frame:SetSize(1000,720)
  frame:Center()
  frame:SetVisible(true)
  frame:MakePopup()
  frame:SetTitle("Infection Manager")
  frame:SetScreenLock(true)
  frame:SetDeleteOnClose(true)


  local players = player.GetAll()
  for k, player in pairs(players) do
    print(k, player)

    local panel = vgui.Create("DPanel", frame)
    panel:SetPos(50, k * 50 + 50)
    -- panel:SetBackgroundColor(70,70,70)
    -- panel:Dock(FILL)
    panel:SetSize(900,50)


    local item = vgui.Create("DLabel", panel)
    item:Dock(LEFT)
    item:DockMargin(20,0,0,0)
    -- item:SetTextColor(100,100,100)
    local text = player:Nick()
    item:SetText(text)

    local class = vgui.Create("DLabel", panel)
    class:Dock(RIGHT)
    class:DockMargin(0,0,40,0)
    -- class:SetTextColor(100,100,100)
    local classname = player:GetClass()
    class:SetText(classname)


  end




  local Button = vgui.Create("DButton", frame)
  Button:SetText( "Click me I'm pretty!" )
  Button:SetTextColor( Color(255,255,255) )
  Button:SetPos( 100, 650 )
  Button:SetSize( 100, 30 )
  Button.Paint = function( self, w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
  end

  Button.DoClick = function()
    net.Start("sneeze")
    net.SendToServer()
  end


  local Button2 = vgui.Create("DButton", frame)
  Button2:SetText( "Spawn Zombie" )
  Button2:SetTextColor( Color(255,255,255) )
  Button2:SetPos( 300, 650 )
  Button2:SetSize( 100, 30 )
  Button2.Paint = function( self, w, h )
    draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
  end

  Button2.DoClick = function()
    net.Start("new_zombie")
    net.SendToServer()
  end

end

concommand.Add("+menu_context", function (client, com, args, full)
    if SERVER then return end
    net.Start("sneeze")
    net.SendToServer()
end)

net.Receive("showmenu", function (client, com, args, full)
    if SERVER then return end
		show_infection_gui(client, com, args, full)
end)

-- concommand.Add("-menu", function (client, com, args, full)
--     if SERVER then return end
-- 		show_infection_gui(client, com, args, full)
-- end)
