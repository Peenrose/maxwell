function quad_locate(x, y)
	rx = math.ceil((x/_x)*32)
	ry = math.ceil((y/_y)*18)

	return rx, ry
end

function new_rand(type)
	if (type == nil) then return nil
		elseif (type == "x") then return math.random(5, love.graphics.getWidth()-5)
		elseif (type == "y") then return math.random(5, love.graphics.getHeight()-5)
		elseif (type == "v") then return math.random(-1000, 1000) / 15 
	end
end

function distance(p1, p2)
	dist = dist + 1
	return math.sqrt( (p1.pos.x - p2.pos.x)^2 + (p1.pos.y - p2.pos.y)^2 )
end