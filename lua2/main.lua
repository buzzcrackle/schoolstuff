local box = newRect(160, 0, 100, 100)

local scale = function(img, scale, delay)
	transition.scaleTo(img, { xScale = scale, yScale = scale, time = delay})
end

local rotate = function(img, angle, delay)
	transition.to(img, {rotation = img.rotation-angle, time = delay})
end

--To Move Objects
local moveTo = function(img, x2, y2, delay)
	transition.moveTo(img, {x = x2, y = y2, time = delay})
end

local plus = function(x, y)
	local hor = display.newRect(x, y, 100, 20)
	local vert = display.newRect(x, y, 20, 100)
end

local equal = function(x, y)
	local top = display.newRect(x, y, 100, 20)
	local bottom = display.newRect(x, y + 40, 100, 20)
end

for i=1, 1000, 1 do
	transition.moveTo(box, {x = 160, y = , time = delay})
end