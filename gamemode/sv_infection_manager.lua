local taunts = {"vo/npc/female01/gethellout.wav","vo/npc/male01/gethellout.wav", "vo/npc/female01/watchout.wav", "vo/npc/female01/notthemanithought02.wav","vo/npc/female01/notthemanithought01.wav"}

function makeSneeze(ply)
	print("Sneezin "..ply:Nick())
	ply:EmitSound("sneeze")
	for k, v in pairs( player.GetAll() ) do
		if v ~= ply then
			--TODO: Maybe check to see how far they are?
			local random_offset = math.random(0,10)/10
			timer.Simple( 0.5 + random_offset, function() --wait a little while so you can hear it
				v:EmitSound(taunts[math.random(1,#taunts)])
			end)

		end
	end
end


util.AddNetworkString("sneeze")
	net.Receive("sneeze", function(len, ply)
		if player_manager.GetPlayerClass(ply) == "player_infected" then
			makeSneeze(ply)
		end
	end)


--
-- player_manager.SetPlayerClass( ply, "player_infected" )
-- local orig_pos = ply:GetPos()
-- local orig_angle = ply:GetAngles()
-- local aim_vec = ply:GetAimVector()
-- ply:Spawn()
-- ply:SetEyeAngles((aim_vec):Angle())
-- ply:SetPos(orig_pos)
--
-- timer.Simple( 2, function() ply:Freeze(false)end )
