--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Cursive Upper Case Scene


	problems:  need to get letter coordinates into new file checker, to check accuracy of each letter
				

]]

local composer = require( "composer" )
local json = require("json")
local loadsave = require("loadsave")

local scene = composer.newScene()

--Global initial variables

display.setStatusBar(display.HiddenStatusBar)
local drawingGroup = display.newGroup()

boundaryXmin = 250
boundaryYmin = 35
boundaryXmax = 425
boundaryYmax = 300


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


local function writeFile()
		local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		local file, errorString = io.open(path, "w")
		if not file then
			print("file error!!!!: " .. errorString)
		else
		file:write(" ")
		end

		io.close(file)
end


local function gotoMenu()
	writeFile()
	display.remove(drawingGroup)
	drawingGroup = display.newGroup()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=2000, effect="crossFade" } )
end

local points = {}

local function drawPoint(x1,y1)
	if(x1 > boundaryXmin and y1 > boundaryYmin and x1 < boundaryXmax and y1 < boundaryYmax) then
		local point = display.newRoundedRect(drawingGroup, x1, y1, 1, 1, 5)
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

local function distance(x1, y1, x2, y2)
		dx = (x1-x2)
		dy = (y1-y2)
		return math.sqrt(dx*dx)+(dy*dy)
end

local pictureWidth = boundaryXmax - boundaryXmin
local pictureHeight= boundaryYmax - boundaryYmin
local boxesTall = 10
local boxesWide = 10
local boxWidth = pictureWidth/boxesWide
local boxHeight = pictureHeight/boxesTall

twoDTable = {}
	for x = 1,  boxesWide do
		twoDTable[x] = {}
		for y= 1, boxesTall do 
			twoDTable[x][y] = 0
		end
	end
print_r(twoDTable)

local function addPointToArray(x, y)
	local xCell = math.floor((x-boundaryXmin)/boxWidth)+1
	local yCell = math.floor((y-boundaryYmin)/boxHeight)+1
	--print("xCell"..xCell.."yCell"..yCell)
	if(xCell>=1 and xCell<=boxesWide and yCell >=1 and yCell <= boxesTall) then
		twoDTable[xCell][yCell] = 1
	end
end



local function gotoCheckAccuracy()
	local theirTable = {}
	local myTable = {}

	--print_r(twoDTable)
	local serializeTable = json.encode(twoDTable)
	print(serializeTable, "NOOOOOOO")
	--loadsave.saveTable(twoDTable, "cursiveLowerJ.json")
	--initialize 2d table with 0's

	savedTable = loadsave.loadTable("cursiveLowerJ.json")
	local serializeTable2 = json.encode(savedTable)
	print(serializeTable2, "yes!!!!")

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
	for i=1, #savedTable do
		for j=1, #savedTable do
			if (savedTable[i][j] == 1 ) then
				summer2 = summer2+1
			end
		end
	end
	print (summer2, "v")


	local dotProduct = 0
	for i=1, #twoDTable do
		for j=1, #twoDTable do
			if((savedTable[i][j] == 1 and twoDTable[i][j]) == 1) then
				dotProduct = dotProduct+1
			end
		end
	end
	print(dotProduct, "u.v")

	local uvLength = math.sqrt(summer)*math.sqrt(summer2)
	print (uvLength.."|u|*|v|")


	print(math.floor((dotProduct/uvLength)*100).." percent")
--	if (twoDTable )	



	local path = system.pathForFile("myArray.txt", system.DocumentsDirectory)
	local file, errorString = io.open(path, "r")
   	if not file then 
			print("File error: ".. errorString)
		else
   		local contents = file:read("*a")
	
		--print("Contents of "..path .."\n" .. contents)
		myTable = string.split( (contents), " " )
		--[[
		print_r(myTable)

		myTable_diff = {}
		myTable_subtraction = 175
		for i in ipairs(myTable) do
			myTable_diff[i] = (myTable[i]-myTable_subtraction)
		end
		print(myTable_diff)
			 
]]


--		print ((tonumber(myTable[4])), "yikes!")
 		--[[
 		for x=2, #myTable, 2 do
 			for y=3, #myTable, 2 do
 				
 				--print_r(myTable)
 				--print(twoDTable[x][y])
 				if (myTable[x] ~= nil or myTable[y] ~= nil or twoDTable[x][y] ~= nil) then 
 					twoDTable[tonumber(myTable[x])][tonumber(myTable[y])] = 1
 					else
 					break

 				end

 			end 
 		end


]]



		io.close(file)
	end --  if statement
	--file = nil

	local path1 = system.pathForFile("theirArray.txt", system.DocumentsDirectory)
	local file1, errorString1 = io.open(path1, "r")
   	if not file1 then 
			print("File error: ".. errorString1)
		else
   		local contents1 = file1:read("*a")
	
		theirTable = string.split(contents1, " ")
		--print_r((theirTable))
		--print (theirTable[2], "yikes!")

		io.close(file1)
	end --  if statement



		local myTable1 = tonumber(myTable[3])
		local myTable2 = tonumber(theirTable[4])
		
		--print (math.abs(myTable2-myTable1))
		--print(4-4)



		

		


		--print (math.abs(tonumber(myTable[1])) - tonumber(theirTable[1]))
	
	--[[

	for i = 1, #myTable do
		--for j = 1, #theirTable do
		table1 = tonumber(myTable[i])
		table2 = tonumber(theirTable[i])
		print ((math.abs(table1-table2)))
	end
		

		if ((math.abs(table1-table2)) <= 15)  then
		--print (math.abs(tonumber(myTable[3])))
			--if(myTable[i]==theirTable[i]) then
				print("true") else
				print("false")
		end
	
]]
	--end
	--end


	
	--readFile("myArray.txt")
	

 

		
	

		
	




	
		--print("This is a number plus 10: ".. myTable[4]+ 10)
		--print("This is a number minus 10: ".. myTable[4]- 10)

	

		
	
		--myTable = string.split( contents, " " )
		--print("This is a number plus 10: ".. myTable[4]+ 10)
		--print("This is a number minus 10: ".. myTable[4]- 10)
--[[

		for i = 1, #myTable do
 		  	print((theirTable[i] ))
 		  --	print(myTable[i])
 		end --loop
]]

		
		

	


	

	--for i = 1, #contents do 
	--	print(contents[i])
	--end

	--writeFile()

--	local percentage = display.newText(drawingGroup, "Correct!", 1, 1, "comic.ttf", 35 )
--	percentage.x = display.contentWidth*.20
--	percentage.y = display.contentHeight* .5

end-- gotoCheckAccuracy function



local function twoDArray()

end



local function onObjectTouch( event )
	if ( event.phase == "began" ) then
		local startX=event.x
		local startY=event.y
		drawPoint(startX, startY)
		--print(startX, startY)
		--append to file array.txt
		local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		local file, errorString = io.open(path, "a")
		if not file then
			print("file error: " .. errorString)
		else	
		if(startX > boundaryXmin and startY > boundaryYmin and startX < boundaryXmax and startY < boundaryYmax) then		
			file:write(startX, " ", startY, " ")
		end
			io.close(file)
		end
	end

		if (event.phase == "moved") then 
		local innerX = event.x
		local innerY = event.y
		drawPoint(innerX, innerY)
		if(innerX~=nil and innerY~=nil) then
			addPointToArray(innerX, innerY)
		end
	

		--print(innerX, innerY)
		--append to file array.txt
		local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		local file, errorString = io.open(path, "a")
		if not file then
			print("file error: " .. errorString)
		else	
		if(innerX > boundaryXmin and innerY > boundaryYmin and innerX < boundaryXmax and innerY < boundaryYmax) then		
			file:write(innerX, " ", innerY, " ")
		end
			io.close(file)
		end
	end

	if ( event.phase == "ended" ) then
		local endX=event.x
		local endY=event.y
		display.save(drawingGroup, "currentLetter.png")
    	local path = system.pathForFile(nil, system.DocumentsDirectory)
    	--append to file array.txt
		local path = system.pathForFile("array.txt", system.DocumentsDirectory)
		local file, errorString = io.open(path, "a")
		if not file then
			print("file error: " .. errorString)
		else		
		if(endX > boundaryXmin and endY > boundaryYmin and endX < boundaryXmax and endY < boundaryYmax) then	
			file:write(endX, " ", endY, " ")
		end
			io.close(file)
		end
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
 	letters:setSequence("a")
 	letters:play()

local letterCount = 1





local function gotoNextLetter()
	--checkAccuracy()
	writeFile()
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
end

local function gotoPreviousLetter()
	writeFile()
	letterCount = letterCount-1
	if (letterCount < 1) then
		--display.remove(drawingGroup)
		letterCount = numFrames
		--letters:setSequence(letterFrames[letterCount])
		--display.remove(drawingGroup)
		--drawingGroup = display.newGroup()
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
	buttonCheck:addEventListener("tap", gotoCheckAccuracy)

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
		--buttonMenu:addEventListener("tap", twoDArray)

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
