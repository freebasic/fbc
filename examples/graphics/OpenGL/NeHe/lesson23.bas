''
''      This Code Was Created By Jeff Molofee and GB Schmick 2000
''      A HUGE Thanks To Fredric Echols For Cleaning Up
''      And Optimizing The Base Code, Making It More Flexible!
''      If You've Found This Code Useful, Please Let Me Know.
''      Visit Our Sites At www.tiptup.com and nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' Use arrow keys to rotate object, PgUp, PgDn to Zooom in and out
'' L Key cycles turns ligth on/off
'' F Key cycles filters
'' Sp Key cycles objects
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson23.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "createtex.bi"

declare sub glDrawCube()

	dim light as integer                                   '' Lighting ON/OFF
	dim gloop as integer                                   '' Generic Loop1

	dim xrot as single                                     '' X Rotation
	dim yrot as single                                     '' Y Rotation

	dim xspeed as single                                   '' X Rotation Speed
	dim yspeed as single                                   '' Y Rotation Speed
	dim z as single = -10.0                                '' Depth Into The Screen

	dim quadratic as GLUquadricObj ptr                     '' Storage For Our Quadratic Objects

	dim LightAmbient(0 to 3) as single => {0.5, 0.5, 0.5, 1.0}   '' Ambient Light Values
	dim LightDiffuse(0 to 3) as single => {1.0, 1.0, 1.0, 1.0}   '' Diffuse Light Values
	dim LightPosition(0 to 3) as single => {0.0, 0.0, 2.0, 1.0}  '' Light Position
	dim as integer lp, fp, sp

	dim filter as single                                   '' Which Filter To Use
	dim texture(0 to 5) as uinteger                        '' Storage For 6 Textures (MODIFIED)

	dim object_ as uinteger = 1                            '' Which Object To Draw

	windowtitle "NeHe & TipTup's Environment Mapping Tutorial"   '' Set window title
	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity

	'' All Setup For OpenGL Goes Here

	'' Use BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte     '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/BG.bmp", @buffer(0)                       '' BLOAD the bitmap
	texture(0) = CreateTexture(@buffer(0),TEX_NOFILTER)   '' Nearest Texture
	texture(2) = CreateTexture(@buffer(0))                '' Linear Texture (default)
	texture(4) = CreateTexture(@buffer(0),TEX_MIPMAP)     '' MipMapped Texture
	bload exepath + "/data/Reflect.bmp", @buffer(0)                  '' BLOAD the bitmap
	texture(1) = CreateTexture(@buffer(0),TEX_NOFILTER)   '' Nearest Texture
	texture(3) = CreateTexture(@buffer(0))                '' Linear Texture (default)
	texture(5) = CreateTexture(@buffer(0),TEX_MIPMAP)     '' MipMapped Texture
	'' Exit if error loading textures
	if (texture(0) or texture(1) or texture(2) or texture(3) _
			or texture(4) or texture(5)) = NULL then end 1

	glEnable GL_TEXTURE_2D                                '' Enable Texture Mapping
	glShadeModel GL_SMOOTH                                '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                       '' Black Background
	glClearDepth 1.0                                      '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                                '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                                 '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST      '' Really Nice Perspective Calculations


	glLightfv GL_LIGHT1, GL_AMBIENT, @LightAmbient(0)     '' Setup The Ambient Light
	glLightfv GL_LIGHT1, GL_DIFFUSE, @LightDiffuse(0)     '' Setup The Diffuse Light
	glLightfv GL_LIGHT1, GL_POSITION,@LightPosition(0)    '' Position The Light
	glEnable GL_LIGHT1                                    '' Enable Light One

	quadratic = gluNewQuadric()                           '' Create A Pointer To The Quadric Object
	gluQuadricNormals quadratic, GLU_SMOOTH               '' Create Smooth Normals
	gluQuadricTexture quadratic, GL_TRUE                  '' Create Texture Coords

	glTexGeni GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP    '' Set The Texture Generation Mode For S To Sphere Mapping (NEW)
	glTexGeni GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP    '' Set The Texture Generation Mode For T To Sphere Mapping (NEW)

	do

		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear The Screen And The Depth Buffer
		glLoadIdentity                                          '' Reset The View
		glTranslatef 0.0,0.0,z

		glEnable GL_TEXTURE_GEN_S                               '' Enable Texture Coord Generation For S  NEW
		glEnable GL_TEXTURE_GEN_T                               '' Enable Texture Coord Generation For T  NEW

		glBindTexture GL_TEXTURE_2D, texture(filter*2 + 1)      '' This Will Select The Sphere Map (1, 3 or 5)
		glPushMatrix
			glRotatef xrot,1.0,0.0,0.0
			glRotatef yrot,0.0,1.0,0.0
			select case object_
			case 0
				glDrawCube()
			case 1
				glTranslatef 0.0, 0.0, -1.5                     '' Center The Cylinder
				gluCylinder quadratic, 1.0, 1.0, 3.0, 32, 32    '' A Cylinder With A Radius Of 0.5 And A Height Of 2
			case 2
				gluSphere quadratic,1.3, 32, 32                 '' Draw A Sphere With A Radius Of 1 And 16 Longitude And 16 Latitude Segments
			case 3
				glTranslatef 0.0, 0.0, -1.5                     '' Center The Cone
				gluCylinder quadratic, 1.0, 0.0, 3.0, 32, 32    '' A Cone With A Bottom Radius Of .5 And A Height Of 2
			end select

		glPopMatrix
		glDisable GL_TEXTURE_GEN_S
		glDisable GL_TEXTURE_GEN_T

		glBindTexture GL_TEXTURE_2D, texture(filter*2)          '' This Will Select The BG Maps...
		glPushMatrix
			glTranslatef 0.0, 0.0, -24.0
			glBegin GL_QUADS
				glNormal3f  0.0, 0.0, 1.0
				glTexCoord2f 0.0, 0.0 : glVertex3f -13.3, -10.0,  10.0
				glTexCoord2f 1.0, 0.0 : glVertex3f  13.3, -10.0,  10.0
				glTexCoord2f 1.0, 1.0 : glVertex3f  13.3,  10.0,  10.0
				glTexCoord2f 0.0, 1.0 : glVertex3f -13.3,  10.0,  10.0
			glEnd
		glPopMatrix

		xrot = xrot + xspeed
		yrot = yrot + yspeed

		'' Keyboard handlers
		if MULTIKEY(FB.SC_L) and not lp then          '' L Key down
			lp = TRUE
			light = not light
			if not light then
				glDisable(GL_LIGHTING)
			else
				glEnable(GL_LIGHTING)
			end if
		end if
		if MULTIKEY(FB.SC_L) = FALSE then lp = false      '' L Key Up

		if MULTIKEY(FB.SC_F) and not fp then          '' F Key down
			fp = true
			filter += 1                            '' Cycle filter 0 -> 1 -> 2
			if (filter > 2) then filter = 0        '' 2 -> 0
		end if
		if MULTIKEY(FB.SC_F) = FALSE then fp = false      '' F Key Up

		if MULTIKEY(FB.SC_SPACE) and not sp then      '' Space Key down
			sp = true
			object_ += 1                           '' Select next object
			if object_>3 then object_ = 0
		end if
		if MULTIKEY(FB.SC_SPACE) = FALSE then sp = false  '' Space Key Up

		if MULTIKEY(FB.SC_PAGEUP) then z-=0.02        '' If Page Up is Being Pressed, Move Into The Screen
		if MULTIKEY(FB.SC_PAGEDOWN) then z+=0.02      '' If Page Down is Being Pressed, Move Towards The Viewer
		if MULTIKEY(FB.SC_UP) then xspeed-=0.01       '' If Up Arrow is Being Pressed, Decrease xspeed
		if MULTIKEY(FB.SC_DOWN) then xspeed+=0.01     '' If Down Arrow Being Pressed, Increase xspeed
		if MULTIKEY(FB.SC_RIGHT) then yspeed+=0.01    '' If Right Arrow Being Pressed, Increase yspeed
		if MULTIKEY(FB.SC_LEFT) then yspeed-=0.01     '' If Left Arrow Being Pressed, Decrease yspeed

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do     '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend

	end

''------------------------------------------------------------------------------
sub glDrawCube()
	glBegin GL_QUADS
		'' Front Face
		glNormal3f  0.0, 0.0, 1.0
		glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0,  1.0
		glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0,  1.0
		glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0,  1.0
		glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0,  1.0
		'' Back Face
		glNormal3f  0.0, 0.0,-1.0
		glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0, -1.0
		glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0, -1.0
		glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0, -1.0
		glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0, -1.0
		'' Top Face
		glNormal3f  0.0, 1.0, 0.0
		glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0
		glTexCoord2f 0.0, 0.0 : glVertex3f -1.0,  1.0,  1.0
		glTexCoord2f 1.0, 0.0 : glVertex3f  1.0,  1.0,  1.0
		glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0
		'' Bottom Face
		glNormal3f  0.0,-1.0, 0.0
		glTexCoord2f 1.0, 1.0 : glVertex3f -1.0, -1.0, -1.0
		glTexCoord2f 0.0, 1.0 : glVertex3f  1.0, -1.0, -1.0
		glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0
		glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0
		'' Right Face
		glNormal3f  1.0, 0.0, 0.0
		glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0, -1.0
		glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0
		glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0,  1.0
		glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0
		'' Left Face
		glNormal3f -1.0, 0.0, 0.0
		glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0, -1.0
		glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0
		glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0,  1.0
		glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0
	glEnd
end sub

