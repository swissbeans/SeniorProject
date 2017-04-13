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
		local startX=event.x
		local startY=event.y
		print(startX, startY)
	end

	if (event.phase == "moved") then
		--for 
		local innerX = event.x
		local innerY = event.y
		print(innerX, innerY)
		drawPoint(innerX, innerY)
	end

	if ( event.phase == "ended" ) then
		local endX=event.x
		local endY=event.y
		--display.save(drawingGroup, "currentLetter.png")
    	--local path = system.pathForFile(nil, system.DocumentsDirectory)
    	--print (path)
		--print(endX, endY)
		--drawPoint(endX,endY)
    end
end

local lettersGroup = display.newGroup()

    local options = {
        width = 297,
        height = 338,
        numFrames = 5,
        sheetContentWidth = 1485,
        sheetContentHeight = 338
    }


local imageSheet = graphics.newImageSheet("pngs/LowerCaseLetters4.Png", options)

  local sequenceData ={
                       {name = "a", start = 1, count = 1},
                       {name = "b", start = 2, count = 1},
                       {name = "c", start = 3, count = 1},
                       {name = "d", start = 4, count = 1},
                       {name = "j", start = 5, count = 1}
                       
  }

  local letterFrames = {"a","b","c","d","j"}


  local letters = display.newSprite(lettersGroup, imageSheet, sequenceData)
  	letters.x = display.contentWidth *.7
  	letters.y = display.contentHeight *.525
  	letters:scale(.8, .8)
 	letters:setSequence("j")
 	letters:play()

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
	buttonSave.x = display.contentWidth*.15
	buttonSave.y = display.contentHeight*.88

	local saveText = display.newText(sceneGroup, "save", 1, 1, native.systemFont, 35)
	saveText.x = display.contentWidth*.15
	saveText.y = display.contentHeight*.88
	saveText:setFillColor(0)

	local writingSheet = display.newImageRect(sceneGroup, "pngs/zzritingpage.Png", 297, 338)
		writingSheet.x = display.contentWidth *.7
		writingSheet.y = display.contentHeight* .525
		writingSheet:scale(.8, .8)
		
		boundaryXmin = 215
		boundaryYmin = 35
		boundaryXmax = 455
		boundaryYmax = 300

	sceneGroup:insert(drawingGroup)
	sceneGroup:insert(lettersGroup)
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
