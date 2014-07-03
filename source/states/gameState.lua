local gameState = {}

function gameState:init(lvl)
	self.timer = 0
	self.enemyList = {}
	self.spawnList = {}
	self.spawnIndex = 1
	self.lvldata = io.open(lvl, 'r')
	
	self:readMap()
end

function gameState:update(dt)
	self.timer = self.timer + dt
	for i, v in pairs(self.enemyList) do
		v:update(dt)
	end
	
	if (self.spawnList[self.spawnIndex] and self.timer >= self.spawnList[self.spawnIndex].time) then
		table.insert(self.enemyList, Enemy:new(self.spawnList[self.spawnIndex].path))
		self.spawnIndex = self.spawnIndex + 1
	end
end

function gameState:draw()
	love.graphics.print(self.timer, 16, 16)
	for i, v in pairs(self.enemyList) do
		v:draw()
	end
end

function gameState:keypressed(key)
	if (key == "p") then
		state:pauseToggle()
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
				local coord = Vector(string.match(input, "%s*(%w+)%s*,%s*(%w*)"))		-- read coordinates of the parameter
				table.insert(parmList, coord)
			end
			
			-- add the new path segment to the path
			if(segTime ~= '') then
				newPath:addFrame(segmentType, tonumber(segTime), unpack(parmList))
			else
				newPath:addFrame(segmentType, unpack(parmList))
			end
		end
		
		table.insert(self.spawnList, {['time'] = tonumber(spawnTime), ['path'] = newPath, ['type'] = enemyType})
		
		nextEnemy = io.read()
	until(not nextEnemy)
end

state:add("game", gameState)