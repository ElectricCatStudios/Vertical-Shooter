-- dependencies
require "./source/lib/class"				-- class
Vector = require "./source/lib/vector"		-- vector

-- classes
require "./source/classes/StateManager"		-- StateManager

state = StateManager:new()					-- init state system

-- states
require "./source/states/gameState"			-- game

function love.load()
	state:set("game")
	state:printStates()
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
	state:draw()
end

function love.keypressed(key,isrepeat)
	state:keypressed()
end