local gameState = {}

function gameState:init()
	self.timer = 0

	testPath = Path:new()
	testPath:addFrame('start', 16, 16)
	testPath:addFrame('linear',10,10)
	testPath:addFrame('linear',100,100)
	testPath:printFrames()

	testPlayer = Player:new()
	testEnemy = Enemy:new(testPath)
end

function gameState:update(dt)
	self.timer = self.timer + dt
	testPlayer:update(dt)
end

function gameState:draw()
	love.graphics.print(self.timer, 16, 16)
	testPlayer:draw()
	testEnemy:draw()
end

function gameState:keypressed(key)
	if (key == "p") then
		state:pauseToggle()
	end
end

state:add("game", gameState)