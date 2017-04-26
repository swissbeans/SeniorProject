--[[Carole Schroeder
	Senior Project
	Handwriting Helper - Title Scene
]]



local scene = composer.newScene()

local function gotoMenu()
	composer.removeScene('menu')
	composer.gotoScene('menu', { time=5000, effect="slideUp" })
end

-- create()
function scene:create( event )
	local sceneGroup = self.view
	local background = display.setDefault( sceneGroup, 255 )
	local handwritingHelper = display.newImageRect(sceneGroup, "pngs/title.Png", 596,250)
	handwritingHelper.x = display.contentCenterX
	handwritingHelper.y = display.contentCenterY*1.15
   -- local handwriting=display.newText(sceneGroup, "Handwriting", display.contentCenterX, display.contentCenterY, "myFont.ttf", 100)
   -- local helper=display.newText(sceneGroup, "Helper", display.contentCenterX, display.contentCenterY+85, "myFont.ttf", 100)
   -- cycleColor()
   -- handwriting:setFillColor(r,g,b)
   -- cycleColor()
   -- helper:setFillColor(r,g,b)
    gotoMenu()
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
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
