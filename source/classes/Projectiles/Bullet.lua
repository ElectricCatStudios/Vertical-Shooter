Bullet = newclass("Bullet", GameObject)
function Bullet:init(id, parent, position, sprite, dimensions, direction, speed)
	self.super:init(id, parent, position, love.graphics.newCanvas(dimensions.x, dimensions.y))

	self.dimensions = dimensions
	self.direction = direction or Vector.UP
	self.speed = speed or 600
	self.vel = self.direction*self.speed
	self.hitbox = Hitbox:new(position, dimensions)
	-- TODO: need more elegant solution here
	self.collidesWithEnemy = true
end

function Bullet:update(dt)
	local dp = self.vel*dt
	self.position = dp + self.position
	self.hitbox:translate(dp)
	if (self.position.y < global_currentState.camPos.y - 10) then		-- TODO: not use constant here
		global_currentState:removeGameObject(self.id)
	end
end

function Bullet:draw()
	self.hitbox:draw()
end