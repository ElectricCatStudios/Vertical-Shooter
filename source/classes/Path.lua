Path = class:new()

function Path:init(data)
	self.data = data or {}
	self.current = 1
	self.time = 0
	self.position = Vector()
end

function Path:addFrame(type, a, b, c)
	local frame = {['type'] = type}

	if (type == 'start') then
		frame.pf = a
		self.position = a
		frame.time = 0
	elseif (type == 'end') then
		frame.time = math.huge
	elseif (type == 'linear') then
		frame.pf = a
		frame.time = b
	elseif (type == 'bezier2') then		-- 2nd order bezier curve
		frame.time = a
		frame.p0 = self.data[table.getn(self.data)].pf
		frame.p1 = b
		frame.pf = c
	end

	table.insert(self.data, frame)
end

function Path:getCurrent()
	return self.data[self.current]
end

function Path:update(dt)
	local current = self:getCurrent()
	local previous = self.data[self.current-1]

	self.time = self.time + dt

	if (self.time >= current.time) then
		self.current = self.current + 1
		current = self:getCurrent()
		current = self:getCurrent()
		previous = self.data[self.current-1]
	end

	if (current.type ~= 'end') then
		local keyTime = self.time - previous.time				-- How far into the current keyFrame
		local keyLength = current.time - previous.time			-- How long the current keyFrame is
		local t = keyTime/keyLength								-- How far into the current keyFrame as a normalized value

		if (current.type == 'linear') then
			local dp = (keyTime/keyLength) * (current.pf - previous.pf)
			self.position = previous.pf + dp
		elseif (current.type == 'bezier2') then
			self.position = (1-t)^2*previous.pf + 2*(1-t)*t*current.p1 + t^2*current.pf
		end
	end
end

function Path:printFrames()
	print("Printing Path:")
	for i, v in pairs(self.data) do
		for j, k in pairs(v) do
			print(j .. ' = ' .. tostring(k) .. '\t')
		end
		print()
	end
end
