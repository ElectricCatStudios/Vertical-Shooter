Path = class:new()

function Path:init(data)
	self.data = data or {}
end

function Path:addFrame(type, a, b)
	local frame = {['type'] = type}

	if (type == 'linear') then
		frame.x = a
		frame.y = b
	end

	table.insert(self.data, frame)
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
