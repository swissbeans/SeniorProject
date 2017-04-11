--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Cursive Upper Case Scene
]]

local composer = require( "composer" )

local scene = composer.newScene()

--Global initial variables

display.setStatusBar(display.HiddenStatusBar)

local function gotoMenu()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end


local phoneWidth = 480
local phoneHeight = 320
local screenWidth = phoneWidth*.8
local screenHeight = phoneHeight*.8
local drawingGroup = display.newGroup();


local startX
local startY
local endX
local endY
local innerX
local innerY

local points ={}

local function drawPoint(x1,y1)
	--print(x1,y1)
	local point = display.newRoundedRect(drawingGroup, x1, y1, 10, 6, 2)
	point:setFillColor(0,0,0)   
	--local save = display.save(drawingGroup, { filename="currentLetter.png", baseDir=system.DocumentsDirectory, captureOffscreenArea=false, backgroundColor={0,0,0,0} } )
    table.insert(points, point)
end

local function onObjectTouch( event )
	--print(event.phase)
	if ( event.phase == "began" ) then
		startX=event.x
		startY=event.y
	end

	if (event.phase == "moved") then
		--for 
		innerX = event.x
		innerY = event.y
		print(innerX, innerY)
		drawPoint(innerX, innerY)
	end

	if ( event.phase == "ended" ) then
		endX=event.x
		endY=event.y
		print(endX, endY)
		drawPoint(endX,endY)
    end
end

-- create()
local buttonMenu
local background
function scene:create( event )
	local sceneGroup = self.view
	background = display.newImageRect(sceneGroup, "pngs/background.Png", 1200, 1200)


	buttonMenu = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
		buttonMenu.x = display.contentWidth* .15
		buttonMenu.y = display.contentHeight* .12

    local menuText = display.newText(sceneGroup, "MENU", 1, 1, native.systemFont, 35 )
	menuText.x = display.contentWidth * .15
	menuText.y = display.contentHeight* .12
	menuText:setFillColor(0)


	sceneGroup:insert(drawingGroup)
	table.insert(sceneGroup,points)
	background:addEventListener( "touch", onObjectTouch )
    
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		buttonMenu:addEventListener("tap", gotoMenu)
			-- Code here runs when the scene is still off screen (but is about to come on screen)
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
