particle_count = 1000
particle_size = 2

time_warp = 1

particles = {}

_x = 1280
_y = 720

function love.load()
	love.window.setMode(_x, _y, {
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
