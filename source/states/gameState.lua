local gameState = {}

function gameState:init(lvl)
	self.timer = 0
	
	self.lvldata = io.open(lvl, 'r')
	self:readMap()
end

function gameState:update(dt)
	self.timer = self.timer + dt
	self.newEnemy:update(dt)
end

function gameState:draw()
	love.graphics.print(self.timer, 16, 16)
	self.newEnemy:draw()
end

function gameState:keypressed(key)
	if (key == "p") then
		state:pauseToggle()
	end
end

function gameState:readMap()
	io.input(self.lvldata)
	local input = io.read()
	
	local enemyType, pathSegments = string.match(input, "(%w+)%s*,%s*(%w*)")		-- read enemy type and the number of path segments
	
	local newPath = Path:new()														-- the new path we are going to create
	
	-- loop through all path segments
	for i=1,pathSegments do
		input = io.read()
		local segmentType, parmNo, segTime = 
			string.match(input, "%s*(%w+)%s*,%s*(%w+)%s*,*%s*(%w*)")				-- read the segment type and the number of parameters it takes
		local parmList = {}															-- the list of parms that this segment requiers
		
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
	
	newPath:printFrames()
	self.newEnemy = Enemy:new(newPath)
end

state:add("game", gameState)