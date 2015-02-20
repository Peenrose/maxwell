-- Maxwell's Daemon Simulation

scale = 1000

particles = {}

_x = 1280
_y = 720

walls = {
	{ x = 0, y = 0, w = _x, h = 8 },
	{ x = 0, y = 0, w = 8, h =  _y },
	{ x = _x-8, y = 0, w = 8, h = _y },
	{ x = 0, y = _y-8, w = _x, h = 8 }--,

	--{ x = , y = , w = , h =  },
	--{ x = , y = , w = , h =  }
}

function newRand(type)
	if (type == nil) then return nil
		elseif (type == "x") then return  math.random(5, love.graphics.getWidth()-5)
		elseif (type == "y") then return  math.random(5, love.graphics.getHeight()-5)
		elseif (type == "v") then return math.random(-1000, 1000) / 750 
	end
end

function love.load()
	love.window.setMode(1280, 720, {
		fullscreen=false, 
		centered=true, 
		resizable=false
	})
	love.window.setTitle("Maxwell Particle Simulation")

	for i = 1, scale do
		particles[i] = {
			pos = { x = newRand("x"), y = newRand("y") },
			vel = { x = newRand("v"), y = newRand("v") }
		}
	end
end

function love.update()
	for i = 1, #particles do
		pc = particles[i]

		oldx = pc.pos.x
		oldy = pc.pos.y

		for i = 1, #walls do
			if pc.pos.x < 0 then
				pc.pos.x = 0
				pc.vel.x = -pc.vel.x
			end

			if pc.pos.x > _x then
				pc.pos.x = _x
				pc.vel.x = -pc.vel.x
			end

			if pc.pos.y < 0 then
				pc.pos.y = 0
				pc.vel.y = -pc.vel.y
			end

			if pc.pos.y > _y then
				pc.pos.y = _y
				pc.vel.y = -pc.vel.y
			end
		end

		pc.pos.x = pc.pos.x + pc.vel.x
		pc.pos.y = pc.pos.y + pc.vel.y
	end
end

function love.draw()
	-- draw walls
	-- draw seperator
	-- draw transfer gate

	for i = 1, #particles do
		if (particles[i] ~= nil) then
			--love.graphics.point(particles[i].pos.x, particles[i].pos.y)
			love.graphics.circle("fill", particles[i].pos.x, particles[i].pos.y, 1.5, 5)
		end
	end
	-- particle trails?
end

key_event = {}
key_event["escape"] = function()
	love.event.push("quit")
end

function love.keypressed(key)
	if key_event[key] ~= nil then
		key_event[key]()
	end
end