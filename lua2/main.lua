physics = require("physics")

physics.start()

local buildings = {}

for i=1, 25 do

	local q = math.random(0, 320)
	local w = 520
	local e = math.random(10, 25)
	local r = math.random(30, 80)

	buildings[i] = display.newRect(q, w, e, r)
	physics.addBody(buildings[i], "static")
end

local box = display.newRect(0, 240, 0, 480)
local box2 = display.newRect(320, 240, 0, 480)
local ground = display.newRect(160, 530, 320, 0)
local boomboom = display.newImage("boomboom.png", 160, 0)
	--boomboom:scale(0.01, 0.01)
	boomboom.rotation = 180
	--ground:scale(0.5, 0.5)

physics.addBody(boomboom, {density=0.5, friction=0.5, bounce=0.0000001})
physics.addBody(box, "static")
physics.addBody(box2, "static")
physics.addBody(ground, "static")

function saem(img, scale, delay)
	transition.scaleTo(img, { xScale = scale, yScale = scale, time = delay})
end

function boom()
	x = math.random(0, 320)
	y = math.random(0, 480)
	z = math.random(10, 25)
	local c1 = display.newCircle(x,y, 10)
	local c2 = display.newCircle(x,y, 9)
	c2:setFillColor(0.9,0.4,0)
	saem(c1, z, 800)
	saem(c2, z, 800)
end

function apocalypse()
	for i=0, 50 do
		timer.performWithDelay(math.random(0, 10000), boom)
	end
end

timer.performWithDelay(5000, apocalypse)