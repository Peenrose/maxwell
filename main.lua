-- Maxwell's Daemon Simulation

particle_count = 1000
particle_size = 2

time_warp = 1

particles = {}

_x = 1280
_y = 720

require "draw"

require "load"

require "keys"


function newRand(type)
	if (type == nil) then return nil
		elseif (type == "x") then return math.random(5, love.graphics.getWidth()-5)
		elseif (type == "y") then return math.random(5, love.graphics.getHeight()-5)
		elseif (type == "v") then return math.random(-1000, 1000) / 15 
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