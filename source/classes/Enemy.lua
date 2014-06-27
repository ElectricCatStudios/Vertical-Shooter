Enemy = class:new()

function Enemy:init()
	self.position = Vector(love.window.getWidth()/2, love.window.getHeight()/2)
	self.sprite = spr_enemyShip1
	self.hitbox = Hitbox:new(self.position,Vector(self.sprite:getDimensions()))
end

function Enemy:draw()
	love.graphics.draw(self.sprite, self.position.x, self.position.y, 0, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
	self.hitbox:draw()
end

function Enemy:status()
	print("status for Enemy:\n" .. tostring(self.position) .. "\n")
end