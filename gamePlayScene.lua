
local sceneName = ...

local composer = require "composer"
physics = require "physics"

local scene = composer.newScene(sceneName)
local widget= require("widget")
local ads = require "ads"

numOfBalls=nil
myBall={}
background=nil
backbutton=nil

forceOnBallX = 500
forceOnBallY = -400

--soundFile=nil
Ballsound=nil



function scene: create(event)
	local sceneGroup=self.view
	--intitialize your game objects	
end

function scene: show(event)
	local sceneGroup=self.view
	local phase=event.phase
	Runtime:addEventListener("accelerometer",listener)
	Runtime:addEventListener( "orientation", onOrientationChange )
	if(phase == "will") then
		
		--local Library = require "CoronaLibrary"

		-- Create library
		--local lib = Library:new{ name='ads', publisherId='com.coronalabs' }

		--local ads = require "ads"
		
		local function adListener( event )
			if ( event.isError ) then
				--Failed to receive an ad
				print "Error in ads"
			end
		end
		
		
		-- ads = require( "plugin.google.play.services" )
		ads.init( "admob","ca-app-pub-6872334661207911/9697454180" , adListener)
		ads.show("banner" , {x= display.contentWidth/2, y = display.contentHeight/2, testMode=true})
		--ads.show("banner", { x=display.contentWidth/2, y=display.contentHeight/2-200,appId="ca-app-pub-6872334661207911/9697454180", testMode=true})
		
		
		
		system.setIdleTimer(false)
		
		if backGroundFile == nil then
			backGroundFile="backgrounds/background1.png"
		end
		
		if backButtonFile == nil then
			backButtonFile="buttons/back-button-world1.png"
		end
		
		if backButtonClickedFile== nil then
			backButtonClickedFile="buttons/back-button-world1-clicked.png"
		end
		
		if ballType == nil then
			ballType = "balls/ball1.png"
		end
		--more sound not loading
		if (soundFile == nil) then
			soundFile = "sounds/jhunjhuna1.mp3"
		end
		
		if(numOfBalls == nil) then
			numOfBalls=9
		end
		
		if(forceOnBallX==nil) then
			forceOnBallX=500
		end
		
		if(forceOnBallY==nil) then
			forceOnBallY=-400
		end
		
		--removeMenuPageItems()
		physics.start()
		physics.setDrawMode("normal")
		physics.setGravity(0,9.8)

		--walls on screens
		leftWall = display.newRect (display.contentWidth/20, 0, 1, display.contentHeight)
		rightWall = display.newRect (display.contentWidth-(display.contentWidth/20), 0, 1, display.contentHeight)
		ceilingWall = display.newRect (0, display.contentHeight/9, display.contentWidth, 1)
		bottomWall = display.newRect(0, display.contentHeight-(display.contentHeight/9), display.contentWidth,10)
		
		physics.addBody (leftWall,  "static",  { bounce = 0.1 } )
		physics.addBody (rightWall, "static",  { bounce = 0.1 } )
		physics.addBody (ceilingWall,   "static",  { bounce = 0.1 } )
		physics.addBody (bottomWall,    "static",  { bounce = 0.1 } )
		
		background = display.newImageRect(backGroundFile,display.contentWidth,display.contentHeight)
		background.x=display.contentCenterX
		background.y=display.contentCenterY
		--sound statement
		Ballsound = audio.loadStream(soundFile)	
		
		--images will display according to content height and width
		_H = display.contentHeight
		_W = display.contentWidth
		
		for i=0,numOfBalls,1 do
			myBall[i]=display.newImageRect(ballType,60,60)
			randomX = math.random(myBall[i].width*2, display.contentWidth-(myBall[i].width)*2)
			randomY=math.random(myBall[i].height*2,display.contentHeight-(myBall[i].height)*2)
			myBall[i]:setReferencePoint(display.CenterReferencePoint)
			myBall[i].x = randomX
			myBall[i].y = randomY
			physics.addBody(myBall[i], "dynamic" ,{density=0.1,friction=0.8, bounce=0.8, radius=30})
		end
		
		function handleBackButtonEvent(event)
			Runtime:removeEventListener("accelerometer",listener)
			Runtime:removeEventListener("orientation",onOrientationChange)
			composer.gotoScene("menuPageScene")
		end	
		
		backbutton = widget.newButton
		{
			width=80,
			height=40,
			--defaultFile = "buttons/balls_button.png",
			defaultFile = backButtonFile,
			overFile = backButtonClickedFile,
			--label = "select sound",
			onEvent = handleBackButtonEvent
		}
		backbutton.x = display.contentWidth/2
		backbutton.y = backbutton.height/1.5
		
		
		backGroundFile=nil
		backButtonFile=nil
		backButtonClickedFile=nil
		ballType=nil
		soundFile=nil
	elseif(phase=="did") then
		--when scene has come to view
		
	end
	
end

function scene: hide(event)
	local sceneGroup=self.view
	local phase=event.phase
	
	if(phase == "will") then
	
		--when the scene is about to go off the screen
	elseif(phase == "did") then
		--when the scene has gone off the screen
		--display.remove(Ballsound)
		
		audio.dispose(Ballsound)
		Ballsound=nil
		--display.remove(backButtonFile)
		backButtonFile=nil
		--display.remove(backButtonClickedFile)
		backButtonClickedFile=nil
		--display.remove(ballType)
		ballType=nil
		display.remove(backbutton)
		backbutton=nil
		display.remove(background)
		background=nil
		soundFile=nil
		for i=0,numOfBalls,1 do
			physics.removeBody(myBall[i])
			display.remove(myBall[i])
			myBall[i]=nil
		end
		
		numOfBalls=nil
		
		physics.removeBody(leftWall)
		display.remove(leftWall)
		leftWall=nil
		
		physics.removeBody(rightWall)
		display.remove(rightWall)
		rightWall=nil
		
		physics.removeBody(bottomWall)
		display.remove(bottomWall)
		bottomWall=nil
		
		physics.removeBody(ceilingWall)
		display.remove(ceilingWall)
		ceilingWall=nil
		
		forceOnBallX=nil
		forceOnBallY=nil
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

--composer.gotoScene("menuPageScene")

local function onKeyEvent( event )
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print( message )

    -- If the "back" key was pressed on Android or Windows Phone, prevent it from backing out of the app
    if ( event.keyName == "back" ) or (event.keyName == "homePage") then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            return true
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

function onOrientationChange( event )
				 currentOrientation = event.type
					
					if currentOrientation=="landscapeLeft" then
						physics.setGravity(9.8,0)
						forceOnBallX=-100
						forceOnBallY=200
					elseif currentOrientation=="portraitUpsideDown" then
						physics.setGravity(0,-9.8)
						forceOnBallX=100
						forceOnBallY=200
					elseif currentOrientation=="landscapeRight" then
						physics.setGravity(-9.8,0)
						forceOnBallX=100
						forceOnBallY=200
					elseif currentOrientation=="portrait" then
						physics.setGravity(0,9.8)
						forceOnBallX=-100
						forceOnBallY=-200
	
					end
end



function listener( event )
	if numOfBalls == nil then
		numOfBalls=9
	end
	
		
		if(
		( event.xInstant>0.6 and event.xInstant<0.9 ) or ( event.xInstant>-0.9 and event.xInstant<-0.6 ) or
		( event.yInstant >0.6 and event.yInstant<0.9 ) or ( event.yInstant>-0.9 and event.yInstant<-0.6 ) or
		( event.zInstant > 0.6 and event.zInstant <0.9 )or ( event.zInstant>-0.9 and event.zInstant<-0.6 )
		 ) then
		
			audio.play(Ballsound)
			for i=0,numOfBalls,1 do
				myBall[i]:applyForce(forceOnBallX,forceOnBallY,myBall[i].x,myBall[i].y)
			end
	    end
	return  true
end




return scene