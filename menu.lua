--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Menu Scene
]]

local composer = require( "composer" )

local scene = composer.newScene()

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

local function goToPrintLowerCase()
	writeFile()
	composer.removeScene("PrintLowerCase")
	composer.gotoScene("PrintLowerCase", { time=400, effect = "fade"})
end

local function goToPrintUpperCase()
	writeFile()
	composer.removeScene("PrintUpperCase")
	composer.gotoScene("PrintUpperCase", { time=400, effect = "fade"})
end

local function goToCursiveLowerCase()
	writeFile()
	composer.removeScene("CursiveLowerCase")
	composer.gotoScene("CursiveLowerCase", { time=400, effect = "fade"})
end

local function goToCursiveUpperCase()
	writeFile()
	composer.removeScene("CursiveUpperCase")
	composer.gotoScene("CursiveUpperCase", { time=400, effect = "fade"})
end

local function gotoAbout()
	composer.removeScene("about")
	composer.gotoScene("about", {time = 400, effect="fade"})
end

-- create()
local buttonLC
local buttonUC
local buttonCLC
local buttonCUC 
local buttonABT

function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "pngs/background.Png", 1200, 1200)

	buttonLC = display.newImageRect(sceneGroup, "pngs/squareButton.Png", 66, 66)
	buttonLC.x = display.contentWidth*.065
	buttonLC.y = display.contentHeight*.765

	local printLowerCaseButton = display.newText(sceneGroup, "a", 1, 1, "comic.ttf", 50)
	printLowerCaseButton.x = display.contentWidth*.065
	printLowerCaseButton.y = display.contentHeight*.765
	printLowerCaseButton:setFillColor(r,g,b)

	buttonUC = display.newImageRect(sceneGroup, "pngs/squareButton.Png", 66, 66)
	buttonUC.x = display.contentWidth*.22
	buttonUC.y = display.contentHeight*.765

	local printUpperCaseButton = display.newText(sceneGroup, "A", 1, 1, "comic.ttf", 50)
	printUpperCaseButton.x = display.contentWidth*.22
	printUpperCaseButton.y = display.contentHeight *.765
	printUpperCaseButton:setFillColor(r,g,b)
	
	buttonCLC = display.newImageRect(sceneGroup, "pngs/squareButton.Png", 66, 66)
	buttonCLC.x = display.contentWidth * .69
	buttonCLC.y = display.contentHeight*.765

	local cursiveLowerCaseButton = display.newImageRect(sceneGroup, "pngs/LettersPngs/CLA.png", 66, 66)
	cursiveLowerCaseButton.x = display.contentWidth*.695
	cursiveLowerCaseButton.y = display.contentHeight * .8
	cursiveLowerCaseButton:setFillColor(r,g,b)

	buttonCUC = display.newImageRect(sceneGroup, "pngs/squareButton.Png", 66, 66)
	buttonCUC.x = display.contentWidth*.845
	buttonCUC.y = display.contentHeight*.765

	local cursiveUpperCaseButton = display.newImageRect(sceneGroup, "pngs/LettersPngs/CUA.png", 66, 66)
	cursiveUpperCaseButton.x = display.contentWidth * .845
	cursiveUpperCaseButton.y = display.contentHeight* .8
	cursiveUpperCaseButton:setFillColor(r,g,b)
	
	buttonABT = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 130, 53)
	buttonABT.x = display.contentWidth* .90
	buttonABT.y = display.contentHeight * .12

	local aboutButton = display.newText(sceneGroup, "ABOUT", 1, 1, "comic.ttf", 25 )
	aboutButton.x = display.contentWidth * .90
	aboutButton.y = display.contentHeight * .12
	aboutButton:setFillColor(r,g,b)
	

	local menu = display.newText(sceneGroup, "MENU", 1, 1, "comic.ttf", 50)
	menu.x = display.contentWidth * .15
	menu.y = display.contentHeight * .12
	menu:setFillColor(r,g,b)

	local printText = display.newText(sceneGroup, "Print", 1, 1, "comic.ttf", 50 )
	printText.x = display.contentWidth * .1425
	printText.y = display.contentHeight * .55
	printText:setFillColor(r,g,b)

	local cursive = display.newImageRect(sceneGroup, "pngs/cursiveText.png", 201, 50 )
	cursive.x = display.contentWidth * .79
	cursive.y = display.contentHeight * .535
	cursive:setFillColor(r,g,b)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		buttonLC:addEventListener("tap", goToPrintLowerCase)
		buttonUC:addEventListener("tap", goToPrintUpperCase)
		buttonCLC:addEventListener("tap", goToCursiveLowerCase)
		buttonCUC:addEventListener("tap", goToCursiveUpperCase)
		buttonABT:addEventListener("tap", gotoAbout)
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
