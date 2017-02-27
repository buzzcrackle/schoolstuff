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

--UNNECESSARY BUT COOL -----------------------------------

-- LAUNCH SCREEN -----------------------
function screen(x)

	if x == true then
		launch = display.newRect(240, 160, 600, 320)
			launch:setFillColor(0.8, 0.8, 0.8)
			launch.alpha = 0.7

		t1 = display.newText("Play Game", 240, 130, "Comic Sans MS", 100)
			t1:setFillColor(0,0,0)
		t2 = display.newText("Tap Screen to Start", 240, 220, "Comic Sans MS", 20)
			t2:setFillColor(0,0,0)
	else
		display.remove(launch)
		display.remove(t1)
		display.remove(t2)
	end

end
-- LAUNCH SCREEN -------------------------

screen(true)

local cact = display.newImage("cactus.png", 600, 300)
physics.addBody(cact, "static", {bounce = 0})

physics.addBody(ground, "static", {bounce = 0})


function update()

	if updatebool == true then
		bg(b1, 5, -239, 1160)
		bg(b2, 2, -525, 1160)

		cact.x = cact.x - 7

		if cact.x < -100 then
			cact.x = math.random(600, 800)
		end
	end

	if started == true and updatebool == false then
		print(dude.x)
		boom(dude.x, dude.y)

		
		started = false
	end

end


function boom(x, y)

	display.remove(dude)

	local c = {}
	local const = 100
	local speed = 0.01
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

		print(x2)

		c[i] = display.newCircle(x2, y2, 2)
		c[i]:setFillColor(0.8, 0, 0)
		physics.addBody(c[i], {radius=2, density=0.5, friction=0.5, bounce=0.7})
		c[i]:applyLinearImpulse(x3, y3, c[i].x, c[i].y)
	end

end

timer.performWithDelay(1, update, -1)

function tap()

	if started == false then
		started = true
	end

	if updatebool == false then
		screen(false)

		updatebool = true
		dude:play()
	else
		if why == true then
		else
			why = true
			dude:applyLinearImpulse(0, -120, dude.x, dude.y)
		end
	end
end


local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
        collide = true
 
    elseif ( event.phase == "ended" ) then
        why = false
    end
end

local function cactcol( self, event )
    if ( event.phase == "began" ) then
        updatebool = false
    elseif ( event.phase == "ended" ) then
    end
end

dude.collision = onLocalCollision
dude:addEventListener("collision")

cact.collision = cactcol
cact:addEventListener("collision")

Runtime:addEventListener("tap", tap)