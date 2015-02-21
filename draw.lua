function love.draw()
	dt = last_delta

	love.graphics.reset()

	for i = 1, #particles do
		if (particles[i] ~= nil) then
			--love.graphics.point(particles[i].pos.x, particles[i].pos.y)
			love.graphics.circle("fill", particles[i].pos.x, particles[i].pos.y, particle_size, 5)
		end
	end
	
	drawGrid()

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

function drawGrid()
	love.graphics.setColor(255,255,255,25)

	for i = 1, _x/32 do
		love.graphics.line(0, (_x/32)*i, _x, (_x/32)*i)
	end

	for i = 1, _y/18 do
		love.graphics.line((_y/18)*i, 0, (_y/18)*i, _y)
	end
end