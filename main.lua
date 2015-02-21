-- Maxwell's Daemon Simulation

require "draw"

require "load"

require "keys"

require "util"

collision_check_quads = {}
function reset_collision_quads()
	for i = 1, #particles do collision_check_quads[i] = {} end
end
reset_collision_quads()


function check_collisions()

	for i = 1, #particles do
		qx, qy = quad_locate(p.pos.x, p.pos.y)

		-- check that they exist

		collision_check_quads = {qx, qy}
	end
	--[[ 
	reverse list to find all particles in each quad

	for each particle
		check all particles that are in it's collision quads

		if collision
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

	--check_collisions()
end



shaded_next_frame = {}
function reset_shaded_queue()
	for i = 1, 32 do
		shaded_next_frame[i] = {}
		for k = 1, 18 do
			shaded_next_frame[i][k] = false
		end
	end
end
reset_shaded_queue()

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