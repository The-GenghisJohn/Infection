-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile()
end


SWEP.ViewModel = Model("models/weapons/c_toolgun.mdl")
SWEP.WorldModel = Model("models/weapons/c_toolgun.mdl")
SWEP.HoldType = "magic"
SWEP.Base		= "weapon_base"
SWEP.PrintName		= "Sign Putter"
SWEP.Slot		= 1
SWEP.SlotPos		= 1
SWEP.Author		= "GenghisJohn"
SWEP.Contact		= "N/A"
SWEP.Purpose		= ""
SWEP.Instructions	= "Shoot with primary fire."
SWEP.CSMuzzleFlashes    = false
SWEP.ViewModelFOV	= 70
SWEP.Drawammo 		= false
SWEP.DrawCrosshair 	= true
SWEP.Category		= "Body Functions"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true



local overheat = 0

SWEP.Primary.Sound		= "drywall.ImpactHard"
SWEP.Primary.Recoil		= 0.0
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= -1
SWEP.Primary.Cone		= 0.01
SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay		= 0.2
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= false
SWEP.Weight = 5

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.data 				= {}
SWEP.mode 				= "semi"

SWEP.data.semi 			= {}
SWEP.data.semi.Cone 		= 0.015

-- SWEP.data.burst 			= {}
-- SWEP.data.burst.Delay 		= 0.2
-- SWEP.data.burst.Cone 		= 0.03
-- SWEP.data.burst.BurstDelay 	= 0.05
-- SWEP.data.burst.Shots 		= 3
-- SWEP.data.burst.Counter 	= 0
-- SWEP.data.burst.Timer 		= 0

function spawn_sign(pos)
	local shot = ents.Create("sign")
	if (!IsValid(shot)) then
		print("Couldn't make Phlem")
		return
	end

	shot:SetPos(pos)
	shot:SetAngles(Angle(90,0,90))
	shot:Activate()
	shot:Spawn()
end

function SWEP:PrimaryAttack()
local bullet = {}
bullet.Src = self.Owner:GetShootPos()
bullet.Dir = self.Owner:GetAimVector()

bullet.Tracer = 1
bullet.Force = self.Primary.Force
bullet.Damage = self.Primary.Damage

self:ShootEffects()

self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )

self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	local tr = util.TraceHull(
	{start=bullet.Src, endpos=bullet.Dir, filter = self:GetOwner(), mask=MASK_SHOT_HULL,
		mins=Vector(1,1,1)*-10,
		maxs=Vector(1,1,1)*10,
	}
	)
	spawn_sign(tr.HitPos)

	print(tr.HitPos)
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if (self.Primary.Sound ~= nil) then
		self.Weapon:EmitSound(Sound(self.Primary.Sound))
	end

	-- self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if !self.Owner:IsNPC() then
	-- if (self.Primary.TakeAmmoPerBullet) then
	-- 	self:TakePrimaryAmmo(self.Primary.NumShots)
	-- else
	-- 	self:TakePrimaryAmmo(1)
	-- end
	end

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	-- if not self:CanPrimaryAttack() or self.Owner:WaterLevel() > 2 then return end
	-- If your gun have a problem or if you are under water, you'll not be able to fire

	self.Reloadaftershoot = CurTime() + self.Primary.Delay
	-- Set the reload after shoot to be not able to reload when firering

	-- self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	-- Set next secondary fire after your fire delay

	-- self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	-- Set next primary fire after your fire delay

	-- Emit the gun sound when you fire

	-- self:RecoilPower()

	-- self:TakePrimaryAmmo(1)
	-- Take 1 ammo in you clip

end

function SWEP:SecondaryAttack()


end

function SWEP:Deploy()
-- self.Weapon:EmitSound("smb_powerup.wav")
end
