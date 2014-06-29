Path = class:new()

function Path:init(data)
	self.data = data or {}
	self.current = 1
	self.time = 0
	self.position = Vector()
end

function Path:addFrame(type, a, b)
	local frame = {['type'] = type}

	if (type == 'linear') then
		frame.position = a
		frame.time = b
	elseif (type == 'start') then
		frame.position = a
		self.position = a
		frame.time = 0
	end

	table.insert(self.data, frame)
end

function Path:getCurrent()
	return self.data[self.current]
end

function Path:update(dt)
	local current = self:getCurrent()
	local previous = self.data[self.current-1]

	if (current.type ~= 'end') then
		self.time = self.time + dt

		if (self.time >= current.time) then
			self.current = self.current + 1
			current = self:getCurrent()
			current = self:getCurrent()
			previous = self.data[self.current-1]
		end

		if (current.type == 'linear') then
			local keyTime = self.time - previous.time				-- How for into the current keyFrame
			local keyLength = current.time - previous.time			-- How long the current keyFrame is
			local dp = (keyTime/keyLength) * (current.position - previous.position)
			self.position = previous.position + dp
		end
	end
end

function Path:printFrames()
	print("Printing Path:")
	for i, v in pairs(self.data) do
		for j, k in pairs(v) do
			print(j .. ' = ' .. tostring(k) .. '\t')
		end
	end
	print("\n")
end
