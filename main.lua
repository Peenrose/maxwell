-- Maxwell's Daemon Simulation

function love.load()
	love.window.setMode(1280, 720, {
		fullscreen=false, 
		centered=true, 
		resizable=false
	})

end

function love.draw()
	-- draw walls
	-- draw seperator
	-- draw transfer gate
	-- draw particles
	-- particle trails?
end

function love.update()

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