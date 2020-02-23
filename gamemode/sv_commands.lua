include("player_class/player_infected.lua")

concommand.Add("!bot",function( ply, cmd, args )
    local newguy = player.CreateNextBot( "fuckwit" )
    -- player_manager.SetPlayerClass( newguy, "player_default" )
    -- newguy:Spawn()

end)

concommand.Add("!kick",function( ply, cmd, args )
    local players = player.GetAll()
    for k, target in pairs(players) do
  		if target:Nick() == args[1] then
  			   target:Kick()
  	  end
    end
end)

concommand.Add("!power",function( ply, cmd, args )
  print(args[1])
  if ply:IsAdmin() then
    local power = GetConVar("CoughPower")
    power:SetInt(args[1])
  end
end)


concommand.Add("!infect",function( ply, cmd, args )
  player_manager.SetPlayerClass( ply, "player_infected" )
  local orig_pos = ply:GetPos()
  local orig_angle = ply:GetAngles()
  local aim_vec = ply:GetAimVector()
  ply:Spawn()
  ply:SetEyeAngles((aim_vec):Angle())
  ply:SetPos(orig_pos)
end)

util.AddNetworkString("new_zombie")
	net.Receive("new_zombie", function(len, ply)
    local Ent = ents.Create("npc_zombie")
    Ent:SetName("Zombie Bitch")
    Ent:SetPos(ply:GetPos()+Vector(0,-50,15))
    Ent:Spawn()
	end)
