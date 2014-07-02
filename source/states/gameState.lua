local gameState = {}

function gameState:init()
	self.timer = 0

	testPath = Path:new()
	testPath:addFrame('start', Vector(32, 32))
	testPath:addFrame('bezier3', 2, Vector(32*1.5,32*4), Vector(32*3.5,32*4), Vector(32*4,32*1))
	testPath:addFrame('linear', 3.5,  Vector(32*4,32*4))
	testPath:addFrame('bezier2', 5.5,  Vector(32*1,32*4),  Vector(32*1,32*8))
	testPath:addFrame('end')
	testPath:printFrames()

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