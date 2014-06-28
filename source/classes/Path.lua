Path = class:new()

function Path:init(data)
	self.data = data or {}
	self.current = 1
end

function Path:addFrame(type, a, b, c)
	local frame = {['type'] = type}

	if (type == 'linear') then
		frame.x = a
		frame.y = b
		frame.time = c
	elseif (type == 'start') then
		frame.x = a
		frame.y = b
	end

	table.insert(self.data, frame)
end

function Path:getCurrent()
	return self.data[self.current]
end

function Path:getPosition(dt)
	local current = self:getCurrent()
	local previous = self.data[self.current-1]

	if (current == linear) then
		
	end
end

function Path:printFrames()
	print("Printing Path:")
	for i, v in pairs(self.data) do
		for j, k in pairs(v) do
			print(j .. ' = ' .. k .. '\t')
		end
	end
	print("\n")
end
