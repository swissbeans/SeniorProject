--[[Carole Schroeder
	Senior Project
	Handwriting Helper - About Scene
]]

local composer = require( "composer" )

local scene = composer.newScene()

--Global initial variables

display.setStatusBar(display.HiddenStatusBar)


local function gotoMenu()
	composer.removeScene( "menu" )
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end

-- create()
local buttonMenu
function scene:create( event )
	local sceneGroup = self.view
	local background = display.newImageRect(sceneGroup, "pngs/background.Png", 1200, 1200)

	buttonMenu = display.newImageRect(sceneGroup, "pngs/rectButton.Png", 160, 60)
		buttonMenu.x = display.contentWidth* .15
		buttonMenu.y = display.contentHeight* .12

    local menuText = display.newText(sceneGroup, "MENU", 1, 1, "comic.ttf", 35 )
	menuText.x = display.contentWidth * .15
	menuText.y = display.contentHeight* .12
	menuText:setFillColor(0)

	local info = display.newText(sceneGroup, "Handwriting Helper was created for children\nto practice their handwriting skills. \n\nPlease choose the type of handwriting and practice!  \n\n\nDeveloped by Carole Schroeder", 1, 1, "comic.ttf", 20)
	info.x = display.contentCenterX
	info.y = display.contentHeight*.6
	info:setFillColor(0,0,0)
	
    
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
