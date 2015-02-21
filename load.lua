particle_count = 1000
particle_size = 2

time_warp = 1

_x = 1280
_y = 720

particles = {}
function love.load()
	love.window.setMode(_x, _y, {
		fullscreen=false, 
		centered=true, 
		resizable=false
	})
	love.window.setTitle("Maxwell Particle Simulation")

	for i = 1, particle_count do
		particles[i] = {
			pos = { x = new_rand("x"), y = new_rand("y") },
			vel = { x = new_rand("v"), y = new_rand("v") }
		}
	end
end