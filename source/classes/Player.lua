Player = class:new()


function Player:init()
	self.SPEED = 150
	self.position = Vector(love.window.getWidth()/2, love.window.getHeight()/2)
	self.sprite = spr_playerShip1
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

	self.position = self.position + (v*dt*self.SPEED)
end


function Player:draw()
	love.graphics.draw(self.sprite, self.position.x, self.position.y, 0, 1, 1, self.sprite:getWidth()/2, self.sprite:getHeight()/2)
end

function Player:status()
	print("status for Player:\n" .. tostring(self.position))
end