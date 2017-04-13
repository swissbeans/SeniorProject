--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Cursive Lower Case Scene
]]

local composer = require( "composer" )

local scene = composer.newScene()

--Global initial variables

display.setStatusBar(display.HiddenStatusBar)

local function gotoMenu()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end
local drawingGroup = display.newGroup();

--local group=display.newGroup()

--local background = display.newImageRect( group, "pngs/zzritingpage.Png", screenWidth, screenHeight)
--	background.x = display.contentCenterX
--	background.y = display.contentCenterY

local startX
local startY
local endX
local endY
local innerX
local innerY

local points ={}

local function drawPoint(x1,y1)
	--print(x1,y1)
	if(x1 > boundaryXmin and y1 > boundaryYmin and x1 < boundaryXmax and y1 < boundaryYmax) then
		local point = display.newRoundedRect(drawingGroup, x1, y1, 10, 10, 5)
		point:setFillColor(0,0,0)   
		table.insert(points, point)
	end
end


local function onObjectTouch( event )
	--print(event.phase)
	if ( event.phase == "began" ) then
		startX=event.x
		startY=event.y
		print(startX, startY)
	end

	if (event.phase == "moved") then
		--for 
		innerX = event.x
		innerY = event.y
		print(innerX, innerY)
		drawPoint(innerX, innerY)
		--display.save
	end

	if ( event.phase == "ended" ) then
		endX=event.x
		endY=event.y
		--print(endX, endY)
		--drawPoint(endX,endY)
    end
end



-- create()
local buttonMenu
function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "pngs/background.Png", 1200, 1200)

	
	buttonMenu = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
	buttonMenu.x = display.contentWidth* .15
	buttonMenu.y = display.contentHeight* .12

    local menuText = display.newText(sceneGroup, "MENU", 1, 1, native.systemFont, 35 )
	menuText.x = display.contentWidth * .15
	menuText.y = display.contentHeight* .12
	menuText:setFillColor(0)

	local buttonSave = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
	buttonSave.x = display.contentWidth*.85
	buttonSave.y = display.contentHeight*.12

	local saveText = display.newText(sceneGroup, "save", 1, 1, native.systemFont, 35)
	saveText.x = display.contentWidth*.85
	saveText.y = display.contentHeight*.12
	saveText:setFillColor(0)

	local writingSheet = display.newImageRect(sceneGroup, "pngs/zzritingpage.Png", 297, 338)
		writingSheet.x = display.contentWidth *.7
		writingSheet.y = display.contentHeight* .7
		
		boundaryXmin = 187
		boundaryYmin = 55
		boundaryXmax = 485
		boundaryYmax = 266

	sceneGroup:insert(drawingGroup)
	table.insert(sceneGroup,points)
    background:addEventListener( "touch", onObjectTouch )

    --local letterShot = display.capture(drawingGroup, {saveToPhotoLibrary = true, captureOffscreenArea = false})
		
	local listener = {}
	function listener:timer( event )
    	print( "listener called" )
	end
  	if (event.phase == "ended") then
		timer.performWithDelay( 1000, listener )
	end
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		--background:addEventListener( "touch", onObjectTouch )
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
		-- Code here runs when the scene is on screen (but is about to go off screen)

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
