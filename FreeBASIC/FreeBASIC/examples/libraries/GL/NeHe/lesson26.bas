''  This code has been created by Banu Cosmin aka Choko - 20 may 2000
'' 	and uses NeHe tutorials as a starting point (window initialization,
'' 	texture loading, GL initialization and code for keypresses) - very good
'' 	tutorials, Jeff. If anyone is interested about the presented algorithm
'' 	please e-mail me at boct@romwest.ro
''
''	Code Commmenting And Clean Up By Jeff Molofee ( NeHe )
'' 	NeHe Productions	...		http://nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' PgUp increases the height of the ball
'' PgDn decreases the height of the ball
'' Down Arrow increases speed on X axis
'' Up Arrow decreases speed on X axis
'' Right Arrow increases speed of y axis
'' Left Arrow decreases speed on Y axis
'' A Moves closer to the ball
'' Z Move further away from the ball
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson26.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "createtex.bi"

declare sub DrawObject()
declare sub DrawFloor()

dim shared texture(0 to 2) as uinteger                     '' 3 Textures
dim shared q as GLUquadricObj ptr                          '' Quadratic For Drawing A Sphere

	dim as single xrot = 0.0                               '' X Rotation
	dim as single yrot = 0.0                               '' Y Rotation
	dim as single xrotspeed = 0.0                          '' X Rotation Speed
	dim as single yrotspeed = 0.0                          '' Y Rotation Speed
	dim as single zoom = -7.0                              '' Depth Into The Screen
	dim as single height = 2.0                             '' Height Of Ball From Floor

	'' Light Parameters
	dim LightAmb(0 to 3) as single => {0.7, 0.7, 0.7, 1.0}     '' Ambient Light
	dim LightDif(0 to 3) as single => {1.0, 1.0, 1.0, 1.0}     '' Diffuse Light
	dim LightPos(0 to 3) as single => {4.0 , 4.0 , 6.0 , 1.0}  '' Light Position

	' Clip Plane Equations
	dim eqr(0 to 3) as double => {0.0, - 1.0, 0.0, 0.0}        '' Plane Equation To Use For The Reflected Objects

	screen 18, 16, , FB.GFX_OPENGL or FB.GFX_STENCIL_BUFFER
	windowtitle "Banu Octavian & NeHe's Stencil & Reflection Tutorial"   '' Set window title

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                    '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                   '' Select The Projection Matrix
	glLoadIdentity                               '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 0.1, 100.0     '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                    '' Select The Modelview Matrix
	glLoadIdentity                               '' Reset The Projection Matrix

	'' All Setup For OpenGL Goes Here
	redim buffer(256*256*4+4) as ubyte           '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Envwall.bmp", @buffer(0)         '' BLOAD data from bitmap
	texture(0) = CreateTexture(@buffer(0))       '' GL_LINEAR Texture
	bload exepath + "/data/Ball.bmp", @buffer(0)            '' BLOAD data from bitmap
	texture(1) = CreateTexture(@buffer(0))       '' GL_LINEAR Texture
	bload exepath + "/data/Envroll.bmp", @buffer(0)         '' BLOAD data from bitmap
	texture(2) = CreateTexture(@buffer(0))       '' GL_LINEAR Texture
	if (texture(0) or texture(1) or texture(2)) = 0 then end 1  '' Exit if error loading data files

	glShadeModel (GL_SMOOTH)                     '' Enable Smooth Shading
	glClearColor (0.2, 0.5, 1.0, 1.0)            '' Background
	glClearDepth (1.0)                           '' Depth Buffer Setup
	glClearStencil (0)                           '' Clear The Stencil Buffer To 0
	glEnable (GL_DEPTH_TEST)                     '' Enables Depth Testing
	glDepthFunc (GL_LEQUAL)                      '' The Type Of Depth Testing To Do
	glHint (GL_PERSPECTIVE_CORRECTION_HINT , GL_NICEST)     '' Really Nice Perspective Calculations
	glEnable (GL_TEXTURE_2D)                     '' Enable 2D Texture Mapping

	glLightfv GL_LIGHT0 , GL_AMBIENT , @LightAmb(0)         '' Set The Ambient Lighting For Light0
	glLightfv GL_LIGHT0 , GL_DIFFUSE , @LightDif(0)         '' Set The Diffuse Lighting For Light0
	glLightfv GL_LIGHT0 , GL_POSITION , @LightPos(0)        '' Set The Position For Light0

	glEnable (GL_LIGHT0)                                    '' Enable Light 0
	glEnable (GL_LIGHTING)                                  '' Enable Lighting

	q = gluNewQuadric ()                                    '' Create A New Quadratic
	gluQuadricNormals (q , GL_SMOOTH)                       '' Generate Smooth Normals For The Quad
	gluQuadricTexture (q , GL_TRUE)                         '' Enable Texture Coords For The Quad

	glTexGeni (GL_S , GL_TEXTURE_GEN_MODE , GL_SPHERE_MAP)  '' Set Up Sphere Mapping
	glTexGeni (GL_T , GL_TEXTURE_GEN_MODE , GL_SPHERE_MAP)  '' Set Up Sphere Mapping

	do
		glClear GL_COLOR_BUFFER_BIT  or  GL_DEPTH_BUFFER_BIT  or  GL_STENCIL_BUFFER_BIT
		glLoadIdentity                        '' Reset The Modelview Matrix
		glTranslatef 0.0, - 0.6, zoom         '' Zoom And Raise Camera Above The Floor (Up 0.6 Units)
		glColorMask 0, 0, 0, 0                '' Set Color Mask
		glEnable GL_STENCIL_TEST              '' Enable Stencil Buffer For "marking" The Floor
		glStencilFunc GL_ALWAYS, 1, 1         '' Always Passes, 1 Bit Plane, 1 As Mask
		glStencilOp GL_KEEP, GL_KEEP, GL_REPLACE      '' We Set The Stencil Buffer To 1 Where We Draw Any Polygon
		                                              '' Keep If Test Fails, Keep If Test Passes But Buffer Test Fails
		                                              '' Replace If Test Passes
		glDisable GL_DEPTH_TEST                       '' Disable Depth Testing
		DrawFloor()                                   '' Draw The Floor (Draws To The Stencil Buffer)
		                                              '' We Only Want To Mark It In The Stencil Buffer
		glEnable GL_DEPTH_TEST                        '' Enable Depth Testing
		glColorMask 1, 1, 1, 1                        '' Set Color Mask to TRUE, TRUE, TRUE, TRUE
		glStencilFunc GL_EQUAL, 1, 1                  '' We Draw Only Where The Stencil Is 1
		                                              '' (I.E. Where The Floor Was Drawn)
		glStencilOp GL_KEEP, GL_KEEP, GL_KEEP         '' Don't Change The Stencil Buffer
		glEnable GL_CLIP_PLANE0                       '' Enable Clip Plane For Removing Artifacts
		                                              '' (When The Object Crosses The Floor)
		glClipPlane GL_CLIP_PLANE0, @eqr(0)           '' Equation For Reflected Objects
		glPushMatrix                                  '' Push The Matrix Onto The Stack
			glScalef 1.0, - 1.0, 1.0                  '' Mirror Y Axis
			glLightfv GL_LIGHT0 , GL_POSITION , @LightPos(0)   '' Set Up Light0
			glTranslatef 0.0, height, 0.0             '' Position The Object
			glRotatef xrot, 1.0, 0.0, 0.0             '' Rotate Local Coordinate System On X Axis
			glRotatef yrot, 0.0, 1.0, 0.0             '' Rotate Local Coordinate System On Y Axis
			DrawObject()                              '' Draw The Sphere (Reflection)
		glPopMatrix                                   '' Pop The Matrix Off The Stack
		glDisable GL_CLIP_PLANE0                      '' Disable Clip Plane For Drawing The Floor
		glDisable GL_STENCIL_TEST                     '' We Don't Need The Stencil Buffer Any More (Disable)
		glLightfv GL_LIGHT0, GL_POSITION, @LightPos(0)         '' Set Up Light0 Position
		glEnable GL_BLEND                             '' Enable Blending (Otherwise The Reflected Object Wont Show)
		glDisable GL_LIGHTING                         '' Since We Use Blending, We Disable Lighting
		glColor4f 1.0, 1.0, 1.0, 0.8                  '' Set Color To White With 80% Alpha
		glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA       '' Blending Based On Source Alpha And 1 Minus Dest Alpha
		DrawFloor()                                   '' Draw The Floor To The Screen
		glEnable GL_LIGHTING                          '' Enable Lighting
		glDisable GL_BLEND                            '' Disable Blending
		glTranslatef 0.0, height, 0.0                 '' Position The Ball At Proper Height
		glRotatef xrot, 1.0, 0.0, 0.0                 '' Rotate On The X Axis
		glRotatef yrot, 0.0, 1.0, 0.0                 '' Rotate On The Y Axis
		DrawObject ()                                 '' Draw The Ball
		xrot += xrotspeed                             '' Update X Rotation Angle By xrotspeed
		yrot += yrotspeed                             '' Update Y Rotation Angle By yrotspeed
		glFlush ()                                    '' Flush The GL Pipeline

		'' Keyboard handlers
		if MULTIKEY(FB.SC_RIGHT) then                    '' Right Arrow Pressed (Increase yrotspeed)
			yrotspeed += 0.08
		end if
		if MULTIKEY(FB.SC_LEFT) then                     '' Left Arrow Pressed (Decrease yrotspeed)
			yrotspeed -= 0.08
		end if
		if MULTIKEY(FB.SC_DOWN) then                     '' Down Arrow Pressed (Increase xrotspeed)
			xrotspeed += 0.08
		end if
		if MULTIKEY(FB.SC_UP) then                       '' Up Arrow Pressed (Decrease xrotspeed)
			xrotspeed -= 0.08
		end if
		if MULTIKEY(FB.SC_A) then                        '' 'A' Key Pressed ... Zoom In
			zoom += 0.05
		end if
		if MULTIKEY(FB.SC_Z) then                        '' 'Z' Key Pressed ... Zoom Out
			zoom -= 0.05
		end if
		if MULTIKEY(FB.SC_PAGEUP) then                   '' Page Up Key Pressed Move Ball Up
			height += 0.03
		end if
		if MULTIKEY(FB.SC_PAGEDOWN) then                 '' Page Down Key Pressed Move Ball Down
			height -= 0.03
		end if
		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do        '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend


	end

'---------------------------------------------------
sub DrawObject()                              '' Draw Our Ball
	glColor3f 1.0, 1.0, 1.0                   '' Set Color To White
	glBindTexture GL_TEXTURE_2D, texture(1)   '' Select Texture 2 (1)
	gluSphere q, 0.35, 32, 16                 '' Draw First Sphere

	glBindTexture GL_TEXTURE_2D, texture(2)   '' Select Texture 3 (2)
	glColor4f 1.0, 1.0, 1.0, 0.4              '' Set Color To White With 40% Alpha
	glEnable GL_BLEND                         '' Enable Blending
	glBlendFunc GL_SRC_ALPHA, GL_ONE          '' Set Blending Mode To Mix Based On SRC Alpha
	glEnable GL_TEXTURE_GEN_S                 '' Enable Sphere Mapping
	glEnable GL_TEXTURE_GEN_T                 '' Enable Sphere Mapping

	gluSphere q, 0.35, 32, 16                 '' Draw Another Sphere Using New Texture
	                                          '' Textures Will Mix Creating A MultiTexture Effect (Reflection)
	glDisable GL_TEXTURE_GEN_S                '' Disable Sphere Mapping
	glDisable GL_TEXTURE_GEN_T                '' Disable Sphere Mapping
	glDisable GL_BLEND                        '' Disable Blending
end sub

'---------------------------------------------------
sub DrawFloor()                               '' Draws The Floor
	glBindTexture GL_TEXTURE_2D, texture(0)   '' Select Texture 1 (0)
	glBegin GL_QUADS                          '' Begin Drawing A Quad
		glNormal3f 0.0, 1.0, 0.0              '' Normal Pointing Up
		glTexCoord2f 0.0, 1.0                 '' Bottom Left Of Texture
		glVertex3f - 2.0, 0.0, 2.0            '' Bottom Left Corner Of Floor
		glTexCoord2f 0.0, 0.0                 '' Top Left Of Texture
		glVertex3f - 2.0, 0.0, - 2.0          '' Top Left Corner Of Floor
		glTexCoord2f 1.0, 0.0                 '' Top Right Of Texture
		glVertex3f 2.0, 0.0, - 2.0            '' Top Right Corner Of Floor
		glTexCoord2f 1.0, 1.0                 '' Bottom Right Of Texture
		glVertex3f 2.0, 0.0, 2.0              '' Bottom Right Corner Of Floor
	glEnd                                     '' Done Drawing The Quad
end sub
