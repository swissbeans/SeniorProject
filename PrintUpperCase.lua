--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Print Upper Case Scene
]]
local composer = require( "composer" )

local scene = composer.newScene()

--Global initial variables
display.setStatusBar(display.HiddenStatusBar)
local drawingGroup = display.newGroup()  -- Display group for the all the drawing stuff

local function gotoMenu()
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end

local points = {}

local function drawPoint(x1,y1)
	if(x1 > boundaryXmin and y1 > boundaryYmin and x1 < boundaryXmax and y1 < boundaryYmax) then
		local point = display.newRoundedRect(drawingGroup, x1, y1, 10, 10, 5)
		point:setFillColor(0,0,0)   
		table.insert(points, point)
	end
end

local function checkAccuracy()
	--if array 1 == array 2 then

	local percentage = display.newText(drawingGroup, "Correct!", 1, 1, "comic.ttf", 35 )
	percentage.x = display.contentWidth*.20
	percentage.y = display.contentHeight* .5
end

local function onObjectTouch( event )
		local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		local file, errorString = io.open(path, "w")
		if not file then
			print("file error!!!!: " .. errorString)
		else
		file:write(" ")
		end
		io.close(file)

	if ( event.phase == "began" ) then
		local startX=event.x
		local startY=event.y
		drawPoint(startX, startY)
			
	end

	if (event.phase == "moved") then
		local innerX = event.x
		local innerY = event.y
		drawPoint(innerX, innerY)
		print(innerX, innerY)
		local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		local file, errorString = io.open(path, "a")
		if not file then
			print("file error: " .. errorString)
		else
			file:write(innerX, " ", innerY, " ")
			io.close(file)
		end
	end

	if ( event.phase == "ended" ) then
		local endX=event.x
		local endY=event.y
		display.save(drawingGroup, "currentLetter.png")
    	local path = system.pathForFile(nil, system.DocumentsDirectory)
		--drawPoint(endX, endY)
		--print('Im saving')
		--local save = display.save(drawingGroup, { filename="currentLetter.png", captureOffscreenArea=true, backgroundColor={1,0,1,0} } )
    	--display.save(drawingGroup, "currentLetter.png")
    	--local path = system.pathForFile(nil, system.DocumentsDirectory)
    	--print (path)
    	--print(system.DocumentDirectory)
    	--print('i see you')
		--drawPoint(endX,endY)
    end
end




local lettersGroup = display.newGroup()
local numFrames = 27
    local options = {
        width = 132,
        height = 150,
        numFrames = numFrames,
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
  	letters.x = display.contentWidth *.7
  	letters.y = display.contentHeight *.525
    letters:scale(1.8, 1.8)
 	letters:setSequence("a")
 	letters:play()

local letterCount = 1

local function gotoNextLetter()
	checkAccuracy()
	letterCount = letterCount+1
	if (letterCount > numFrames) then
		letterCount=1
	end	

	letters:setSequence(letterFrames[letterCount])
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	print("Letter is at "..letterCount)
end

local function gotoPreviousLetter()
	letterCount = letterCount-1
	if (letterCount < 1) then
		letterCount= numFrames
	end	

	letters:setSequence(letterFrames[letterCount])
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
		
	print("Letter is at "..letterCount)
end



-- create()
local buttonMenu 
function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect(sceneGroup, "pngs/background.Png", 1200, 1200)


	buttonMenu = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
		buttonMenu.x = display.contentWidth* .10
		buttonMenu.y = display.contentHeight* .12
	

    local menuText = display.newText(sceneGroup, "MENU", 1, 1, "comic.ttf", 35 )
	menuText.x = display.contentWidth * .10
	menuText.y = display.contentHeight* .12
	menuText:setFillColor(0)

	local buttonCheck = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
	buttonCheck.x = display.contentWidth*.10
	buttonCheck.y = display.contentHeight*.88
	--buttonCheck:addEventListener("tap", gotoNextLetter)

	local checkText = display.newText(sceneGroup, "check", 1, 1, "comic.ttf", 35)
	checkText.x = display.contentWidth*.10
	checkText.y = display.contentHeight*.88
	checkText:setFillColor(0)

	local buttonNext = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 60, 60)
	buttonNext.x = display.contentWidth*.95
	buttonNext.y = display.contentHeight*.88
	buttonNext:addEventListener("tap", gotoNextLetter)

	local nextText = display.newText(sceneGroup, ">", 1, 1, "comic.ttf", 35)
	nextText.x = display.contentWidth*.95
	nextText.y = display.contentHeight*.88
	nextText:setFillColor(0)

	local buttonBack = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 60, 60)
	buttonBack.x = display.contentWidth*.45
	buttonBack.y = display.contentHeight*.88
	buttonBack:addEventListener("tap", gotoPreviousLetter)

	local backText = display.newText(sceneGroup, "<", 1, 1, "comic.ttf", 35)
	backText.x = display.contentWidth*.45
	backText.y = display.contentHeight*.88
	backText:setFillColor(0)

	local writingSheet = display.newImageRect(sceneGroup, "pngs/zzritingpage.Png", 297, 338)
		writingSheet.x = display.contentWidth *.7
		writingSheet.y = display.contentHeight* .525
		writingSheet:scale(.8, .8)
		
		boundaryXmin = 250
		boundaryYmin = 35
		boundaryXmax = 425
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
		--display.remove(letters)
		print("REMOVED")
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
