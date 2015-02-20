-- Maxwell's Daemon Simulation

particle_count = 1000
particle_size = 2

time_warp = 1

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
		elseif (type == "v") then return math.random(-1000, 1000) / 15 
	end
end

function love.load()
	love.window.setMode(1280, 720, {
		fullscreen=false, 
		centered=true, 
		resizable=false
	})
	love.window.setTitle("Maxwell Particle Simulation")

	for i = 1, particle_count do
		particles[i] = {
			pos = { x = newRand("x"), y = newRand("y") },
			vel = { x = newRand("v"), y = newRand("v") }
		}
	end
end

dist = 0
function distance(p1, p2)
	dist = dist + 1
	return math.sqrt( (p1.pos.x - p2.pos.x)^2 + (p1.pos.y - p2.pos.y)^2 )
end

function checkCollisions()
	-- split into grid
	-- only check particles in grid

	--[[ 
	for i = 1, #particles do
		p2 = particles[i]

		if (p1 ~= p2) then
			if (distance(p1, p2) < particle_size) then
				_p1 = p1; _p2 = p2

				p1.vel.x = _p2.vel.x
				p1.vel.y = _p2.vel.y
				p2.vel.x = _p1.vel.x
				p2.vel.y = _p1.vel.y
			end
		end
	end 
	--]]
end

last_delta = 0
function love.update(dt)
	last_delta = dt

	dt = dt * time_warp

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

		pc.pos.x = pc.pos.x + (pc.vel.x*dt)
		pc.pos.y = pc.pos.y + (pc.vel.y*dt)
	end

	checkCollisions()
end

function quad_locate(x, y)
	rx = math.ceil((x/_x)*32)
	ry = math.ceil((y/_y)*18)

	return rx, ry
end

shaded_next_frame = {}
function resetShadedQueue()
	for i = 1, 32 do
		shaded_next_frame[i] = {}
		for k = 1, 18 do
			shaded_next_frame[i][k] = false
		end
	end
end
resetShadedQueue()

function schedule_shade(qx, qy)
	if qx < 1 then return end
	if qy < 1 then return end

	if qx > 32 then return end
	if qy > 18 then return end
	
	shaded_next_frame[qx][qy] = true
end

function shade_quad(qx, qy)
	love.graphics.rectangle("fill", (_x/32)*(qx-1), (_y/18)*(qy-1), (_x/32), (_y/18))
end

function love.draw()
	dt = last_delta

	love.graphics.reset()

	for i = 1, #particles do
		if (particles[i] ~= nil) then
			--love.graphics.point(particles[i].pos.x, particles[i].pos.y)
			love.graphics.circle("fill", particles[i].pos.x, particles[i].pos.y, particle_size, 5)
		end
	end
	
	love.graphics.setColor(255,255,255,25)

	for i = 1, _x/32 do
		love.graphics.line(0, (_x/32)*i, _x, (_x/32)*i)
	end

	for i = 1, _y/18 do
		love.graphics.line((_y/18)*i, 0, (_y/18)*i, _y)
	end

	for i = 1, #particles do
		p = particles[i]

		if (i%100==0) then
			love.graphics.setColor(0,255,0,100)
			love.graphics.line(p.pos.x, p.pos.y, p.pos.x+p.vel.x, p.pos.y+p.vel.y)

			love.graphics.setColor(0,0,100,100)

			for i = 1, 25 do
				schedule_shade(quad_locate(p.pos.x+(p.vel.x*(1/i)), p.pos.y+(p.vel.y*(1/i))))
			end
		end
	end

	for i = 1, 32 do
		for k = 1, 18 do
			if (shaded_next_frame[i][k] == true) then
				shade_quad(i, k)
			end
		end
	end
	resetShadedQueue()
	--[[
	love.graphics.setColor(255,0,0,100)

	for i = 1, #particles do
		p = particles[i]
		love.graphics.line(p.pos.x, p.pos.y, p.pos.x-(p.vel.x/5), p.pos.y-(p.vel.y/5))
	end]]--
end

key_event = {}

key_event["escape"] = function() 
	love.event.push("quit")
end

key_event["left"]   = function()
	time_warp = time_warp * 0.9
end

key_event["right"]  = function()
	time_warp = time_warp * 1.1
end

key_event["1"] = function()
	error(dist)
end

function love.keypressed(key)
	if key_event[key] ~= nil then
		key_event[key]()
	end
end