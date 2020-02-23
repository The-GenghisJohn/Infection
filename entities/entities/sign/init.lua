-- AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
  self:SetModel("models/hunter/plates/plate2x4.mdl")
  self:SetMoveType(6) --MOVETYPE_VPHYSICS
  self:PhysicsInit(6) --SOLID_VPHYSICS
  self:SetSolid(6) --SOLID_VPHYSICS
end

function ENT:PhysicsCollide( data, physobj )

  print(data.HitEntity)

end
