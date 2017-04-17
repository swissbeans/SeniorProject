--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Cursive Upper Case Scene


	problems:   what's happening mathematically forward and back buttons
				need to figure out how to take x and y points and put them into table/array (or onto external file)

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


local points = {}

local function drawPoint(x1,y1)
	if(x1 > boundaryXmin and y1 > boundaryYmin and x1 < boundaryXmax and y1 < boundaryYmax) then
		local point = display.newRoundedRect(drawingGroup, x1, y1, 10, 10, 5)
		point:setFillColor(0,0,0)   
		table.insert(points, point)
		--print (points)
	end
end

local function checkAccuracy()
	--if array 1 == array 2 then

	local percentage = display.newText(drawingGroup, "Correct!", 1, 1, native.systemFont, 35 )
	percentage.x = display.contentWidth*.20
	percentage.y = display.contentHeight* .5
end


local function arrayToFile()
	for i = 1, table.getn(points), 1 do
	end
end

local function onObjectTouch( event )
	if ( event.phase == "began" ) then
		local startX=event.x
		local startY=event.y
		--print(startX, startY)
		drawPoint(startX, startY)
	end

	if (event.phase == "moved") then 
		local innerX = event.x
		local innerY = event.y
		
		--local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		--local file, errorString = io.open(path, "w")
		--if not file then
		--	print("file error: " .. errorString)
		--else
			
		--	file:write(innerX, innerY)
		--	io.close(file)
			--print(system.DocumentsDirectory)
		--end
		
		--print(innerX, innerY)
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
local numFrames = 5
    local options = {
        width = 297,
        height = 338,
        numFrames = numFrames,
        sheetContentWidth = 1485,
        sheetContentHeight = 338
    }


local imageSheet = graphics.newImageSheet("pngs/LowerCaseLetters4.Png", options)

  local sequenceData ={
                       {name = "a", start = 1, count = 0},
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
 	letters:setSequence("a")
 	letters:play()

local letterCount = 2


local function gotoNextLetter()
	checkAccuracy()
	if (letterCount > numFrames) then
		display.remove(drawingGroup)
		letterCount=1
		letters:setSequence(letterFrames[letterCount+1])
	end	

	letters:setSequence(letterFrames[letterCount])
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	letterCount = letterCount+1
	print("Letter is at "..letterCount)
end

local function gotoPreviousLetter()
	if (letterCount < 1) then
		display.remove(drawingGroup)
		letters:setSequence(letterFrames[letterCount+numFrames])
	end	

	for i=numFrames, 1, -1 do
		letters:setSequence(letterFrames[letterCount])
	end

	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	
	letterCount = letterCount-1
	print("shit is at "..letterCount)
end

-- create()
local buttonMenu
function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "pngs/background.Png", 1200, 1200)


	buttonMenu = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
		buttonMenu.x = display.contentWidth* .10
		buttonMenu.y = display.contentHeight* .12

    local menuText = display.newText(sceneGroup, "MENU", 1, 1, native.systemFont, 35 )
	menuText.x = display.contentWidth * .10
	menuText.y = display.contentHeight* .12
	menuText:setFillColor(0)

	local buttonCheck = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
	buttonCheck.x = display.contentWidth*.10
	buttonCheck.y = display.contentHeight*.88
	--buttonCheck:addEventListener("tap", gotoNextLetter)

	local checkText = display.newText(sceneGroup, "check", 1, 1, native.systemFont, 35)
	checkText.x = display.contentWidth*.10
	checkText.y = display.contentHeight*.88
	checkText:setFillColor(0)

	local buttonNext = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 60, 60)
	buttonNext.x = display.contentWidth*.95
	buttonNext.y = display.contentHeight*.88
	buttonNext:addEventListener("tap", gotoNextLetter)

	local nextText = display.newText(sceneGroup, ">", 1, 1, native.systemFont, 35)
	nextText.x = display.contentWidth*.95
	nextText.y = display.contentHeight*.88
	nextText:setFillColor(0)

	local buttonBack = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 60, 60)
	buttonBack.x = display.contentWidth*.45
	buttonBack.y = display.contentHeight*.88
	buttonBack:addEventListener("tap", gotoPreviousLetter)

	local backText = display.newText(sceneGroup, "<", 1, 1, native.systemFont, 35)
	backText.x = display.contentWidth*.45
	backText.y = display.contentHeight*.88
	backText:setFillColor(0)


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
