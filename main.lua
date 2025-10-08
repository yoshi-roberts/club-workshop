local font = love.graphics.newFont("assets/Bonus/kenvector_future.ttf")

local player = require("player")
local bullet = require("bullet")
local spawner = require("spawner")
local enemy = require("enemy")
local background = require("background")

GameState = {
	score = 0,
	bullets = {},
	enemies = {},
}

function love.load()
	love.window.setMode(540, 960)
	love.graphics.setFont(font)

	background.init()
	player.init()
end

function love.update(dt)
	player.update(dt)
	enemy.update(dt)
	bullet.update(dt)
	spawner.update()
end

function love.draw()
	background.draw()

	player.draw()
	bullet.draw()
	enemy.draw()

	love.graphics.print("Score: " .. GameState.score .. " HP: " .. player.health, 0, 0, 0, 2, 2)
end
