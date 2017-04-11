--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Print Lower Case Scene
]]
local composer = require( "composer" )

local scene = composer.newScene()

--Global initial variables

display.setStatusBar(display.HiddenStatusBar)
local drawingGroup = display.newGroup()  -- Display group for the all the drawing stuff


local function gotoMenu()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end

local lines={}
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
		local startX=event.x
		local startY=event.y
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
		print(endX, endY)
		drawPoint(endX,endY)
    end
end


local lettersGroup = display.newGroup()

    local options = {
        width = 132,
        height = 150,
        numFrames = 27,
        sheetContentWidth = 396,
        sheetContentHeight = 1350
    }


local imageSheet = graphics.newImageSheet("pngs/LowerCaseLetters.Png", options)

  local sequenceData ={
                       {name = "a", start = 1, count = 1},
                       {name = "b", start = 2, count = 1},
                       {name = "c", start = 3, count = 1},
                       {name = "d", start = 4, count = 1},
                       {name = "e", start = 5, count = 1},
                       {name = "f", start = 6, count = 1},
                       {name = "g", start = 7, count = 1},
                       {name = "h", start = 8, count = 1},
                       {name = "i", start = 9, count = 1},
                       {name = "j", start = 10, count = 1},
                       {name = "k", start = 11, count = 1},
                       {name = "l", start = 12, count = 1},
                       {name = "m", start = 13, count = 1},
                       {name = "n", start = 14, count = 1},
                       {name = "o", start = 15, count = 1},
                       {name = "p", start = 16, count = 1},
                       {name = "q", start = 17, count = 1},
                       {name = "r", start = 18, count = 1},
                       {name = "s", start = 19, count = 1},
                       {name = "t", start = 20, count = 1},
                       {name = "u", start = 21, count = 1},
                       {name = "v", start = 22, count = 1},
                       {name = "w", start = 23, count = 1},
                       {name = "x", start = 24, count = 1},
                       {name = "y", start = 25, count = 1},
                       {name = "z", start = 26, count = 1},
                       {name = "zz", start = 27, count = 1}
  }

  local letterFrames = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u",
						"v","w","x","y","z","zz"}


  local letters = display.newSprite(lettersGroup, imageSheet, sequenceData)
  	letters.x = display.contentCenterX*3/2
  	letters.y = display.contentCenterY+33
 	letters:setSequence("a")
 	letters:play()



-- create()
local buttonMenu
function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "pngs/background.png", 1200, 1200)

	buttonMenu = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
		buttonMenu.x = display.contentWidth* .15
		buttonMenu.y = display.contentHeight* .12
		buttonMenu:addEventListener("tap", gotoMenu)

    local menuText = display.newText(sceneGroup, "MENU", 1, 1, native.systemFont, 35 )
	menuText.x = display.contentWidth * .15
	menuText.y = display.contentHeight* .12
	menuText:setFillColor(0)

    sceneGroup:insert(drawingGroup)
	sceneGroup:insert(lettersGroup)
	table.insert(sceneGroup,lines)
	table.insert(sceneGroup,points)
	background:addEventListener( "touch", onObjectTouch )
	

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		--background:addEventListener( "touch", onObjectTouch )
		
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