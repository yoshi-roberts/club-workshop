local player = require("player")

local enemy = {}

enemy.red_sprite = love.graphics.newImage("assets/PNG/Enemies/enemyRed5.png")
enemy.blue_sprite = love.graphics.newImage("assets/PNG/Enemies/enemyBlue1.png")
enemy.black_sprite = love.graphics.newImage("assets/PNG/Enemies/enemyBlack4.png")
enemy.death_sfx = love.audio.newSource("assets/Bonus/sfx_zap.ogg", "static")

enemy.types = {
	["red"] = function()
		return {
			y = -128,
			x = love.math.random(0, love.graphics.getWidth() - enemy.red_sprite:getWidth()),
			speed = 300,
			health = 30,
			points = 10,
			sprite = enemy.red_sprite,
		}
	end,

	["blue"] = function()
		return {
			y = -128,
			x = love.math.random(0, love.graphics.getWidth() - enemy.blue_sprite:getWidth()),
			speed = 700,
			health = 10,
			points = 30,
			sprite = enemy.blue_sprite,
		}
	end,

	["black"] = function()
		return {
			y = -128,
			x = love.math.random(0, love.graphics.getWidth() - enemy.black_sprite:getWidth()),
			speed = 200,
			health = 60,
			points = 45,
			sprite = enemy.black_sprite,
		}
	end,
}

function enemy.new(type)
	local func = enemy.types[type]
	table.insert(GameState.enemies, func())
end

function enemy.update(dt)
	for k, e in pairs(GameState.enemies) do
		e.y = e.y + (e.speed * dt)

		for i, b in pairs(GameState.bullets) do
			if b.x >= e.x and b.x + bullet.sprite:getWidth() <= e.x + e.sprite:getWidth() then
				if b.y >= e.y and b.y + bullet.sprite:getHeight() <= e.y + e.sprite:getHeight() then
					e.health = e.health - 10
					table.remove(GameState.bullets, i)
				end
			end
		end

		if e.health <= 0 then
			GameState.score = GameState.score + e.points
			local sfx = enemy.death_sfx:clone()
			love.audio.play(sfx)
			table.remove(GameState.enemies, k)
		end

		if e.y >= love.graphics.getHeight() then
			player.health = player.health - 10
			table.remove(GameState.enemies, k)
		end
	end
end

function enemy.draw()
	for k, e in pairs(GameState.enemies) do
		love.graphics.draw(e.sprite, e.x, e.y)
	end
end

return enemy
