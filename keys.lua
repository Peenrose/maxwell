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