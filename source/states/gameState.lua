local gameState = {}

function gameState:init()
	self.timer = 0

	testPath = Path:new()
	testPath:addFrame('start', Vector(16, 16))
	testPath:addFrame('linear', Vector(32*1,32*1), 1)
	testPath:addFrame('linear', Vector(32*1,32*10), 4)
	testPath:addFrame('linear', Vector(32*3,32*6), 6)
	testPath:addFrame('linear', Vector(32*16,32*3), 9)
	testPath:addFrame('end')

	testPlayer = Player:new()
	testEnemy = Enemy:new(testPath)
end

function gameState:update(dt)
	self.timer = self.timer + dt
	testPlayer:update(dt)
	testEnemy:update(dt)
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