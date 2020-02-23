include("shared.lua")

function ENT:Draw()
  self:DrawModel()
end


function ENT:Initialize()
  ParticleEffectAttach( "cough", 1, self, 1 )
end

killicon.Add( "cough_phlem", "thieves/footprint", Color( 0, 255, 0, 255 ) )
