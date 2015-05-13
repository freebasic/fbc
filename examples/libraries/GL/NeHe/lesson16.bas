''
'' This Code Was Created By Jeff Molofee 2000
'' A HUGE Thanks To Fredric Echols For Cleaning Up
'' And Optimizing The Base Code, Making It More Flexible!
'' If You've Found This Code Useful, Please Let Me Know.
'' Visit My Site At nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Use ESC key to quit
'' L key to toggle lighting (on, off)
'' F key to cycle filters (0=Nearest, 1=Linear , 2=MipMapped)
'' G key to cycle fog filters (0=GL_LINEAR fog, 1=GL_EXP fog, 2=GL_EXP2 fog)
'' PgUp key and PgDn key to Zoom in and out
'' UpArrow, DnArrow, RightArrow, Left Arrow to change rotate speed of cube
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson16.bas



#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "createtex.bi"

'' Setup our booleans
const false = 0
const true  = not false

	dim light as integer                    '' Lighting ON/OFF
	dim lp as integer                       '' L Pressed?
	dim fp as integer                       '' F Pressed?
	dim gp as integer                       '' G Pressed? ( NEW )
	dim filter as uinteger                  '' Which Filter To Use
	dim texture(0 to 2) as uinteger         '' Storage For 3 Textures
	dim fogfilter as uinteger               '' Which Fog Mode To Use

	dim LightAmbient(0 to 3) as single => {0.5, 0.5, 0.5, 1.0}   '' Ambient Light Values ( NEW )
	dim LightDiffuse(0 to 3) as single => {1.0, 1.0, 1.0, 1.0}   '' Diffuse Light Values ( NEW
	dim LightPosition(0 to 3) as single => {0.0, 0.0, 2.0, 1.0}  '' Light Position ( NEW )
	'' Initialize Three Types Of Fog
	dim fogMode(0 to 2) as uinteger => {GL_EXP, GL_EXP2, GL_LINEAR}
	dim fogColor(0 to 3) as single => {0.5, 0.5, 0.5, 1.0}       '' Fog Color

	dim xrot as single                             '' X Rotation
	dim yrot as single                             '' Y Rotation
	dim xspeed as single                           '' X Rotation Speed
	dim yspeed as single                           '' Y Rotation Speed
	dim z as single = -5.0                         '' Depth Into The Screen

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix

	'' Use BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte             '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Crate.bmp", @buffer(0)
	texture(0) = CreateTexture(@buffer(0),TEX_NOFILTER)  '' Nearest Texture
	texture(1) = CreateTexture(@buffer(0))               '' Linear Texture (default)
	texture(2) = CreateTexture(@buffer(0),TEX_MIPMAP)    '' MipMapped Texture
	'' Exit if error loading textures
	if texture(0) = 0 or texture(1) = 0 or texture(2) = 0 then end 1

	'' All Setup For OpenGL Goes Here
	glEnable GL_TEXTURE_2D                             '' Enable Texture Mapping ( NEW
	glShadeModel GL_SMOOTH                             '' Enable Smooth Shading

	glClearColor 0.0, 0.0, 0.0, 0.5                    '' Black Background
	glClearDepth 1.0                                   '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                             '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                              '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST   '' Really Nice Perspective Calculations


	glLightfv GL_LIGHT1, GL_AMBIENT, @LightAmbient(0)  '' Setup The Ambient Light
	glLightfv GL_LIGHT1, GL_DIFFUSE, @LightDiffuse(0)  '' Setup The Diffuse Light
	glLightfv GL_LIGHT1, GL_POSITION,@LightPosition(0) '' Position The Light
	glEnable GL_LIGHT1                                 '' Enable Light One

	glFogi GL_FOG_MODE, fogMode(fogfilter)             '' Fog Mode
	glFogfv GL_FOG_COLOR, @fogColor(0)                 '' Set Fog Color
	glFogf GL_FOG_DENSITY, 0.35                        '' How Dense Will The Fog Be
	glHint GL_FOG_HINT, GL_DONT_CARE                   '' Fog Hint Value
	glFogf GL_FOG_START, 1.0                           '' Fog Start Depth
	glFogf GL_FOG_END, 5.0                             '' Fog End Depth
	glEnable GL_FOG                                    '' Enables GL_FOG


	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear Screen And Depth Buffer
		glLoadIdentity                                          '' Reset The View
		glTranslatef 0.0,0.0,z                                  '' Translate Into/Out Of The Screen By z

		glRotatef xrot,1.0,0.0,0.0                              '' Rotate On The X Axis By xrot
		glRotatef yrot,0.0,1.0,0.0                              '' Rotate On The Y Axis By yrot

		glBindTexture GL_TEXTURE_2D, texture(filter)            '' Select A Texture Based On filter

		glBegin GL_QUADS                                          '' Start Drawing Quads
			'' Front Face
			glNormal3f  0.0, 0.0, 1.0                             '' Normal Pointing Towards Viewer
			glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0,  1.0   '' Point 1 (Front)
			glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0,  1.0   '' Point 2
			glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0,  1.0   '' Point 3
			glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0,  1.0   '' Point 4
			'' Back Face
			glNormal3f  0.0, 0.0,-1.0                             '' Normal Pointing Away From Viewer
			glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0, -1.0   '' Point 1 (Back)
			glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0, -1.0   '' Point 2
			glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0, -1.0   '' Point 3
			glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0, -1.0   '' Point 4
			'' Top Face
			glNormal3f  0.0, 1.0, 0.0                             '' Normal Pointing Up
			glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0   '' (Top)
			glTexCoord2f 0.0, 0.0 : glVertex3f -1.0,  1.0,  1.0
			glTexCoord2f 1.0, 0.0 : glVertex3f  1.0,  1.0,  1.0
			glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0
			'' Bottom Face
			glNormal3f  0.0,-1.0, 0.0                             '' Normal Pointing Down
			glTexCoord2f 1.0, 1.0 : glVertex3f -1.0, -1.0, -1.0   '' (Bottom)
			glTexCoord2f 0.0, 1.0 : glVertex3f  1.0, -1.0, -1.0
			glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0
			glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0
			'' Right face
			glNormal3f  1.0, 0.0, 0.0                             '' Normal Pointing Right
			glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0, -1.0   '' (Right)
			glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0
			glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0,  1.0
			glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0
			'' Left Face
			glNormal3f -1.0, 0.0, 0.0                             '' Normal Pointing Left
			glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0, -1.0   '' (Left)
			glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0
			glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0,  1.0
			glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0
		glEnd                                                     '' Done Drawing Quads

		xrot = xrot + xspeed                       '' Add xspeed To xrot
		yrot = yrot + yspeed                       '' Add yspeed To yrot

		'' Keyboard handlers
		if MULTIKEY(FB.SC_L) and not lp then          '' L Key down
			lp = true
			light = not light                      '' toggle light on /off
			if (not light) then
				glDisable(GL_LIGHTING)             '' disable lighting
			else
				glEnable(GL_LIGHTING)              '' enable lighting
			end if
		end if
		if not MULTIKEY(FB.SC_L) then lp = false      '' L key up

		if MULTIKEY(FB.SC_F) and not fp then          '' F Key down
			fp = true
			filter += 1                            '' Cycle filter 0 -> 1 -> 2
			if (filter > 2) then filter = 0        '' 2 -> 0
		end if
		if not MULTIKEY(FB.SC_F) then fp = false      '' F Key Up

		if MULTIKEY(FB.SC_G) and not gp then          '' G Key down
			gp = true
			fogfilter += 1                         '' Cycle filter 0 -> 1 -> 2
			if (fogfilter > 2) then fogfilter = 0  '' 2 -> 0
			glFogi GL_FOG_MODE, fogMode(fogfilter) '' Fog Mode
		end if
		if not MULTIKEY(FB.SC_G) then gp = false      '' G Key Up

		if MULTIKEY(FB.SC_PAGEUP) then z-=0.02        '' If Page Up is Being Pressed, Move Into The Screen
		if MULTIKEY(FB.SC_PAGEDOWN) then z+=0.02      '' If Page Down is Being Pressed, Move Towards The Viewer
		if MULTIKEY(FB.SC_UP) then xspeed-=0.01       '' If Up Arrow is Being Pressed, Decrease xspeed
		if MULTIKEY(FB.SC_DOWN) then xspeed+=0.01     '' If Down Arrow Being Pressed, Increase xspeed
		if MULTIKEY(FB.SC_RIGHT) then yspeed+=0.01    '' If Right Arrow Being Pressed, Increase yspeed
		if MULTIKEY(FB.SC_LEFT) then yspeed-=0.01     '' If Left Arrow Being Pressed, Decrease yspeed

		flip                                       '' filp or crash
		if inkey = chr(255)+"k" then exit do     '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0             '' exit if EXC is pressed
	'' Empty keyboard buffer
	while inkey <> "": wend
	end

