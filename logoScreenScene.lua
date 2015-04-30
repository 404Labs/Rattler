--scene


local composer = require "composer"

local sceneName= ...

local scene = composer.newScene(sceneName)

function scene: create(event)
	local sceneGroup=self.view
	--intitialize your game objects	
end

function scene: show(event)
	local sceneGroup=self.view
	local phase=event.phase
	
	if(phase == "will") then
		logoScreen=display.newImageRect("backgrounds/firstpage.png",display.contentWidth,display.contentHeight)
		logoScreen.x=display.contentWidth/2
		logoScreen.y=display.contentHeight/2
		--when the scene is about to come to view
	elseif(phase=="did") then
		composer.gotoScene( "menuPageScene")
		--when scene has come to view
	end
end

function scene: hide(event)
	local sceneGroup=self.view
	local phase=event.phase
	
	if(phase == "will") then
		--when the scene is about to go off the screen
	elseif(phase == "did") then
		display.remove(logoScreen)
		logoScreen=nil
		--when the scene has gone off the screen
	end
end

function scene : destroy(event)
	local sceneGroup=self.view
	local phase = event.phase
	
	if(phase == "will") then
		--cleanup the scene here
	end
end

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene