display.newImage("background.png", 160, 240)
local triangle = display.newImage("octohedron.png", 160, 240)
local options = {
   text = "",
   x = 160,
   y = 260,
   fontSize = 9,
   font = "Comic Sans MS",
   width = 50,
   height = 40,
   align = "center"
}

local textBox = display.newText( options )

for i=0, 5, 1 do
	local r = math.random(0, 100)
	local g = math.random(0, 100)
	local b = math.random(0, 100)
	local things = display.newText("Shake device to activate.", math.random(0, 320), math.random(0, 100), "Comic Sans MS", math.random(0, 25))
		things:setFillColor(r/100, g/100, b/100)
end

local ready = true

local array = {
	"It is certain", "It is decidedly so", 
	"Without a doubt","Yes definitely",
	"You may rely on it","As I see it, yes",
	"Most likely"," Outlook good",
	"Yes","Signs point to yes",
	"Reply hazy try again","Ask again later",
	"Better not tell you now","Cannot predict now",
	"Concentrate and ask again","Don't count on it",
	"My reply is no","My sources say no",
	"Outlook not so good","Very doubtful"
}

local rotate = function(img, angle, delay)
	transition.to(img, {rotation = img.rotation-angle, time = delay})
end

function count(x)
	local thing = table.maxn(x)
	return thing
end

function triggered()
	local rand = math.random(1, count(array))
	local stuff = array[rand]
	textBox.text = stuff
	ready = true
end

function saem()
	textBox.text = ""
	if ready == true then
		rotate(triangle, 360, 1000)
		timer.performWithDelay( 1000, triggered)
		ready = false
	end
end

Runtime:addEventListener( "accelerometer", saem)