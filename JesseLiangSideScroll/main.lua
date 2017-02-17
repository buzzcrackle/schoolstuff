physics = require("physics")

local b = display.newRect(240, 160, 600, 500)
	b:setFillColor(1, 1, 1)
local b1 = display.newImage("city.png", 240, 250)
	b1:scale(0.5, 0.5)
local b2 = display.newImage("city.png", 1410, 250)
	b2:scale(0.5, 0.5)

function update()

	b1.x = b1.x - 10
	b2.x = b2.x - 10

	if b1.x < -800 then
		b1.x = 1416
	end
	if b2.x < -800 then
		b2.x = 1416
	end

end

timer.performWithDelay(1, update, -1)