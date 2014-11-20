StandardBullet = class:new()

function StandardBullet:init(position, sprite, dimensions, direction, speed)
	self.position = position
	self.sprite = sprite
	self.dimensions = dimensions
	self.direction = direction or Vector.UP
	self.speed = speed or 300
	self.vel = self.direction*self.speed
	self.hitbox = Hitbox:new(position, dimensions)
end

function StandardBullet:update(dt)
	local dp = self.vel*dt
	self.position = dp + self.position
	self.hitbox:translate(dp)
end

function StandardBullet:draw()
	self.hitbox:draw()
end