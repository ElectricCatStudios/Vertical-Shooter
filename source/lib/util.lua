math.clamp = function(value, min, max)
	if (min > max) then
		min, max = max, min
	end
	return math.min(max, math.max(min, value))
end

function roundTo(number, interval, method)
	if method == 'up' then
		return interval*(math.ceil(number/interval))
	elseif method == 'down' then
		return interval*(math.floor(number/interval))
	elseif method == 'nearest' then
		local roundedUp = (roundTo(number, interval, 'up'))
		local roundedDown = (roundTo(number, interval, 'down'))
		if math.abs(roundedUp - number) <= math.abs(roundedDown - number) then
			return roundedUp
		else
			return roundedDown
		end
	end
end