math.clamp = function(value, min, max)
	if (min > max) then
		min, max = max, min
	end
	return math.min(max, math.max(min, value))
end