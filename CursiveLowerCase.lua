--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Cursive Lower Case Scene
]]
-- required modules
local composer = require( "composer" )
local json = require("json")
local loadsave = require("loadsave")



--Global initial variables
local scene = composer.newScene()
display.setStatusBar(display.HiddenStatusBar)
local drawingGroup = display.newGroup()

boundaryXmin = 250
boundaryYmin = 35
boundaryXmax = 425
boundaryYmax = 300

letterArray = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", 
	           "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}

local checkButtonActive = true

local letterCount = 1

local pictureWidth = boundaryXmax - boundaryXmin
local pictureHeight= boundaryYmax - boundaryYmin
local boxesTall = 10
local boxesWide = 10
local boxWidth = pictureWidth/boxesWide
local boxHeight = pictureHeight/boxesTall

twoDTable = {}

local function initializeTable()
	for x = 1,  boxesWide do
		twoDTable[x] = {}
		for y= 1, boxesTall do 
			twoDTable[x][y] = 0
		end
	end
	--print_r(twoDTable)
end
savedTable = {}
---- thank you Rob Miracle for the print function for tables
--https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/
function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

initializeTable()


local function gotoMenu()
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=2000, effect="crossFade" } )
end

local points = {}

local function drawPoint(x1,y1)
	if(x1 > boundaryXmin and y1 > boundaryYmin and x1 < boundaryXmax and y1 < boundaryYmax) then
		local point = display.newRoundedRect(drawingGroup, x1, y1, 10, 10, 5)
		point:setFillColor(0,0,0)   
		table.insert(points, point)
	end
end

-- thank you Rob Miracle for the split function 
-- https://coronalabs.com/blog/2013/04/16/lua-string-magic/
function string:split( inSplitPattern, outResults )
		if not outResults then
      		outResults = {}
   		end
   		local theStart = 1
    	local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
    	while theSplitStart do
      		table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
      		theStart = theSplitEnd + 1
      		theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
    	end
    	table.insert( outResults, string.sub( self, theStart ) )
    	return outResults
end


local function addPointToArray(x, y)
	local xCell = math.floor((x-boundaryXmin)/boxWidth)+1
	local yCell = math.floor((y-boundaryYmin)/boxHeight)+1
	--print("xCell"..xCell.."yCell"..yCell)
	if(xCell>=1 and xCell<=boxesWide and yCell >=1 and yCell <= boxesTall) then
		twoDTable[xCell][yCell] = 1
	end
end


sum = 0
local function dot(tableOne, tableTwo)
	
	if (#tableOne ~= # tableTwo) then
		return 0 
		else if (tableOne == nil or tableOne == {}) then
			return 0
			else
				for i=1, #tableOne do
					for j=1, #tableOne do
						sum = sum + (tableOne[i][j] * tableTwo[i][j])
						--print(sum)
					end
				end
			end
	end
end

local function resetInfo()
	sum = 0
	summer = 0
	summer2 = 0
	initializeTable()
end


local function gotoResetDrawing()
	checkButtonActive = true
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
end




local function gotoCheckAccuracy()
	if (checkButtonActive) then
	
		local serializeTable = json.encode(twoDTable)
		print(serializeTable, "drawing table")
	--loadsave.saveTable(twoDTable, "cursiveLowerC.json")
	--initialize 2d table with 0's



		local summer = 0
		for i=1, #twoDTable do
			for j=1, #twoDTable do
				if(twoDTable[i][j] == 1) then
					summer = summer+1
				end
			end
		end
		print (summer, "u")


		local summer2 = 0
		if(#savedTable) then 
			for i=1, #savedTable do
				for j=1, #savedTable do
					if (savedTable[i][j] == 1 ) then
						summer2 = summer2+1
					end
				end
			end
		else
			drawText = display.newText("Start Drawing", 1, 1, "comic.ttf", 30 )
			drawText.x = display.contentWidth * .14
			drawText.y = display.contentHeight* .40
			drawText:setFillColor(0)
			drawingGroup:insert(textPercent)
		end

	print (summer2, "v")
		
	dot(twoDTable, savedTable)

	local normalize = math.sqrt(summer)*math.sqrt(summer2)
	print (normalize.."|u|*|v|")

	local percentage = math.floor(((sum/normalize)*100))
	print(percentage)



	if (percentage <= 50) then 
		textPercent = display.newText("Try Again!", 1, 1, "comic.ttf", 30 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .40
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent)
	elseif (percentage >50 and percentage<=75) then
		textPercent = display.newText("Getting There!", 1, 1, "comic.ttf", 30 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .40
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent)
	elseif (percentage >75 and percentage <=90)then 
		textPercent = display.newText("Good Job!", 1, 1, "comic.ttf", 30 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .40
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent) 
	elseif (percentage >90 and percentage <100) then
		textPercent = display.newText("Great Job!", 1, 1, "comic.ttf", 30 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .40
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent)
	elseif (percentage == 100) then 
		textPercent = display.newText("Perfect!!", 1, 1, "comic.ttf", 30 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .40
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent)
end
 



	if (percentage ~= nil or percentage ~= 0) then	
		textPercent = display.newText(percentage.." percent", 1, 1, "comic.ttf", 28 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .55
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent)
	end
	resetInfo()

end 
checkButtonActive = false
end-- gotoCheckAccuracy function

local function textForPercent(text, cWidth, cHeight)
		textPercent = display.newText("Try Again", 1, 1, "comic.ttf", 35 )
		textPercent.x = display.contentWidth * .14
		textPercent.y = display.contentHeight* .40
		textPercent:setFillColor(0)
		drawingGroup:insert(textPercent)
end

local function onObjectTouch( event )
	if ( event.phase == "began" ) then
		local startX=event.x
		local startY=event.y
		drawPoint(startX, startY)
		--print(startX, startY)
		
	end

		if (event.phase == "moved") then 
		local innerX = event.x
		local innerY = event.y
		drawPoint(innerX, innerY)
		if(innerX~=nil and innerY~=nil) then
			addPointToArray(innerX, innerY)
		end

	end

	if ( event.phase == "ended" ) then
		local endX=event.x
		local endY=event.y
		display.save(drawingGroup, "currentLetter.png")
    			
		if(endX > boundaryXmin and endY > boundaryYmin and endX < boundaryXmax and endY < boundaryYmax) then	
			savedTable = loadsave.loadTable("cursiveLower"..letterArray[letterCount]..".json")
			local serializeTable2 = json.encode(savedTable)
		end
			
    end
end

local lettersGroup = display.newGroup()
local numFrames = 6
    local options = {
        width = 297,
        height = 338,
        numFrames = numFrames,
        sheetContentWidth = 1782,
        sheetContentHeight = 338
    }


local imageSheet = graphics.newImageSheet("pngs/lowerCaseCursive.png", options)

  local sequenceData ={
                       {name = "a", start = 1, count = 1},
                       {name = "b", start = 2, count = 1},
                       {name = "c", start = 3, count = 1},
                       {name = "d", start = 4, count = 1},
                       {name = "f", start = 5, count = 1},
                       {name = "j", start = 6, count = 1}
  }

  local letterFrames = {"a","b","c","d","f","j"}


  local letters = display.newSprite(lettersGroup, imageSheet, sequenceData)
  	letters.x = display.contentWidth *.7
  	letters.y = display.contentHeight *.525
  	letters:scale(.8, .8)
 	letters:setSequence("a")
 	letters:play()


local function gotoNextLetter()
	--checkAccuracy()
	letterCount = letterCount + 1
	if (letterCount > numFrames) then
		letterCount=1
		--letters:setSequence(letterFrames[letterCount])
	end	

	letters:setSequence(letterFrames[letterCount])
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	--letterCount = letterCount +1
	print("Letter is at "..letterCount)
	checkButtonActive = true
end

local function gotoPreviousLetter()
	letterCount = letterCount-1
	if (letterCount < 1) then
		letterCount = numFrames
	end	

	letters:setSequence(letterFrames[letterCount])
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	print("Letter is at "..letterCount)
	checkButtonActive = true
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




	local buttonCheck = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 75, 60)
	buttonCheck.x = display.contentWidth*.2
	buttonCheck.y = display.contentHeight*.88
	buttonCheck:addEventListener("tap", gotoCheckAccuracy)

	local checkText = display.newText(sceneGroup, "check", 1, 1, "comic.ttf", 20)
	checkText.x = display.contentWidth*.2
	checkText.y = display.contentHeight*.88
	checkText:setFillColor(0)



	local buttonReset = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 75, 60)
	buttonReset.x = display.contentWidth*.005
	buttonReset.y = display.contentHeight*.88
	buttonReset:addEventListener("tap", gotoResetDrawing)

	local resetText = display.newText(sceneGroup, "clear", 1, 1, "comic.ttf", 20)
	resetText.x = display.contentWidth*.005
	resetText.y = display.contentHeight*.88
	resetText:setFillColor(0)




	local buttonNext = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 60, 60)
	buttonNext.x = display.contentWidth*.96
	buttonNext.y = display.contentHeight*.88
	buttonNext:addEventListener("tap", gotoNextLetter)

	local nextText = display.newText(sceneGroup, ">", 1, 1, "comic.ttf", 35)
	nextText.x = display.contentWidth*.96
	nextText.y = display.contentHeight*.88
	nextText:setFillColor(0)

	local buttonBack = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 60, 60)
	buttonBack.x = display.contentWidth*.44
	buttonBack.y = display.contentHeight*.88
	buttonBack:addEventListener("tap", gotoPreviousLetter)

	local backText = display.newText(sceneGroup, "<", 1, 1, "comic.ttf", 35)
	backText.x = display.contentWidth*.44
	backText.y = display.contentHeight*.88
	backText:setFillColor(0)


	local writingSheet = display.newImageRect(sceneGroup, "pngs/handwritingSheet.png", 297, 338)
		writingSheet.x = display.contentWidth *.7
		writingSheet.y = display.contentHeight* .525
		writingSheet:scale(.6, .8)
		

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
