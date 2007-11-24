''
''    This Code Was Created By Jeff Molofee 2000
''    A HUGE Thanks To Fredric Echols For Cleaning Up
''    And Optimizing The Base Code, Making It More Flexible!
''    If You've Found This Code Useful, Please Let Me Know.
''    Visit My Site At nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' Use arrow keys to rotate cubes
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson12.bas



#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"        '' for Scan code constants
#include once "createtex.bi"

'' Setup our booleans
const FALSE = 0
const TRUE  = not FALSE

declare sub BuildLists()

dim shared box as uinteger               '' Storage For The Box Display List
dim shared top as uinteger               '' Storage For The Top Display List

	dim texture(0) as uinteger               '' Storage For One Texture
	dim xloop as uinteger                    '' Loop For X Axis
	dim yloop as uinteger                    '' Loop For Y Axis

	dim xrot as single                       '' Rotates Cube On The X Axis
	dim yrot as single                       '' Rotates Cube On The Y Axis

	dim boxcol(0 to 4, 0 to 2) as single => { _   '' Array For Box Colors
		{1.0, 0.0, 0.0}, _     '' Bright: Red,
		{1.0, 0.5, 0.0}, _     '' Bright: Orange,
		{1.0, 1.0, 0.0}, _     '' Bright: Yellow,
		{0.0 ,1.0, 0.0}, _     '' Bright: Green,
		{0.0, 1.0, 1.0}}       '' Bright: Blue

	dim topcol(0 to 4, 0 to 2) as single => { _   '' Array For Top Colors
		{ .5, 0.0, 0.0}, _     '' Dark: Red,
		{0.5, 0.25,0.0}, _     '' Dark: Orange,
		{0.5, 0.5, 0.0}, _     '' Dark: Yellow,
		{0.0, 0.5, 0.0}, _     '' Dark: Green,
		{0.0, 0.5, 0.5}}       '' Dark: Blue

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix

	'' Use BLOAD to load the bitmaps.
	redim buffer(128*128*4+4) as ubyte             '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Cube.bmp", @buffer(0)
	texture(0) = CreateTexture(@buffer(0))         '' Cube Texture
	if texture(0) = 0 then end 1                   '' Exit if error loading data file

	'' All Setup For OpenGL Goes Here
	BuildLists()                                   '' Jump To The Code That Creates Our Display Lists

	glEnable GL_TEXTURE_2D                         '' Enable Texture Mapping
	glShadeModel GL_SMOOTH                         '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                '' Black Background
	glClearDepth 1.0                               '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                         '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                          '' The Type Of Depth Testing To Do
	glEnable GL_LIGHT0                             '' Quick And Dirty Lighting (Assumes Light0 Is Set Up)
	glEnable GL_LIGHTING                           '' Enable Lighting
	glEnable GL_COLOR_MATERIAL                          '' Enable Material Coloring
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST    '' Really Nice Perspective Calculations


	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT        '' Clear Screen And Depth Buffer
		glBindTexture GL_TEXTURE_2D, texture(0)                   '' Select The Texture
		for yloop=1 to 5                                          '' Loop Through The Y Plane
			for xloop=0 to yloop - 1                              '' Loop Through The X Plane
				glLoadIdentity                                    '' Reset The View
				'' Position The Cubes On The Screen
				glTranslatef 1.4+(xloop*2.8)-(yloop*1.4), ((6.0-yloop)*2.4)-7.0, -20.0
				glRotatef 45.0-(2.0*yloop) + xrot, 1.0, 0.0, 0.0    '' Tilt The Cubes Up And Down
				glRotatef 45.0 + yrot, 0.0, 1.0, 0.0                '' Spin Cubes Left And Right
				glColor3fv @boxcol(yloop-1,0)                       '' Select A Box Color
				glCallList box                                      '' Draw The Box
				glColor3fv @topcol(yloop-1,0)                       '' Select The Top Color
				glCallList top                                      '' Draw The Top
			next
		next

		'' keyboard handler
		if MULTIKEY(FB.SC_LEFT) then yrot = yrot - 0.2   '' If Left Arrow is Being Pressed, Spin Cubes Left
		if MULTIKEY(FB.SC_RIGHT) then yrot = yrot + 0.2  '' If Right Arrow is Being Pressed, Spin Cubes Right
		if MULTIKEY(FB.SC_UP) then xrot = xrot - 0.2     '' If Up Arrow Being Pressed, Tilt Cubes Up
		if MULTIKEY(FB.SC_DOWN) then xrot = xrot + 0.2   '' If Down Arrow Being Pressed, Tilt Cubes Down

		flip                                          '' filp or crash
		if inkey = chr(255)+"k" then exit do        '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0                '' exit if EXC is pressed

	while inkey <> "": wend
	end

''------------------------------------------------------------------------------
'' Build Cube Display Lists
sub BuildLists()
	box = glGenLists(2)                       '' Generate 2 Different Lists
	glNewList box, GL_COMPILE                 '' Start With The Box List
	glBegin GL_QUADS            '' Start Drawing Quads
		'' Bottom Face
		glNormal3f 0.0,-1.0, 0.0  '' This line of code is not in the HTML version of the tutorial!
		glTexCoord2f 1.0, 1.0 : glVertex3f -1.0, -1.0, -1.0   '' Top Right Of The Texture and Quad
		glTexCoord2f 0.0, 1.0 : glVertex3f  1.0, -1.0, -1.0   '' Top Left Of The Texture and Quad
		glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0   '' Bottom Left Of The Texture and Quad
		glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0   '' Bottom Right Of The Texture and Quad
		'' Front Face
		glNormal3f 0.0, 0.0, 1.0  '' This line of code is not in the HTML version of the tutorial!
		glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0,  1.0   '' Bottom Left Of The Texture and Quad
		glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0,  1.0   '' Bottom Right Of The Texture and Quad
		glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0,  1.0   '' Top Right Of The Texture and Quad
		glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0,  1.0   '' Top Left Of The Texture and Quad
		'' Back Face
		glNormal3f 0.0, 0.0,-1.0  '' This line of code is not in the HTML version of the tutorial!
		glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0, -1.0   '' Bottom Right Of The Texture and Quad
		glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0, -1.0   '' Top Right Of The Texture and Quad
		glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0, -1.0   '' Top Left Of The Texture and Quad
		glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0, -1.0   '' Bottom Left Of The Texture and Quad
		'' Right face
		glNormal3f 1.0, 0.0, 0.0  '' This line of code is not in the HTML version of the tutorial!
		glTexCoord2f 1.0, 0.0 : glVertex3f 1.0, -1.0, -1.0    '' Bottom Right Of The Texture and Quad
		glTexCoord2f 1.0, 1.0 : glVertex3f 1.0,  1.0, -1.0    '' Top Right Of The Texture and Quad
		glTexCoord2f 0.0, 1.0 : glVertex3f 1.0,  1.0,  1.0    '' Top Left Of The Texture and Quad
		glTexCoord2f 0.0, 0.0 : glVertex3f 1.0, -1.0,  1.0    '' Bottom Left Of The Texture and Quad
		'' Left Face
		glNormal3f -1.0, 0.0, 0.0  '' This line of code is not in the HTML version of the tutorial!
		glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0, -1.0   '' Bottom Left Of The Texture and Quad
		glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0   '' Bottom Right Of The Texture and Quad
		glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0,  1.0   '' Top Right Of The Texture and Quad
		glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0   '' Top Left Of The Texture and Quad
	glEnd                        '' Done Drawing Quads
	glEndList                    '' Done Building The box List

	top=box+1                                               '' Storage For "Top" Is "Box" Plus One
	glNewList top, GL_COMPILE                               '' Now The "Top" Display List

	glBegin GL_QUADS             '' Begin Building The top Display List
		'' Top Face
		glNormal3f 0.0, 1.0, 0.0
		glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0   '' Top Left Of The Texture and Quad
		glTexCoord2f 0.0, 0.0 : glVertex3f -1.0,  1.0,  1.0   '' Bottom Left Of The Texture and Quad
		glTexCoord2f 1.0, 0.0 : glVertex3f  1.0,  1.0,  1.0   '' Bottom Right Of The Texture and Quad
		glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0   '' Top Right Of The Texture and Quad
	glEnd                       '' Done Drawing Quad
	glEndList                   '' Done Building The top Display List

end sub
