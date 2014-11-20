Player = class:new()

function Player:init(bulletList)
	self.speed = Vector(250, 200)
	self.position = Vector(0, 0)
	self.sprite = spr_playerShip1
	self.hitbox = Hitbox:new(self.position,Vector(self.sprite:getDimensions()))
	self.constSpeed = Vector(0, 0)
	self.bulletList = bulletList
end

function Player:update(dt)
	-- movement
	local v = Vector(0, 0)		-- velocity
	if (love.keyboard.isDown('down')) then
		v = v + Vector(0,1)
	end
	if (love.keyboard.isDown('up')) then
		v = v + Vector(0,-1)
	end
	if (love.keyboard.isDown('left')) then
		v = v + Vector(-1,0)
	end
	if (love.keyboard.isDown('right')) then
		v = v + Vector(1,0)
	end

	v:normalize_inplace()

	v.x = v.x*self.speed.x
	v.y = v.y*self.speed.y
	local dp = (self.constSpeed + v)*dt
	self.position = self.position + dp
	self.hitbox:translate(dp)

	table.insert(self.bulletList, StandardBullet:new(self.position, nil, Vector(4,4)))
end

function Player:draw()
	love.graphics.draw(self.sprite, self.position.x, self.position.y, 0, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
	self.hitbox:draw()
end

function Player:setPos(position)
	self.position = position
	self.hitbox:setPos(position)
end

function Player:status()
	print("status for Player:\n" .. tostring(self.position))
end