physics = require("physics")
physics.start()

local ground = display.newRect(240, 320, 600, 0)
local obg = display.newRect(240, 160, 600, 320)
	obg:setFillColor(0.7, 0.7, 0)

local b2 = {}
	b2[1] = display.newImage("b1.png", 200, 160)
	b2[2] = display.newImage("b1.png", 1160, 160)

local b1 = {}
	b1[1] = display.newImage("b2.png", 200, 160)
	b1[2] = display.newImage("b2.png", 680, 160)
	b1[3] = display.newImage("b2.png", 1160, 160)

local updatebool = false
local started = false
local why = false
local score = 0
local thing = false
local cactspeed = 7

local c = {}

local scoreboard = display.newText(score, 480, 30, "Comic Sans MS", 50)
	scoreboard:setFillColor(0,0,0)

-- BACKGROUND FUNCTION, VERY UNNECESSARY----------------------------

function bg(arr, speed, x1, x2)
	for i = 1, table.maxn(arr) do
		arr[i].x = arr[i].x - speed
		if arr[i].x < x1 then	
			arr[i].x = x2
		end
	end
end

--UNNECESSARY, WORKS, BUT COOL -----------------------------------

-- function cacti()

-- 	local new = display.newImage("cactus.png", 600, 300)
-- 	table.insert(cact, new)
-- 	physics.addBody(cact[table.maxn(cact)], "static")

-- 	local ran = math.random(3000, 6000)
-- 	timer.performWithDelay(ran, cacti)
-- 	print(ran)

-- end

-- LAUNCH SCREEN -----------------------

function screen(x, y)

	if x == true then
		launch = display.newRect(240, 160, 600, 320)
			launch:setFillColor(0.8, 0.8, 0.8)
			launch.alpha = 0.7
		if y == false then
			t1 = display.newText("Play Game", 240, 130, "Comic Sans MS", 100)
				t1:setFillColor(0,0,0)
			t2 = display.newText("Tap Screen to Start", 240, 220, "Comic Sans MS", 20)
				t2:setFillColor(0,0,0)
		else
			t1 = display.newText("Score: " .. score, 240, 130, "Comic Sans MS", 100)
				t1:setFillColor(0,0,0)
			t2 = display.newText("Tap Screen to Try Again", 240, 220, "Comic Sans MS", 20)
				t2:setFillColor(0,0,0)
		end
	else
		display.remove(launch)
		display.remove(t1)
		display.remove(t2)
	end

end

-- PHYSICS ----------------------------

local settings =
{
    width = 100,
    height = 100,
    numFrames = 7,
}


local sequenceData =
{
    {
	    name="walk",
	    start=1,
	    count=6,
	    time=500
	}, 
	{
	    name="jump",
	    start=7,
	    count=1,
	    loopCount = 1
	}, 

}

local sprite = graphics.newImageSheet("sprite.png", settings)
local dude = display.newSprite(sprite, sequenceData)
	dude.x = 100
	dude.y = 270
	physics.addBody(dude, {density=1, friction=1, bounce=0})
	

screen(true, false)

local cact = display.newImage("cactus.png", 600, 300)
physics.addBody(cact, "static", {bounce = 0})
physics.addBody(ground, "static", {bounce = 0})

-- UPDATE GAME----------------------------------

function update()

	if updatebool == true then
		bg(b1, 5, -239, 1160)
		bg(b2, 2, -525, 1160)

		cact.x = cact.x - cactspeed

		if cact.x < -100 then
			cact.x = math.random(600, 800)
			thing = false
		end

		if cact.x < 100 and thing == false then
			thing = true
			score = score + 1
			scoreboard.text = score
			cactspeed = cactspeed + 1
		end

		if dude.sequence == "jump" and dude.y > 269 then
			dude:setSequence("walk")
			dude:play()
		end
	end

	if started == true and updatebool == false then
		boom(dude.x, dude.y)
		screen(true, true)
		cactspeed = 7
		score = 0
		started = false
	end

end

timer.performWithDelay(1, update, -1)

-- BLOOD AND GORE ----------------------------------

function boom(x, y)

	dude.alpha = 0
	physics.removeBody(dude)

	local const = 100
	local speed = 0.01
	local move = (speed * 2)/const

	local dis = 1
	local inc = (dis * 2)/const

	for i = 1, const do
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
		c[i]:setFillColor(0.8, 0, 0)
		physics.addBody(c[i], {radius=2, density=0.5, friction=0.5, bounce=0.7})
		c[i]:applyLinearImpulse(x3, y3, c[i].x, c[i].y)
	end

end

-- CLEARS THE BLOOD AND GORE ---------------------------

function clearballs()
	
	for i=1, #c do
	    c[i]:removeSelf()
	end
end

-- SCREEN TAP -------------------------

function tap()

	if started == false then
		started = true
	end

	if updatebool == false then
		screen(false)
		scoreboard.text = score

		dude.x = 100
		dude.y = 270
		dude:play()
		dude.alpha = 1
		physics.addBody(dude, {density=1, friction=1, bounce=0})

		updatebool = true
		cact.x = math.random(600, 800)
		why = false
		clearballs()
	else
		if dude.sequence == "jump" then
		else
			dude:applyLinearImpulse(0, -120, dude.x, dude.y)
			dude:setSequence("jump")
		end
	end
end

Runtime:addEventListener("tap", tap)

-- COLLISION ------------------------

local function cactcol(self, event)
    if (event.phase == "began") then
        updatebool = false
        if why == false then
			dude:setSequence("walk")
			dude:play()
		end
    elseif (event.phase == "ended") then
    end
end

cact.collision = cactcol
cact:addEventListener("collision")
