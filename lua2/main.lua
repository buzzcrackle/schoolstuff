physics = require("physics")

physics.start()

local building = {}

for i=1, 25 do

	local q = math.random(0, 320)
	local w = 520
	local e = math.random(10, 25)
	local r = math.random(30, 80)
end

local build = display.newRect(160, 400, 100, 247.5)
local box = display.newRect(0, 240, 0, 480)
local box2 = display.newRect(320, 240, 0, 480)
local ground = display.newRect(160, 530, 320, 0)
local boomboom = display.newImage("boomboom.png", 160, -100)
	--boomboom:scale(0.01, 0.01)
	boomboom.rotation = 180

physics.addBody(boomboom, {density=0.5, friction=0.5, bounce=0.0000001})
physics.addBody(box, "static")
physics.addBody(box2, "static")
physics.addBody(ground, "static")
physics.addBody(build, "static")

function saem(img, scale, delay)
	transition.scaleTo(img, { xScale = scale, yScale = scale, time = delay})
end

function boom(v1, v2)
	display.remove(boomboom)
	transition.fadeOut(v1, {time=4000})
	transition.fadeOut(v2, {time=4000})
	for i=1, table.maxn(building) do
		
	end
end

function apocalypse()
	local x, y = boomboom:localToContent(0,0)

	local c1 = display.newCircle(x,y, 10)
	local c2 = display.newCircle(x,y, 9)
		c2:setFillColor(0.9,0.4,0)
	saem(c1, 100, 800)
	saem(c2, 100, 800)

	for i=1, 50 do
		timer.performWithDelay(math.random(0, 10000), boom(c1, c2))
	end
end

timer.performWithDelay(5000, apocalypse)