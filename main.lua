local background_sprite = love.graphics.newImage("assets/Backgrounds/purple.png")

local zap_sfx = love.audio.newSource("assets/Bonus/sfx_zap.ogg", "static")

local font = love.graphics.newFont("assets/Bonus/kenvector_future.ttf")

local player = require("player")
local spawner = require("spawner")

local score = 0

local background_quad
local background_y = 0

local bullets = {}

local function new_bullet(x, y)
	table.insert(bullets, {
		x = x,
		y = y,
	})
end

local enemies_killed = 0
local enemies = {}

local spawn_rate = 600
local spawn_timer = 0

function love.load()
	love.window.setMode(540, 960)
	love.graphics.setFont(font)

	background_sprite:setWrap("repeat", "repeat")
	background_quad = love.graphics.newQuad(
		0,
		0,
		love.graphics.getWidth(),
		love.graphics.getHeight(),
		background_sprite:getWidth(),
		background_sprite:getHeight()
	)

	player.y = love.graphics.getHeight() - player.sprite:getHeight()
	player.x = (love.graphics.getWidth() / 2) - (player.sprite:getWidth() / 2)
end

function love.update(dt)
	player.update(dt)

	for k, enemy in pairs(enemies) do
		enemy.y = enemy.y + (enemy.speed * dt)

		for i, bullet in pairs(bullets) do
			if bullet.x >= enemy.x and bullet.x + bullet_sprite:getWidth() <= enemy.x + enemy.sprite:getWidth() then
				if
					bullet.y >= enemy.y
					and bullet.y + bullet_sprite:getHeight() <= enemy.y + enemy.sprite:getHeight()
				then
					enemy.health = enemy.health - 10
					table.remove(bullets, i)
				end
			end
		end

		if enemy.health <= 0 then
			score = score + enemy.points
			enemies_killed = enemies_killed + 1
			local sfx = zap_sfx:clone()
			love.audio.play(sfx)
			table.remove(enemies, k)
		end

		if enemy.y >= love.graphics.getHeight() then
			player.health = player.health - 10
			table.remove(enemies, k)
		end
	end

	for k, bullet in pairs(bullets) do
		bullet.y = bullet.y - (800 * dt)

		if bullet.y < 0 - bullet_sprite:getHeight() then
			table.remove(bullets, k)
		end
	end

	spawner.update(enemies)
end

function love.draw()
	background_y = background_y - 1

	background_quad:setViewport(0, background_y, love.graphics.getWidth(), love.graphics.getHeight())
	-- love.graphics.draw(background, quad, 0, 0, 0)
	love.graphics.draw(background_sprite, background_quad)

	love.graphics.draw(player.sprite, player.x, player.y)

	for k, enemy in pairs(enemies) do
		love.graphics.draw(enemy.sprite, enemy.x, enemy.y)
	end

	for k, bullet in pairs(bullets) do
		love.graphics.draw(bullet_sprite, bullet.x, bullet.y)
	end

	love.graphics.print("Score: " .. score .. " HP: " .. player.health, 0, 0, 0, 2, 2)
end
