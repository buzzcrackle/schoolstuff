for i=0, 1000, 1 do
	local x = math.random(0, 320)
	local y = math.random(0, 480)
	local rand = math.random(0, 10)
	local back = display.newImage("background.jpg", x, y)
	back:scale(rand/3, rand/3)
	back.rotation = math.random(-30,30)
end

local cpu = display.newImage("amd.png", 70, 50)
	cpu:scale(0.25, 0.25)
local str8fire = display.newImage("fire.png", 260, 230)
	str8fire:scale(0.4, 0.4)
local bbq = display.newImage("bbq.jpg", 160, 440)
	bbq:scale(0.5, 0.5)
local text = display.newText("AMD", 50, 475, "Comic Sans MS", 30)

text:setFillColor(255, 0, 0)


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



plus(160, 150)
equal(160, 300)
rotate(cpu, 360, 2500)
rotate(str8fire, -360, 5000)
rotate(bbq, 360, 1000)
moveTo(text, 260, 5, 2000)