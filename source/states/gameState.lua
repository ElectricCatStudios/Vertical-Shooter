local gameState = {}

function gameState:init(lvl)
	self.SPAWN_DISTANCE = 50	-- how close to the top of the screen the enemies starting position must be before it spawns

	self.gameObjects = {}		-- storage for all gameObjects
	self.gameObjectIndex = 1	-- the index for the next gameObject to be added

	self.timer = 0				-- how long this state has been running for
	self.debugString = ""		-- a string that will be printed on screen
	self.spawnList = PriorityQueue:new()	-- list of enemies to spawn
	self.spawnIndex = 1 		-- the index of the next enemy to spawn
	self.lvldata = io.open(lvl, 'r')		-- the file holding the level data	
	self.background = spr_testBackground 	-- the sprite that will be used for the background
	self.camPos = nil			-- the position of the camera in global coordinates
	self.levelSpeed = 50		-- the rate at which the level scrolls  TODO: make this part of the level data
	self.borderWidth = 200		-- how close to the side of the level the player must be for it to scroll
	
	self.camPos = -Vector(-(self.background:getWidth() - love.window.getWidth())/2, love.window.getHeight()) -- set camera pos so that center of map is in center of screen

	-- setup the player
	self.player = Player:new(self.gameObjectIndex, self, Vector(self.background:getWidth()/2, -32))
	self.player.weapon = Sprayer:new(self.player)
	self.player.constSpeed = Vector.UP*(self.levelSpeed) 		-- the speed that the player will move up at constantly
	self:addGameObject(self.player)

	self:readMap()
end

function gameState:addGameObject(gameobject) 
	self.gameObjects[self.gameObjectIndex] = gameobject
	self.gameObjectIndex = self.gameObjectIndex + 1
end

function gameState:removeGameObject(id)
	self.gameObjects[id] = nil
end

function gameState:update(dt)
	self.timer = self.timer + dt

	-- camera scrolling
	-- Y scrolling
	self.camPos = self.camPos - Vector.DOWN*self.levelSpeed*dt

	local leftDis = self.player.position.x - self.camPos.x
	local rightDis = self.camPos.x + love.window.getWidth() - self.player.position.x
	if (leftDis < self.borderWidth) then
		self.camPos.x = self.player.position.x - self.borderWidth
	elseif (rightDis < self.borderWidth) then
		self.camPos.x = self.player.position.x + self.borderWidth - love.window.getWidth()
	end
	self.camPos.x = math.clamp(self.camPos.x, 0, self.background:getWidth() - love.window.getWidth())

	-- self.camPos.x = roundTo(self.camPos.x, 1, 'nearest')
	-- self.camPos.y = roundTo(self.camPos.y, 1, 'nearest')

	-- update loops
	for i, v in pairs(self.gameObjects) do
		v:update(dt)
	end
	
	-- spawn enemies in spawnList
	while(self.nextSpawnHeight and self.nextSpawnHeight > self.camPos.y) do
		local enemy = Enemy:new(self.gameObjectIndex, self, nil, self.nextSpawn.path)
		self:addGameObject(enemy)
		self.nextSpawn, self.nextSpawnHeight = self.spawnList:Remove()
	end
end

function gameState:draw()
	love.graphics.translate(-self.camPos.x, -self.camPos.y)
	self:globalDraw()
	love.graphics.origin()
	self:windowDraw()
end

-- drawing done in global coordinates
function gameState:globalDraw()
	love.graphics.draw(self.background, 0, -self.background:getHeight())
	love.graphics.print(self.timer, 16, 16)
	for i, v in pairs(self.gameObjects) do
		v:draw()
	end
end

-- drawing done in window coordinates (occurs after globalDraw)
function gameState:windowDraw()
	love.graphics.print(self.debugString, 16, 16)
end

function gameState:keypressed(key)
	if (key == "p") then
		state:pauseToggle()
	elseif (key == "escape") then
		love.event.quit()
	end
end

function gameState:readMap()
	io.input(self.lvldata)
	
	local nextEnemy = io.read()
	-- loop through each enemy
	repeat

		local enemyType, pathSegments, spawnTime = 
			string.match(nextEnemy, "%s*(%w+)%s*,%s*(%w+)%s*,*%s*(%w*)")				-- read enemy type, the number of path segments and the spawn time
		
		local newPath = Path:new()														-- the new path we are going to create
		
		-- loop through all path segments
		for i=1,pathSegments do
			input = io.read()
			local segmentType, parmNo, segTime = 
				string.match(input, "%s*(%w+)%s*,%s*(%w+)%s*,*%s*(%w*)")				-- read the segment type, the number of parameters it takes and the time
			local parmList = {}															-- the list of parms that this segment requires
			
			-- loop through all segment parameters
			for j=1, parmNo do
				input = io.read()
				local coord = Vector(string.match(input, "%s*(%-?%w+)%s*,%s*(%-?%w*)"))		-- read coordinates of the parameter
				table.insert(parmList, coord)
			end
			
			-- add the new path segment to the path
			if(segTime ~= '') then
				newPath:addFrame(segmentType, tonumber(segTime), unpack(parmList))
			else
				newPath:addFrame(segmentType, unpack(parmList))
			end
		end
		
		local enemyData = {['time'] = tonumber(spawnTime), ['path'] = newPath, ['type'] = enemyType,
			["startY"] = tonumber(newPath.startY)}

		self.spawnList:Insert(enemyData, newPath.startY)
		
		nextEnemy = io.read()
	until(not nextEnemy)

	self.nextSpawn, self.nextSpawnHeight = self.spawnList:Remove()
end

state:add("game", gameState)