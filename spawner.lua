local enemy_new = require("enemies")

local spawner = {
	rate = 600,
	timer = 0,
	spawned = 0,
}

function spawner.update(enemies)
	spawner.timer = spawner.timer + 1

	if spawner.timer >= spawner.rate then
		spawner.timer = 0

		local types = {
			"red",
			"blue",
			"black",
		}

		local type = 1

		if spawner.spawned >= 50 then
			spawner.rate = 240
			type = love.math.random(2, 3)
		elseif spawner.spawned >= 35 then
			spawner.rate = 360
			type = love.math.random(1, 3)
		elseif spawner.spawned >= 15 then
			spawner.rate = 480
			type = love.math.random(1, 2)
		end

		table.insert(enemies, enemy_new(types[type]))
	end
end

return spawner
