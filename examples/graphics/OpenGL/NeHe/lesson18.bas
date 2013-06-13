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
'' Space key to cycle quadratics (0=Cube, 1=Cylinder, 2=Cylinder, 3=CD shape
'' 4=Sphere, 5=Cone & 6=CD Shape segments
'' PgUp key and PgDn key to Zoom in and out
'' UpArrow, DnArrow, RightArrow, Left Arrow to change rotate speed of cube
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson18.bas



#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "createtex.bi"

'' Setup our booleans
const false = 0
const true  = not false

declare sub glDrawCube()

	dim texture(0 to 2) as uinteger         '' Storage For 3 Textures

	dim filter as uinteger                  '' Which Filter To Use
	dim light as integer                    '' Lighting ON/OFF
	dim lp as integer                       '' L Pressed?
	dim fp as integer                       '' F Pressed?
	dim sp as integer                       '' Spacebar Pressed? ( NEW )

	dim LightAmbient(0 to 3) as single => {0.5, 0.5, 0.5, 1.0}   '' Ambient Light Values
	dim LightDiffuse(0 to 3) as single => {1.0, 1.0, 1.0, 1.0}   '' Diffuse Light Values
	dim LightPosition(0 to 3) as single => {0.0, 0.0, 2.0, 1.0}  '' Light Position

	dim xrot as single                             '' X Rotation
	dim yrot as single                             '' Y Rotation
	dim xspeed as single                           '' X Rotation Speed
	dim yspeed as single                           '' Y Rotation Speed
	dim z as single = -5.0                         '' Depth Into The Screen

	dim part1 as integer                           '' Start Of Disc ( NEW )
	dim part2 as integer                           '' End Of Disc ( NEW )
	dim p1 as integer                              '' Increase 1 ( NEW )
	dim p2 as integer = 1                          '' Increase 2 ( NEW )
	dim object_ as uinteger                        '' Which Object To Draw (NEW)


	dim quadratic as GLUquadricObj ptr             '' Storage For Our Quadratic Objects ( NEW )

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix

	'' Use BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte       '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Wall.bmp", @buffer(0)         '' BLOAD the bitmap
	texture(0) = CreateTexture(@buffer(0),TEX_NOFILTER)  '' Nearest Texture
	texture(1) = CreateTexture(@buffer(0))               '' Linear Texture (default)
	texture(2) = CreateTexture(@buffer(0),TEX_MIPMAP)    '' MipMapped Texture
	'' Exit if error loading textures
	if texture(0) = 0 or texture(1) = 0 or texture(2) = 0 then end 1

	'' All Setup For OpenGL Goes Here
	glEnable GL_TEXTURE_2D                                  '' Enable Texture Mapping ( NEW )
	glShadeModel GL_SMOOTH                                  '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                         '' Black Background
	glClearDepth 1.0                                        '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                                  '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                                   '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST        '' Really Nice Perspective Calculations


	glLightfv GL_LIGHT1, GL_AMBIENT, @LightAmbient(0)       '' Setup The Ambient Light
	glLightfv GL_LIGHT1, GL_DIFFUSE, @LightDiffuse(0)       '' Setup The Diffuse Light
	glLightfv GL_LIGHT1, GL_POSITION, @LightPosition(0)     '' Position The Light
	glEnable GL_LIGHT1                                      '' Enable Light One

	quadratic = gluNewQuadric                               '' Create A Pointer To The Quadric Object (Return 0 If No Memory) (NEW)
	gluQuadricNormals quadratic, GLU_SMOOTH                 '' Create Smooth Normals (NEW)
	gluQuadricTexture quadratic, GL_TRUE                    '' Create Texture Coords (NEW)

	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT    '' Clear The Screen And The Depth Buffer
		glLoadIdentity                                        '' Reset The View
		glTranslatef 0.0, 0.0, z                              '' Translate Into The Screen

		glRotatef xrot, 1.0, 0.0, 0.0                         '' Rotate On The X Axis
		glRotatef yrot, 0.0, 1.0, 0.0                         '' Rotate On The Y Axis

		glBindTexture GL_TEXTURE_2D, texture(filter)          '' Select A Filtered Texture

		'' This Section Of Code Is New ( NEW )
		select case object_                               '' Check object To Find Out What To Draw
		case 0
			glDrawCube                                    '' Draw Our Cube
		case 1
			glTranslatef 0.0, 0.0, -1.5                   '' Center The Cylinder
			gluCylinder quadratic, 1.0, 1.0, 3.0, 32, 32  '' A Cylinder With A Radius Of 0.5 And A Height Of 2
		case 2
			gluDisk quadratic, 0.5, 1.5, 32, 32           '' Draw A Disc (CD Shape) With An Inner Radius Of 0.5, And An Outer Radius Of 2.  Plus A Lot Of Segments ;)
		case 3
			gluSphere quadratic, 1.3, 32, 32              '' Draw A Sphere With A Radius Of 1 And 16 Longitude And 16 Latitude Segments
		case 4
			glTranslatef 0.0, 0.0, -1.5                   '' Center The Cone
			gluCylinder quadratic, 1.0, 0.0, 3.0, 32, 32  '' A Cone With A Bottom Radius Of .5 And A Height Of 2
		case 5:
			part1 = part1 + p1                      '' Increase Start Angle
			part2 = part2 + p2                      '' Increase Sweep Angle

			if part1>359 then                       '' 360 Degrees
				p1=0                                '' Stop Increasing Start Angle
				part1=0                             '' Set Start Angle To Zero
				p2=1                                '' Start Increasing Sweep Angle
				part2=0                             '' Start Sweep Angle At Zero
			end if
			if part2>359 then                       '' 360 Degrees
				p1=1                                '' Start Increasing Start Angle
				p2=0                                '' Stop Increasing Sweep Angle
			end if
			gluPartialDisk quadratic, 0.5, 1.5, 32, 32, part1, part2-part1     ' A Disk Like The One Before

		end select

		xrot = xrot + xspeed                      '' Increase Rotation On X Axis
		yrot = yrot + yspeed                      '' Increase Rotation On Y Axis
		'' Keyboard handlers
		if MULTIKEY(FB.SC_L) and not lp then         '' L Key down
			lp = true
			light = not light                     '' toggle light on /off
			if (not light) then
				glDisable(GL_LIGHTING)            '' disable lighting
			else
				glEnable(GL_LIGHTING)             '' enable lighting
			end if
		end if
		if not MULTIKEY(FB.SC_L) then lp = false     '' L key up

		if MULTIKEY(FB.SC_F) and not fp then         '' F Key down
			fp = true
			filter += 1                           '' Cycle filter 0 -> 1 -> 2
			if (filter > 2) then filter = 0       '' 2 -> 0
		end if
		if not MULTIKEY(FB.SC_F) then fp = false     '' F Key Up

		if MULTIKEY(FB.SC_SPACE) and not sp then     '' Space Key down
			sp = TRUE                             '' Set sp To TRUE
			object_ += 1                            '' Cycle Through The Objects
			if object_>5 then object_=0             '' (0-5) = 6 objects
		end if
		if not MULTIKEY(FB.SC_SPACE) then sp = false '' Space Key Up

		if MULTIKEY(FB.SC_PAGEUP) then z-=0.02     '' If Page Up is Being Pressed, Move Into The Screen
		if MULTIKEY(FB.SC_PAGEDOWN) then z+=0.02   '' If Page Down is Being Pressed, Move Towards The Viewer
		if MULTIKEY(FB.SC_UP) then xspeed-=0.01    '' If Up Arrow is Being Pressed, Decrease xspeed
		if MULTIKEY(FB.SC_DOWN) then xspeed+=0.01  '' If Down Arrow Being Pressed, Increase xspeed
		if MULTIKEY(FB.SC_RIGHT) then yspeed+=0.01 '' If Right Arrow Being Pressed, Increase yspeed
		if MULTIKEY(FB.SC_LEFT) then yspeed-=0.01  '' If Left Arrow Being Pressed, Decrease yspeed

		flip  '' flip or crash
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend

	gluDeleteQuadric quadratic 				'' Delete Quadratic - Free Resources
	end
'------------------------------------------------------------------------
sub glDrawCube()
	glBegin GL_QUADS            '' Start Drawing Quads
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
	glEnd                        '' Done Drawing Quads
end sub
