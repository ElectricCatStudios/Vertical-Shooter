Player = newclass("Player", GameObject)

function Player:init(id, parent, position)
	-- statics
	Player.speed = Vector(250, 200)

	self.super:init(id, parent, position, spr_playerShip1)

	self.hitbox = Hitbox:new(self.position,Vector(self.sprite:getDimensions()))
	self.constSpeed = Vector(0, 0)
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

	-- v:normalize_inplace()

	v.x = v.x*self.speed.x
	v.y = v.y*self.speed.y
	local dp = (self.constSpeed + v)*dt
	self.position = self.position + dp
	self.hitbox:translate(dp)
	self.weapon:update(dt)
end

function Player:draw()
	self.super:draw()
	self.hitbox:draw()
end

function Player:setPos(position)
	self.position = position
	self.hitbox:setPos(position)
end

function Player:status()
	print("status for Player:\n" .. tostring(self.position))
end