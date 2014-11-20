-- dependencies
require "./source/lib/class"				-- class
require "./source/lib/util"					-- util
Vector = require "./source/lib/vector"		-- vector

Vector.UP = Vector(0, -1)
Vector.DOWN = Vector(0, 1)
Vector.LEFT = Vector(-1, 0)
Vector.RIGHT = Vector(1, 0)

-- classes
require "./source/classes/StandardBullet"	-- Standard Bullet
require "./source/classes/StateManager"		-- StateManager
require "./source/classes/Player"			-- Player
require "./source/classes/Enemy"			-- Enemy
require "./source/classes/Hitbox"			-- Hitbox
require "./source/classes/Path"				-- Path

state = StateManager:new()					-- init state system

-- states
require "./source/states/gameState"			-- game

-- images
spr_playerShip1 = love.graphics.newImage("/resources/playerShip1.jpg")		-- playerShip1
spr_enemyShip1 = love.graphics.newImage("/resources/enemyShip1.jpg")		-- enemyShip1
spr_testBackground = love.graphics.newImage("/resources/testLevel.png") 	-- testBackground

function love.load()
	state:set("game","./lvl/testLevel.lvl")
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