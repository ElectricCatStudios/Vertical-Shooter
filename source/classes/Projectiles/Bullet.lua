Bullet = class:new()

function Bullet:init(position, sprite, dimensions, direction, speed)
	self.position = position
	self.sprite = sprite
	self.dimensions = dimensions
	self.direction = direction or Vector.UP
	self.speed = speed or 600
	self.vel = self.direction*self.speed
	self.hitbox = Hitbox:new(position, dimensions)
end

function Bullet:update(dt)
	local dp = self.vel*dt
	self.position = dp + self.position
	self.hitbox:translate(dp)
end

function Bullet:draw()
	self.hitbox:draw()
end