bullet = {}

bullet.sprite = love.graphics.newImage("assets/PNG/Lasers/laserBlue04.png")
bullet.sfx = love.audio.newSource("assets/Bonus/sfx_laser1.ogg", "static")

function bullet.new(x, y)
	table.insert(GameState.bullets, {
		x = x,
		y = y,
	})

	local sfx = bullet.sfx:clone()
	love.audio.play(sfx)
end

function bullet.update(dt)
	for k, b in pairs(GameState.bullets) do
		b.y = b.y - (800 * dt)

		if b.y < 0 - bullet.sprite:getHeight() then
			table.remove(GameState.bullets, k)
		end
	end
end

function bullet.draw()
	for k, b in pairs(GameState.bullets) do
		love.graphics.draw(bullet.sprite, b.x, b.y)
	end
end

return bullet
