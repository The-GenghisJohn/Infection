AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
  self:SetModel("models/props_phx/misc/egg.mdl")
  self:SetColor(Color( 180, 255, 124, 255 ))
  self:SetMoveType(6) --MOVETYPE_VPHYSICS
  self:PhysicsInit(6) --SOLID_VPHYSICS
  self:SetSolid(6) --SOLID_VPHYSICS
  self.is_dangerous = true

  local tespos = self:GetPos()
	local light = ents.Create("light_dynamic")
	light:Spawn()
	light:Activate()
	light:SetPos( tespos )
	light:SetKeyValue("distance", 400) -- 'distance' is equivalent to the radius of your light
	light:SetKeyValue("brightness", 2)
	light:SetKeyValue("_light", "0 255 0 255") -- '_light' is the color of your light. This currently makes it red
	light:Fire("TurnOn")
	light:SetParent( self )

  -- print(self:GetAngles())

  SafeRemoveEntityDelayed( self, 5 )

end

function ENT:PhysicsCollide( data, physobj )
  if data.HitEntity:IsNPC() then
    data.HitEntity:TakeDamage(1000, self.Owner, self)
    self.is_dangerous = false


  elseif data.HitEntity:IsPlayer() then
    if !self.is_dangerous then return end
    local ply = data.HitEntity
    -- print("Hit dat boi ya")
    self.is_dangerous = false

    if SERVER then
      -- Set the hit player to infected
      player_manager.SetPlayerClass( ply, "player_infected" )
      local orig_pos = ply:GetPos()
      local orig_angle = ply:GetAimVector()
      ply:Spawn()
      ply:Freeze(true)
      ply:SetEyeAngles((orig_angle):Angle())
      ply:SetPos(orig_pos)
      timer.Simple(4, function() ply:Freeze(false) end)


      --set the infected to Default
      local ply = self.Owner
      player_manager.SetPlayerClass( ply, "player_default" )
      local orig_pos = ply:GetPos()
      local orig_angle = ply:GetAimVector()
      ply:Spawn()

      ply:SetEyeAngles((orig_angle):Angle())
      ply:SetPos(orig_pos)
    end

	elseif data.HitEntity:IsWorld() then

    data.HitEntity:TakeDamage(1000, self.Owner, self)

	-- Play sound on bounce
  	if (data.Speed > 80 && data.DeltaTime > 0.2 ) then
      self.Entity:EmitSound( "SlipperySlime.StepRight" )
      self.Entity:EmitSound( "SlipperySlime.StepLeft" )
      self.Entity:EmitSound( "Watermelon.Scrape" )
  	end

  	-- Bounce like a crazy bitch
  	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
  	local NewVelocity = physobj:GetVelocity()
  	NewVelocity:Normalize()
  	-- self.Counter = self.Counter + 1
  	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
  	--
  	local TargetVelocity = NewVelocity * LastSpeed * 0.9
  	--
  	physobj:SetVelocity( TargetVelocity )
  else

    data.HitEntity:TakeDamage(1000, self.Owner, self)
  end
end
