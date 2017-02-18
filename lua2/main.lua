physics = require("physics")

physics.start()

function saem(img, scale, delay)
	transition.scaleTo(img, { xScale = scale, yScale = scale, time = delay})
end

function boom(v1, v2, x, y)
	display.remove(boomboom)

	local c = {}
	local const = 100
	local inc = 1/const

	for i = 0, const do
		rand = math.random(0, const * 2)
		other = math.random(0, 1)

		x2 = (i * inc) + (x - 0.5)
		y2 = rand/const + (y - 0.5)

		x3 = (i * inc) - 0.5

		if other == 0 then
			y3 = math.sqrt(0.25 - math.pow(x3, 2))
		else
			y3 = -1 * math.sqrt(0.25 - math.pow(x3, 2))
		end

		c[i] = display.newCircle(x2, y2, 2)
		c[i]:setFillColor(0.4, 0.6, 0.4)
		physics.addBody(c[i], {radius=2, density=0.5, friction=0.5, bounce=0.99})
		c[i]:applyLinearImpulse(x3, y3, c[i].x, c[i].y)
	end

	transition.fadeOut(v1, {time=4000})
	transition.fadeOut(v2, {time=4000})

end

function apocalypse(x, y)

	local c1 = display.newCircle(x,y, 10)
	local c2 = display.newCircle(x,y, 9)
		c2:setFillColor(0.9,0.4,0)
	saem(c1, 100, 500)
	saem(c2, 100, 500)

	boom(c1, c2, x, y)

end

timer.performWithDelay(30000, apocalypse(160, 240))