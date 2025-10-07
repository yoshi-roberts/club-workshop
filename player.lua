local bullet_sprite = love.graphics.newImage("assets/PNG/Lasers/laserBlue04.png")
local bullet_sfx = love.audio.newSource("assets/Bonus/sfx_laser1.ogg", "static")

local player = {
	x = 0,
	y = 0,
	speed = 600,
	health = 100,
	sprite = love.graphics.newImage("assets/PNG/playerShip2_blue.png"),
}

function player.update(dt)
	if love.keyboard.isDown("a") then
		if player.x > 0 then
			player.x = player.x - (player.speed * dt)
		end
	end

	if love.keyboard.isDown("d") then
		if player.x < love.graphics.getWidth() - player.sprite:getWidth() then
			player.x = player.x + (player.speed * dt)
		end
	end
end

function love.keypressed(key)
	if key == "space" then
		local sfx = bullet_sfx:clone()
		love.audio.play(sfx)
		local bx = (player.x + (player.sprite:getWidth() / 2)) - (bullet_sprite:getWidth() / 2)
		new_bullet(bx, player.y)
	end
end

return player
