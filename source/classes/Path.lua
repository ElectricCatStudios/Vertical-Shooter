Path = class:new()

function Path:init(data)
	self.data = data or {}
end

function Path:addFrame(x,y)
	table.insert(self.data, {['x'] = x,['y'] = y})
end

function Path:printFrames()
	print("Printing Path:")
	for i, v in pairs(self.data) do
		print(v.x .. ", " .. v.y)
	end
	print("\n")
end
