local gameState = {}

function gameState:init()
	self.timer = 0

	testPlayer = Player:new()
end


function gameState:update(dt)
	self.timer = self.timer + dt
	testPlayer:update(dt)
end


function gameState:draw()
	love.graphics.print(self.timer, 16, 16)
	testPlayer:draw()
end

function gameState:keypressed(key)
	if (key == "p") then
		state:pauseToggle()
	end
end

state:add("game", gameState)