Sprayer = class:new()

function Sprayer:init(parent)
	self.parent = parent
	self.rof = nil
	self:setLevel(1)
	self.shootTimer = 0
end

function Sprayer:update(dt)
	self.shootTimer = self.shootTimer + dt
	if (self.shootTimer > self.rof) then
		local projectile = Bullet:new(self.parent.position, nil, Vector(4,4))
		projectile.id = global_currentState:addProjectile(projectile)
		print(projectile.id)
		self.shootTimer = self.shootTimer - self.rof
	end
end

function Sprayer:setLevel(level)
	self.rof = 0.5/level
end