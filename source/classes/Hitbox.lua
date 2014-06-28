Hitbox = class:new()


function Hitbox:init(position, dimensions)
	self.a = position - (dimensions/2)
	self.b = position + (dimensions/2)
	self.dimensions = dimensions
end

function Hitbox:collision(hitbox)
	return (self.a.x < hitbox.b.x and self.a.y < hitbox.b.y and self.b.x> hitbox.a.x and self.b.y > hitbox.a.y)		
end


function Hitbox:setPos(position)
	self.a = position - (self.dimensions/2)
	self.b = position + (self.dimensions/2)
end

function Hitbox:translate(dp)
	self.a = self.a + dp
	self.b = self.b + dp
end

function Hitbox:status()
	print("Hitbox status:\na: " .. tostring(self.a) .. "\nb: " .. tostring(self.b))
end

function Hitbox:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", self.a.x, self.a.y, self.dimensions.x, self.dimensions.y)
end