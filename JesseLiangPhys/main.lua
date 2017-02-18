physics = require("physics")

physics.start()

local buildings = {}
display.newImage("sky.jpg", 160, 240)
local nk = display.newImage("nk.png", 160, 150)
nk:scale(0.05, 0.05)
local ha = display.newText("The Bomb", 160, 100, "Comic Sans MS", 30)
ha:setFillColor(0.9, 0.1, 0.1)

for i=1, 100 do

	local q = math.random(0, 320)
	local w = math.random(520, 550)
	local e = math.random(10, 25)
	local r = math.random(30, 90)

	local c1 = math.random(1, 10)
	local c2 = math.random(1, 10)
	local c3 = math.random(1, 10)

	buildings[i] = display.newRect(q, w, e, r)
	buildings[i]:setFillColor(0.5 + (c1/100), 0.5 + (c2/100), 0.5 + (c3/100))
	physics.addBody(buildings[i], "static")

end

--local build = display.newRect(160, 400, 100, 247.5)
local box = display.newRect(0, 240, 0, 480)
local box2 = display.newRect(320, 240, 0, 480)
local ground = display.newRect(160, 530, 320, 0)
local ceiling = display.newRect(160, -50, 320, 0)
local boomboom = display.newImage("boomboom.png", 160, -49)
	--boomboom:scale(0.01, 0.01)
	boomboom.rotation = 180

physics.addBody(boomboom, {radius=12, density=0.5, friction=0.5, bounce=0.5})
physics.addBody(box, "static")
physics.addBody(box2, "static")
physics.addBody(ground, "static")
physics.addBody(ceiling, "static")

function saem(img, scale, delay)
	transition.scaleTo(img, { xScale = scale, yScale = scale, time = delay})
end

function boom(v1, v2, x, y)
	display.remove(boomboom)

	local c = {}
	local const = 200
	local speed = 0.05
	local move = (speed * 2)/const

	local dis = 1
	local inc = (dis * 2)/const

	for i = 0, const do
		rand = math.random(0, const * 2)
		other = math.random(0, 1)

		x2b = (i * inc)
		x2 = x2b + (x - dis)
		x3 = (i * move) - speed

		if other == 0 then
			y3 = math.sqrt(math.pow(speed, 2) - math.pow(x3, 2))
			y2 = math.sqrt(math.pow(dis, 2) - math.pow(x2b - 1, 2)) + (y - dis)
		else
			y3 = -1 * math.sqrt(math.pow(speed, 2) - math.pow(x3, 2))
			y2 = -1 * math.sqrt(math.pow(dis, 2) - math.pow(x2b - 1, 2)) + (y - dis)
		end

		c[i] = display.newCircle(x2, y2, 2)
		c[i]:setFillColor(0.4, 0.6, 0.4)
		physics.addBody(c[i], {radius=2, density=0.5, friction=0.5, bounce=0.99})
		c[i]:applyLinearImpulse(x3, y3, c[i].x, c[i].y)
	end

	-- transition.fadeOut(v1, {time=4000})
	-- transition.fadeOut(v2, {time=4000})

end

function apocalypse()
	local x, y = boomboom:localToContent(0,0)

	-- local c1 = display.newCircle(x,y, 10)
	-- local c2 = display.newCircle(x,y, 9)
	-- 	c2:setFillColor(0.9,0.4,0)
	-- saem(c1, 100, 500)
	-- saem(c2, 100, 500)

	boom(c1, c2, x, y)

end

timer.performWithDelay(1300, apocalypse)