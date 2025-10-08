local enemy = require("enemy")

local spawner = {
	rate = 600,
	timer = 0,
	spawned = 0,
}

love.math.setRandomSeed(love.timer.getTime())

function spawner.update()
	spawner.timer = spawner.timer + 1

	if spawner.timer >= spawner.rate then
		spawner.timer = 0

		local types = {
			"red",
			"blue",
			"black",
		}

		local type = 1

		if spawner.spawned >= 35 then
			spawner.rate = 240
			type = love.math.random(2, 3)
		elseif spawner.spawned >= 25 then
			spawner.rate = 360
			type = love.math.random(1, 3)
		elseif spawner.spawned >= 10 then
			spawner.rate = 480
			type = love.math.random(1, 2)
		end

		enemy.new(types[type])
		spawner.spawned = spawner.spawned + 1
	end
end

return spawner
