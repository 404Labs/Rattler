--scene

local sceneName = ...

local composer = require "composer"

local scene = composer.newScene(sceneName)
local widget= require("widget")

menupage = nil
playbutton=nil
backgroundbutton1=nil
backgroundbutton2=nil
backgroundbutton3=nil

soundbutton1=nil
soundbutton2=nil
soundbutton3=nil

ballbutton1=nil
ballbutton2=nil
ballbutton3=nil

function scene: create(event)
	local sceneGroup=self.view
	--intitialize your game objects	
end

function scene: show(event)
	Runtime:removeEventListener("accelerometer",listener)
	Runtime:removeEventListener("orientation",onOrientationChange)
	local sceneGroup=self.view
	local phase=event.phase
	
	if(phase == "will") then
		menupage=display.newImageRect("backgrounds/menu_page.png",display.contentWidth,display.contentHeight)
		menupage.x=display.contentWidth/2
		menupage.y=display.contentHeight/2
		
		--PLAY BUTTON ENDS
		
		--background button 1 start
		function handleBackGroundButton1Event(event)
			backGroundFile="backgrounds/background1.png"
			backButtonFile="buttons/back-button-world1.png"
			backButtonClickedFile="buttons/back-button-world1-clicked.png"
		end
		backgroundbutton1 = widget.newButton
		{
			width=60,
			height=60,
			defaultFile = "buttons/thumbnailbackground1.png",
			overFile = "buttons/thumbnailbackground_a_tick.png",					
			onEvent = handleBackGroundButton1Event
		}
		backgroundbutton1.x = backgroundbutton1.width
		backgroundbutton1.y = display.contentHeight/2 -display.contentHeight/12
		--background button 1 end
					
		--background button 2 start
							
		function handleBackGroundButton2Event(event)
			backGroundFile="backgrounds/background2.png"
			backButtonFile="buttons/back-button-world2.png"
			backButtonClickedFile="buttons/back-button-world2-clicked.png"
		end		
		backgroundbutton2 = widget.newButton
		{										
			width=60,
			height=60,
			defaultFile = "buttons/thumbnailbackground2.png",
			overFile = "buttons/thumbnailbackground_b_tick.png",									
			onEvent = handleBackGroundButton2Event
		}
		backgroundbutton2.x = display.contentWidth/2
		backgroundbutton2.y = display.contentHeight/2 -display.contentHeight/12
		--background button 2 end
		
		--background button 3 start
		function handleBackGroundButton3Event(event)
			backGroundFile="backgrounds/background3.png"
			backButtonFile="buttons/back-button-world3.png"
			backButtonClickedFile="buttons/back-button-world3-clicked.png"
		end		
		backgroundbutton3 = widget.newButton
		{													
			width=60,
			height=60,
			defaultFile = "buttons/thumbnailbackground3.png",
			overFile = "buttons/thumbnailbackground_c_tick.png",													
			onEvent = handleBackGroundButton3Event
		}													
		backgroundbutton3.x = display.contentWidth-backgroundbutton3.width
		backgroundbutton3.y = display.contentHeight/2 -display.contentHeight/12
		--background button 3 end
		
		function handleSoundButton1Event(event)
			soundFile="sounds/jhunjhuna1.mp3"
		end		
		soundbutton1 = widget.newButton
		{
			width=60,
			height=60,
			defaultFile = "buttons/sound-button1.png",
			overFile = "buttons/sound-button1clicked.png",
			onEvent = handleSoundButton1Event
		}
		soundbutton1.x = soundbutton1.width
		soundbutton1.y = backgroundbutton1.y+soundbutton1.height+display.contentHeight/20
		
		function handleSoundButton2Event(event)
			soundFile="sounds/jhunjhuna2.mp3"
		end		
		soundbutton2 = widget.newButton
		{
			
			width=60,
			height=60,
			defaultFile = "buttons/sound-button2.png",
			overFile = "buttons/sound-button2clicked.png",
			onEvent = handleSoundButton2Event
		}
		soundbutton2.x = display.contentWidth/2
		soundbutton2.y = backgroundbutton1.y+soundbutton2.height+display.contentHeight/20
		
		function handleSoundButton3Event(event)
			soundFile="sounds/jhunjhuna3.mp3"
		end		
			soundbutton3 = widget.newButton
		{
			width=60,
			height=60,
			defaultFile = "buttons/sound-button3.png",
			overFile = "buttons/sound-button3clicked.png",
			onEvent = handleSoundButton3Event
		}
		soundbutton3.x = display.contentWidth-soundbutton3.width
		soundbutton3.y = backgroundbutton1.y+soundbutton3.height+display.contentHeight/20
								--BUTTON FOR SOUND SELECTION {ENDS}
								--BUTTON FOR BALL SELECTION START
												       
		function handleBallButton1Event(event)
			ballType="balls/ball1.png"
		end		
		ballbutton1 = widget.newButton
		{
			width=60,
			height=60,
			defaultFile = "balls/ball1.png",
			overFile = "balls/ball1.png",
			onEvent = handleBallButton1Event
		}
		ballbutton1.x = ballbutton1.width
		ballbutton1.y = soundbutton1.y+ballbutton1.height+display.contentHeight/20
		
		function handleBallButton2Event(event)
			ballType="balls/ball2.png"
		end		
		ballbutton2 = widget.newButton
		{
			width=60,
			height=60,
			defaultFile = "balls/ball2.png",
			overFile =  "balls/ball2.png",
			onEvent = handleBallButton2Event
		}
		ballbutton2.x = display.contentWidth/2
		ballbutton2.y = soundbutton1.y+ballbutton2.height+display.contentHeight/20
		
		function handleBallButton3Event(event)
			ballType="balls/ball3.png"
		end		
		ballbutton3 = widget.newButton
		{
			width=60,
			height=60,
			defaultFile =  "balls/ball3.png",
			overFile =  "balls/ball3.png",
			onEvent = handleBallButton3Event
		}
		ballbutton3.x = display.contentWidth-ballbutton3.width
		ballbutton3.y = soundbutton1.y+ballbutton3.height+display.contentHeight/20
		
		--when the scene is about to come to view
	elseif(phase=="did") then
		function handlePlayButtonEvent(buttonEvent)
			if ("ended" == buttonEvent.phase ) then
				Runtime:removeEventListener("onEvent",handleBackGroundButton1Event)
				Runtime:removeEventListener("onEvent",handleBackGroundButton2Event)
				Runtime:removeEventListener("onEvent",handleBackGroundButton3Event)
			
				Runtime:removeEventListener("onEvent",handleSoundButton1Event)
				Runtime:removeEventListener("onEvent",handleSoundButton2Event)
				Runtime:removeEventListener("onEvent",handleSoundButton3Event)
			
				Runtime:removeEventListener("onEvent",handleBallButton1Event)
				Runtime:removeEventListener("onEvent",handleBallButton2Event)
				Runtime:removeEventListener("onEvent",handleBallButton3Event)
			
				composer.gotoScene("gamePlayScene")
			end
		end
		
		playbutton = widget.newButton
		{	
			width = 220,
			height = 40,
			defaultFile = "buttons/playbutton.png",
			overFile = "buttons/playbuttonclicked.png",
			onEvent = handlePlayButtonEvent
		}
		playbutton.x = display.contentWidth/2+4
		playbutton.y = display.contentHeight/6+2
		--when scene has come to view
	end
end

function scene: hide(event)
	local sceneGroup=self.view
	local phase=event.phase
	
	if(phase == "will") then
		--when the scene is about to go off the screen
	elseif(phase == "did") then
		display.remove(menupage)
		menupage=nil
		display.remove(playbutton)
		playbutton=nil
		display.remove(backgroundbutton1)
		backgroundbutton1=nil
		display.remove(backgroundbutton2)
		backgroundbutton2=nil
		display.remove(backgroundbutton3)
		backgroundbutton3=nil
		display.remove(soundbutton1)
		soundbutton1=nil
		display.remove(soundbutton2)
		soundbutton2=nil
		display.remove(soundbutton3)
		soundbutton3=nil
		display.remove(ballbutton1)
		ballbutton1=nil
		display.remove(ballbutton2)
		ballbutton2=nil
		display.remove(ballbutton3)
		ballbutton3=nil
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