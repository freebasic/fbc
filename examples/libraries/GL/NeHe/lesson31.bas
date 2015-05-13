''		This Code Was Created By Brett Porter For NeHe Productions 2000
''		Visit NeHe Productions At http://nehe.gamedev.net
''
''		Visit Brett Porter's Web Page at
''		http://www.geocities.com/brettporter/programming
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson31.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = 0


#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                '' for Scan code constants
#include once "milkshapemodel.bi"
#include once "bmpload.bi"

''------------------------------------------------------------------------------
'' Declare user functions
declare function InitGL() as integer
''------------------------------------------------------------------------------
'' Declare Global Variables
dim shared MilkShapeModel as MODEL             '' Holds The Model Data


	dim yrot as single                         '' Y Rotation
	Model_Init varptr(MilkShapeModel)
	Model_LoadModelData (varptr(MilkShapeModel), exepath + "/data/Model.ms3d")
	windowtitle "Brett Porter & NeHe's MilkShape Model Rendering Tutorial"   '' Set window title
	screen 18, 32, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                  '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                 '' Select The Projection Matrix
	glLoadIdentity                             '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 1.0, 1000.0  '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                  '' Select The Modelview Matrix
	glLoadIdentity                             '' Reset The Projection Matrix

	InitGL()                                   '' All Setup For OpenGL Goes Here

	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT  '' Clear The Screen And The Depth Buffer
		glLoadIdentity                                      '' Reset The Modelview Matrix
		gluLookAt 75, 75, 75, 0, 0, 0, 0, 1, 0              '' (3) Eye Postion (3) Center Point (3) Y-Axis Up Vector

		glRotatef yrot, 0.0, 1.0, 0.0                       '' Rotate On The Y-Axis By yrot

		Model_Draw (@MilkShapeModel)                        '' Draw The Model

		yrot + = 1.0f                                       '' Increase yrot By One

		flip
		if inkey = chr(255)+"k" then exit do              '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while inkey <> "": wend

	end


''------------------------------------------------------------------------------
'' This Will Be Called Right After The GL Window Is Set up
function InitGL() as integer

	Model_ReloadTextures (@MilkShapeModel)               '' Loads Model Textures

	glEnable GL_TEXTURE_2D                               '' Enable Texture Mapping ( NEW )
	glShadeModel GL_SMOOTH                               '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                      '' Black Background
	glClearDepth 1.0                                     '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                               '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                                '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST     '' Really Nice Perspective Calculations
	InitGL = true
end function

