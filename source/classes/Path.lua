Path = newclass("Path")

function Path:init(data)
	self.data = data or {}
	self.current = 1
	self.time = 0
	self.position = Vector()
end

function Path:addFrame(type, a, b, c, d)
	local frame = {['type'] = type}

	if (type == 'start') then
		frame.pf = a
		self.position = a
		frame.time = 0
	elseif (type == 'end') then
		frame.time = math.huge
	elseif (type == 'linear') then
		frame.p0 = self.data[table.getn(self.data)].pf
		frame.pf = b
		frame.time = a
	elseif (type == 'bezier2') then		-- 2nd order bezier curve
		frame.time = a
		frame.p0 = self.data[table.getn(self.data)].pf
		frame.p1 = b
		frame.pf = c
	elseif (type == 'bezier3') then		-- 3rd order bezier curve
		frame.time = a
		frame.p0 = self.data[table.getn(self.data)].pf
		frame.p1 = b
		frame.p2 = c
		frame.pf = d
	elseif (type == 'wait') then		-- wait for period of time
		frame.time = a
		frame.p0 = self.data[table.getn(self.data)].pf
		frame.pf = frame.p0
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
			self.position = (1-t)^2*current.p0 + 2*(1-t)*t*current.p1 + t^2*current.pf
		elseif (current.type == 'bezier3') then
			self.position = (1-t)^3*current.p0 + 3*(1-t)^2*t*current.p1 + 3*(1-t)*t^2*current.p2 + t^3*current.pf
		end
	end
end

function Path:draw()
	local current = self:getCurrent()

	if (current.type == 'bezier3') then
		love.graphics.circle("fill", current.p0.x, current.p0.y, 3)
		love.graphics.print("0", current.p0.x, current.p0.y )
		love.graphics.circle("fill", current.p1.x, current.p1.y, 3)
		love.graphics.print("1", current.p1.x, current.p1.y )
		love.graphics.circle("fill", current.p2.x, current.p2.y, 3)
		love.graphics.print("2", current.p2.x, current.p2.y )
		love.graphics.circle("fill", current.pf.x, current.pf.y, 3)
		love.graphics.print("3", current.pf.x, current.pf.y )
	elseif(current.type == 'bezier2') then
		love.graphics.circle("fill", current.p0.x, current.p0.y, 3)
		love.graphics.print("0", current.p0.x, current.p0.y )
		love.graphics.circle("fill", current.p1.x, current.p1.y, 3)
		love.graphics.print("1", current.p1.x, current.p1.y )
		love.graphics.circle("fill", current.pf.x, current.pf.y, 3)
		love.graphics.print("2", current.pf.x, current.pf.y )
	elseif(current.type == 'linear') then
		love.graphics.circle("fill", current.p0.x, current.p0.y, 3)
		love.graphics.print("0", current.p0.x, current.p0.y )
		love.graphics.circle("fill", current.pf.x, current.pf.y, 3)
		love.graphics.print("1", current.pf.x, current.pf.y )
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
