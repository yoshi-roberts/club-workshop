local enemy_red_sprite = love.graphics.newImage("assets/PNG/Enemies/enemyRed5.png")
local enemy_blue_sprite = love.graphics.newImage("assets/PNG/Enemies/enemyBlue1.png")
local enemy_black_sprite = love.graphics.newImage("assets/PNG/Enemies/enemyBlack4.png")

local enemy_types = {
	["red"] = function()
		return {
			y = -128,
			x = love.math.random(0, love.graphics.getWidth() - enemy_red_sprite:getWidth()),
			speed = 300,
			health = 30,
			points = 10,
			sprite = enemy_red_sprite,
		}
	end,

	["blue"] = function()
		return {
			y = -128,
			x = love.math.random(0, love.graphics.getWidth() - enemy_red_sprite:getWidth()),
			speed = 700,
			health = 10,
			points = 30,
			sprite = enemy_blue_sprite,
		}
	end,

	["black"] = function()
		return {
			y = -128,
			x = love.math.random(0, love.graphics.getWidth() - enemy_red_sprite:getWidth()),
			speed = 200,
			health = 60,
			points = 45,
			sprite = enemy_black_sprite,
		}
	end,
}

local function enemy_new(type)
	local func = enemy_types[type]
	return func()
end

return enemy_new
