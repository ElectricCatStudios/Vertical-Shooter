Bullet = newclass("Bullet")
function Bullet:init(position, sprite, dimensions, direction, speed)
	self.position = position
	self.sprite = sprite
	self.dimensions = dimensions
	self.direction = direction or Vector.UP
	self.speed = speed or 600
	self.vel = self.direction*self.speed
	self.hitbox = Hitbox:new(position, dimensions)
	self.id = nil
end

function Bullet:update(dt)
	local dp = self.vel*dt
	self.position = dp + self.position
	self.hitbox:translate(dp)
	if (self.position.y < global_currentState.camPos.y - 10) then		-- TODO: not use constant here
		global_currentState:removeProjectile(self.id)
	end
end

function Bullet:draw()
	self.hitbox:draw()
end