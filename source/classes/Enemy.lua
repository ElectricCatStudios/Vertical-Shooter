Enemy = newclass("Enemy", GameObject)

function Enemy:init(id, parent, position, path)
	position = path.position

	self.super:init(id, parent, position, spr_enemyShip1)
	
	self.path = path
	self.hitbox = Hitbox:new(self.position,Vector(self.sprite:getDimensions()))
end

function Enemy:draw()
	self.super:draw()
	self.hitbox:draw()
	self.path:draw()
end

function Enemy:update(dt)
	self.path:update(dt)
	self.position = self.path.position
	self.hitbox:setPos(self.position)
end

function Enemy:status()
	print("status for Enemy:\n" .. tostring(self.position) .. "\n")
end