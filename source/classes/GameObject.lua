GameObject = newclass("GameObject")

function GameObject:init(id, parent, position, sprite)
	self.id = id
	self.parent = parent
	self.position = position or Vector(0, 0)
	self.sprite = sprite
	self.offset = Vector(self.sprite:getWidth()/2, self.sprite:getHeight()/2)
end

function GameObject:destroy()
	parent:removeGameObject(id)
end

function GameObject:update(dt)
end
GameObject:virtual("update")


function GameObject:draw()
	love.graphics.draw(self.sprite, self.position.x, self.position.y, 0, 1, 1, self.offset.x, self.offset.y)
end
GameObject:virtual("update")