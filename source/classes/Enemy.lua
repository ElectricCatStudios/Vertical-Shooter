Enemy = class:new()

function Enemy:init(path)
	self.path = path
	self.position = path:getCurrent().position
	self.path.current = self.path.current + 1
	self.sprite = spr_enemyShip1
	self.hitbox = Hitbox:new(self.position,Vector(self.sprite:getDimensions()))
end

function Enemy:draw()
	love.graphics.draw(self.sprite, self.position.x, self.position.y, 0, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
	self.hitbox:draw()
end

function Enemy:update(dt)
	self.path:update(dt)
	self.position = self.path.position
	self.hitbox:setPos(self.position)
end

function Enemy:status()
	print("status for Enemy:\n" .. tostring(self.position) .. "\n")
end