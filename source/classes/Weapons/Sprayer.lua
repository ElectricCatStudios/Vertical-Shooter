Sprayer = class:new()

function Sprayer:init(parent)
	self.parent = parent
	self.rof = nil
	self:setLevel(2)
	self.shootTimer = 0
end

function Sprayer:update(dt)
	self.shootTimer = self.shootTimer + dt
	if (self.shootTimer > self.rof) then
		table.insert(self.parent.bulletList, Bullet:new(self.parent.position, nil, Vector(4,4)))
		self.shootTimer = self.shootTimer - self.rof
	end
end

function Sprayer:setLevel(level)
	self.rof = 0.5/level
end