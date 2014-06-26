-- dependencies
require "./source/lib/class"				-- class
Vector = require "./source/lib/vector"		-- vector

-- classes
require "./source/classes/StateManager"		-- StateManager
require "./source/classes/Player"			-- Player

state = StateManager:new()					-- init state system

-- states
require "./source/states/gameState"			-- game

-- images
spr_playerShip1 = love.graphics.newImage("/source/resources/playerShip1.jpg")		-- playerShip1

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
	state:keypressed(key)
end