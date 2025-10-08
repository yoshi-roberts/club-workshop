local bullet = require("bullet")

local player = {
	x = 0,
	y = 0,
	speed = 600,
	health = 100,
	sprite = love.graphics.newImage("assets/PNG/playerShip2_blue.png"),
}

function player.init()
	player.y = love.graphics.getHeight() - player.sprite:getHeight()
	player.x = (love.graphics.getWidth() / 2) - (player.sprite:getWidth() / 2)
end

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
		local bx = (player.x + (player.sprite:getWidth() / 2)) - (bullet.sprite:getWidth() / 2)
		bullet.new(bx, player.y)
	end
end

function player.draw()
	love.graphics.draw(player.sprite, player.x, player.y)
end

return player
