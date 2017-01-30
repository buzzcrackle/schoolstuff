local cpu = display.newImage("amd.png", 70, 50)
	cpu:scale(0.25, 0.25)
local str8fire = display.newImage("fire.png", 200, 200)
	str8fire:scale(0.4, 0.4)
local bbq = display.newImage("bbq.jpg", 250, 250)
	bbq:scale(0.25, 0.25)



local scale = function(img, scale, delay)
	transition.scaleTo(img, { xScale = scale, yScale = scale, time = delay})
end

local rotate = function(img, angle, delay)
	transition.to(img, {rotation = img.rotation-angle, time = delay})
end

local moveTo = function(img, x2, y2, delay)
	transition.moveTo(img, {x = x2, y = y2, time = delay})
end

local plus = function(x, y)
	local hor = display.newRect(x, y, 100, 20)
	local vert = display.newRect(x, y, 20, 100)
end

local begin = function()
	local arr = {cpu, str8fire, bbq}
	local count = table.maxn(arr)
	for i = 0, count do
		rotate(arr[i], 360, 2000)
	end
end


plus(150, 150)

begin()


