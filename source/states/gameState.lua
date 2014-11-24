local gameState = {}

function gameState:init(lvl)
	self.timer = 0
	self.enemyList = {}
	self.spawnList = {}
	self.projectileList = {}
	self.spawnIndex = 1
	self.lvldata = io.open(lvl, 'r')
	self.background = spr_testBackground
	self.player = Player:new(self.projectileList)
	self.player:setPos(Vector(self.background:getWidth()/2, -32))
	self.player.weapon = Sprayer:new(self.player)
	self.camPos = -Vector(-(self.background:getWidth() - love.window.getWidth())/2, love.window.getHeight())
	self.projectileCount = 0
	self.levelSpeed = 50
	self.player.constSpeed = Vector.UP*(self.levelSpeed)
	self.borderWidth = 200
	table.insert(self.enemyList, self.player)
	print(self.player.position)
	
	self:readMap()
end

function gameState:update(dt)
	self.camPos = self.camPos - Vector.DOWN*self.levelSpeed*dt
	-- keep the camera in view
	local leftDis = self.player.position.x - self.camPos.x
	local rightDis = self.camPos.x + love.window.getWidth() - self.player.position.x
	if (leftDis < self.borderWidth) then
		self.camPos.x = self.player.position.x - self.borderWidth
	elseif (rightDis < self.borderWidth) then
		self.camPos.x = self.player.position.x + self.borderWidth - love.window.getWidth()
	end

	self.camPos.x = math.clamp(self.camPos.x, 0, self.background:getWidth() - love.window.getWidth())


	self.timer = self.timer + dt
	for i, v in pairs(self.enemyList) do
		v:update(dt)
	end
	for i, v in pairs(self.projectileList) do
		v:update(dt)
	end
	
	if (self.spawnList[self.spawnIndex] and self.timer >= self.spawnList[self.spawnIndex].time) then
		table.insert(self.enemyList, Enemy:new(self.spawnList[self.spawnIndex].path))
		self.spawnIndex = self.spawnIndex + 1
	end
end

function gameState:draw()
	love.graphics.translate(-self.camPos.x, -self.camPos.y)
	love.graphics.draw(self.background, 0, -self.background:getHeight())
	love.graphics.print(self.timer, 16, 16)
	for i, v in pairs(self.enemyList) do
		v:draw()
	end
	for i, v in pairs(self.projectileList) do
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

function gameState:addProjectile(projectile)
	local projectileCount = self.projectileCount

	self.projectileList[projectileCount] = projectile
	self.projectileCount = self.projectileCount + 1
	return projectileCount
end

state:add("game", gameState)