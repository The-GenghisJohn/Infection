-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile()
end


SWEP.ViewModel = Model("models/weapons/v_hands.mdl")
SWEP.WorldModel = Model("models/props_phx/misc/egg.mdl")
SWEP.Base		= "weapon_base"
SWEP.PrintName		= "Cough"
SWEP.Slot		= 1
SWEP.SlotPos		= 1
SWEP.Author		= "GenghisJohn"
SWEP.Contact		= "N/A"
SWEP.Purpose		= ""
SWEP.Instructions	= "click ma boi"
SWEP.CSMuzzleFlashes    = false
SWEP.ViewModelFOV	= 90
SWEP.Drawammo 		= false
SWEP.DrawCrosshair 	= true
SWEP.Category		= "Body Functions"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.HoldType = "magic"



local overheat = 0

SWEP.Primary.Sound		= "cough"
SWEP.Primary.Recoil		= 0.03
SWEP.Primary.Damage		= 0
SWEP.Primary.NumShots		= -1
SWEP.Primary.Cone		= 0.01
SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay		= 2
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
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

SWEP.data.burst 			= {}
SWEP.data.burst.Delay 		= 0.2
SWEP.data.burst.Cone 		= 0.03
SWEP.data.burst.BurstDelay 	= 0.05
SWEP.data.burst.Shots 		= 3
SWEP.data.burst.Counter 	= 0
SWEP.data.burst.Timer 		= 0




function SWEP:Initialize()
	self:SetHoldType( "magic" )
end

function SWEP:PrimaryAttack()
	-- self.Weapon:SetNextPrimaryFire(CurTime() + 4)
	-- local shoot_angle = Vector(0,0,0)
	shoot_angle = self.Owner:GetAimVector()
	local shoot_pos = self.Owner:GetPos() + self.Owner:GetRight() * 5 + self.Owner:GetUp() * 50 + shoot_angle * 35

	if self.Owner:IsPlayer() then
		shoot_pos = self.Owner:GetPos() + self.Owner:GetRight() * 5 + self.Owner:GetUp() * 55 + shoot_angle * 35
	end

	if (SERVER) then
		local shot = ents.Create("cough_phlem")
		if (!IsValid(shot)) then
			print("Couldn't make Phlem")
			return
		end
		shot:SetOwner(self.Owner)

		shot:SetPos(shoot_pos)
		shot:SetAngles(shoot_angle:Angle())
		shot:Activate()
		shot:Spawn()

		local phy = shot:GetPhysicsObject()
		if phy:IsValid() then
			local forcexer = 1000
			local gamemodepower = GetConVar("CoughPower")
			if gamemodepower then
				print("Got force from gamemode ", gamemodepower:GetInt())
				forcexer = gamemodepower:GetInt()
			end
			phy:ApplyForceCenter((shoot_angle * forcexer))
		end
	end

	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )



	-- print("When shot, shoot angle is:")
	-- print((shoot_angle * 1000))

	//self.Owner:MuzzleFlash()
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
