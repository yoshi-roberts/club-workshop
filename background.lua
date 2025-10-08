local background = {}

background.sprite = love.graphics.newImage("assets/Backgrounds/purple.png")
background.quad = nil
background.y = 0

function background.init()
	background.sprite:setWrap("repeat", "repeat")
	background.quad = love.graphics.newQuad(
		0,
		0,
		love.graphics.getWidth(),
		love.graphics.getHeight(),
		background.sprite:getWidth(),
		background.sprite:getHeight()
	)
end

function background.draw()
	background.y = background.y - 1

	background.quad:setViewport(0, background.y, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.draw(background.sprite, background.quad)
end

return background
