'' This Code Was Created by Jens Schneider (WizardSoft) 2000
'' Lesson22 to the series of OpenGL tutorials by NeHe-Production
''
'' This Code is loosely based upon Lesson06 by Jeff Molofee.
''
'' contact me at: schneide@pool.informatik.rwth-aachen.de
''
'' Basecode Was Created By Jeff Molofee 2000
'' If You've Found This Code Useful, Please Let Me Know.
'' Visit My Site At nehe.gamedev.net
''
''
'' [HTML]: Point Out That Bump Maps Have To Be "Sharper" To Do Nice Effects!
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' Use arrow keys to rotate cubes, PgUp, PgDn to Zooom in and out
'' E Key toggles embos
'' M Key toggles multitexturing
'' B Key toggles bumpmaps
'' F Key cycles filters
''------------------------------------------------------------------------------
''
''  glfw code for lesson22
''
'' compile as: fbc -s gui lesson22.bas
''

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "GL/glfw.bi"
#include once "GL/glext.bi"
#include once "fbgfx.bi"            '' for Scan code constants
#include once "bmpload.bi"

const false = 0
const true = not false
const null = 0

#define __ARB_ENABLE 1              '' Used To Disable ARB Extensions Entirely
#define EXT_INFO 0
''#define EXT_INFO 1                '' Do You Want To See Your Extensions At Start-Up (windows only)?

#if EXT_INFO
#include once "win\user32.bi"     '' Needed by messagebox
#endif

'' Maximum Emboss-Translate. Increase To Get Higher Immersion
'' At A Cost Of Lower Quality (More Artifacts Will Occur!)
const MAX_EMBOSS = 0.008
''-------------------------------------------------------------------------------
declare sub ReSizeGLScene GLFWCALL( byval w as integer, byval h as integer )
declare function LoadGLTextures() as integer
declare function initMultitexture() as integer
declare sub initLights()
declare function DrawGLScene() as integer
declare sub VMatMult(byval M as single ptr, byval v as single ptr)
declare sub doCube ()
declare sub doLogo()
declare sub SetUpBumps(byval n as single ptr, byval c as single ptr, byval l as single ptr, byval s as single ptr, byval t as single ptr)
declare function  doMesh1TexelUnits() as integer
declare function doMesh2TexelUnits() as integer
declare function doMeshNoBumps() as integer

''-------------------------------------------------------------------------------
'' Here Comes The ARB-Multitexture Support.
'' There Are (Optimally) 6 New Commands To The OpenGL Set:
'' glMultiTexCoordifARB i=1..4 : Sets Texture-Coordinates For Texel-Pipeline #i
'' glActiveTextureARB          : Sets Active Texel-Pipeline
'' glClientActiveTextureARB    : Sets Active Texel-Pipeline For The Pointer-Array-Commands
''
'' There Are Even More For The Various Formats Of glMultiTexCoordi{f,fv,d,i}, But We Don't Need Them.
''

const MAX_EXTENSION_SPACE = 10240                          '' Characters for Extension-Strings
const MAX_EXTENSION_LENGTH = 256                           '' Maximum Of Characters In One Extension-String

dim shared multitextureSupported as integer                '' Flag Indicating Whether Multitexturing Is Supported
dim shared useMultitexture as integer = true               '' Use It If It Is Supported?
dim shared maxTexelUnits as integer = 1                    '' Number Of Texel-Pipelines. This Is At Least 1.

'' These are the types of the C++ functions we will link with at runtime if supported
dim shared glMultiTexCoord1fARB as PFNGLMULTITEXCOORD1FARBPROC
dim shared glMultiTexCoord2fARB as PFNGLMULTITEXCOORD2FARBPROC
dim shared glMultiTexCoord3fARB as PFNGLMULTITEXCOORD3FARBPROC
dim shared glMultiTexCoord4fARB as PFNGLMULTITEXCOORD4FARBPROC
dim shared glActiveTextureARB as PFNGLACTIVETEXTUREARBPROC
dim shared glClientActiveTextureARB as PFNGLCLIENTACTIVETEXTUREARBPROC


'' CubeData Contains The Faces For The Cube In Format 2xTexCoord, 3xVertex;
'' Note That The Tesselation Of The Cube Is Only Absolute Minimum.
dim shared CubeData(0 to 119) as single => { _
	0.0, 0.0,     -1.0, -1.0, +1.0, _   '' Front Face
	1.0, 0.0,     +1.0, -1.0, +1.0, _
	1.0, 1.0,     +1.0, +1.0, +1.0, _
	0.0, 1.0,     -1.0, +1.0, +1.0, _
	1.0, 0.0,     -1.0, -1.0, -1.0, _   '' Back face
	1.0, 1.0,     -1.0, +1.0, -1.0, _
	0.0, 1.0,     +1.0, +1.0, -1.0, _
	0.0, 0.0,     +1.0, -1.0, -1.0, _
	0.0, 1.0,     -1.0, +1.0, -1.0, _   '' Top face
	0.0, 0.0,     -1.0, +1.0, +1.0, _
	1.0, 0.0,     +1.0, +1.0, +1.0, _
	1.0, 1.0,     +1.0, +1.0, -1.0, _
	1.0, 1.0,     -1.0, -1.0, -1.0, _   '' Bottom face
	0.0, 1.0,     +1.0, -1.0, -1.0, _
	0.0, 0.0,     +1.0, -1.0, +1.0, _
	1.0, 0.0,     -1.0, -1.0, +1.0, _
	1.0, 0.0,     +1.0, -1.0, -1.0, _   '' Right face
	1.0, 1.0,     +1.0, +1.0, -1.0, _
	0.0, 1.0,     +1.0, +1.0, +1.0, _
	0.0, 0.0,     +1.0, -1.0, +1.0, _
	0.0, 0.0,     -1.0, -1.0, -1.0, _   '' Left face
	1.0, 0.0,     -1.0, -1.0,  1.0, _
	1.0, 1.0,     -1.0,  1.0,  1.0, _
	0.0, 1.0,     -1.0,  1.0, -1.0}

dim shared LightAmbient(0 to 2) as single => {0.2, 0.2, 0.2}   '' Ambient Light is 20% white
dim shared LightDiffuse(0 to 2) as single => {1.0, 1.0, 1.0}   '' Diffuse Light is white
dim shared LightPosition(0 to 2) as single => {0.0, 0.0, 2.0}  '' Position is somewhat in front of screen
dim shared texture(0 to 2) as uinteger                         '' Storage For 3 Textures
dim shared Gray(0 to 3) as single => {0.5, 0.5, 0.5, 1.0}
dim shared bump(0 to 2) as uinteger                            '' Our Bumpmappings
dim shared invbump(0 to 2) as uinteger                         '' Inverted Bumpmaps
dim shared glLogo as uinteger                                  '' Handle For OpenGL-Logo
dim shared multiLogo as uinteger                               '' Handle For Multitexture-Enabled-Logo

dim shared emboss as integer = false                           '' Emboss Only, No Basetexture?
dim shared bumps as integer = true                             '' Do Bumpmapping?

dim shared xrot as single                                      '' X Rotation
dim shared yrot as single                                      '' Y Rotation
dim shared xspeed as single                                    '' X Rotation Speed
dim shared yspeed as single                                    '' Y Rotation Speed
dim shared z as single =-5.0                                   '' Depth Into The Screen

dim shared filter as integer =1                                '' Which Filter To Use

	dim as integer mp, bp, fp, ep
	dim as integer running = 1

	'' Initialize GLFW
	glfwInit()
	'' Open an OpenGL window
	if( glfwOpenWindow( 640,480, 0,0,0,0,16,0, GLFW_WINDOW )= 0 ) then
		glfwTerminate()
		end 1
	end if

	glfwSetWindowTitle( "NeHe's Texture Mapping Tutorial" )

	'' Function to call when window is resized
	glfwSetWindowSizeCallback( @ReSizeGLScene )

	'' All Setup For OpenGL Goes Here
	multitextureSupported = initMultitexture()

	if ( not LoadGLTextures()) then end 1          '' Jump To Texture Loading Routine

	glEnable(GL_TEXTURE_2D)                                 '' Enable Texture Mapping
	glShadeModel(GL_SMOOTH)                                 '' Enable Smooth Shading
	glClearColor(0.0, 0.0, 0.0, 0.5)                        '' Black Background
	glClearDepth(1.0)                                       '' Depth Buffer Setup
	glEnable(GL_DEPTH_TEST)                                 '' Enables Depth Testing
	glDepthFunc(GL_LEQUAL)                                  '' The Type Of Depth Testing To Do
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)       '' Really Nice Perspective Calculations

	initLights()                                            '' Initialize OpenGL Light

	'' Main loop
	while( running )
		'' OpenGL rendering goes here...
		DrawGLScene()

		'' Swap front and back rendering buffers
		glfwSwapBuffers()

		'' Keyboard handlers
		if glfwGetKey(asc("E")) and not ep then          '' E Key down
			ep = true
			emboss = not emboss
		end if
		if glfwGetKey(asc("E")) = FALSE then ep = false      '' E Key Up

		if glfwGetKey(asc("M")) and not mp then          '' M Key down
			mp = true
			if multitextureSupported then
				useMultitexture = not useMultitexture
			end if
		end if
		if glfwGetKey(asc("M")) = FALSE then mp = false      '' M key up

		if glfwGetKey(asc("B")) and not bp then          '' B Key down
			bp = true
			bumps= not bumps
		end if
		if glfwGetKey(asc("B")) = FALSE then bp = false      '' B Key Up

		if glfwGetKey(asc("F")) and not fp then          '' F Key down
			fp = true
			filter += 1                            '' Cycle filter 0 -> 1 -> 2
			if (filter > 2) then filter = 0        '' 2 -> 0
		end if
		if glfwGetKey(asc("F")) = FALSE then fp = false      '' F Key Up

		if glfwGetKey(GLFW_KEY_PAGEUP) then z-=0.02        '' If Page Up is Being Pressed, Move Into The Screen
		if glfwGetKey(GLFW_KEY_PAGEDOWN) then z+=0.02      '' If Page Down is Being Pressed, Move Towards The Viewer
		if glfwGetKey(GLFW_KEY_UP) then xspeed-=0.01       '' If Up Arrow is Being Pressed, Decrease xspeed
		if glfwGetKey(GLFW_KEY_DOWN) then xspeed+=0.01     '' If Down Arrow Being Pressed, Increase xspeed
		if glfwGetKey(GLFW_KEY_RIGHT) then yspeed+=0.01    '' If Right Arrow Being Pressed, Increase yspeed
		if glfwGetKey(GLFW_KEY_LEFT) then yspeed-=0.01     '' If Left Arrow Being Pressed, Decrease yspeed

		'' Check if ESC key was pressed or window was closed
		running = glfwGetKey( GLFW_KEY_ESC )= 0 and glfwGetWindowParam( GLFW_OPENED ) <> 0
	wend
	'' Close window and terminate GLFW
	glfwTerminate()
	'' Exit program
	end 0

sub ReSizeGLScene GLFWCALL( byval w as integer, byval h as integer )
	glViewport 0, 0, w, h                          '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, w/h, 0.1, 100.0           '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity
end sub

''------------------------------------------------------------------------
' isMultitextureSupported() Checks At Run-Time If Multitexturing Is Supported
function initMultitexture() as integer
	dim extensions as string
	dim glen as integer
	dim i as integer

	extensions = *glGetString(GL_EXTENSIONS)   '' Fetch Extension String (glGetString returns a zstring ptr)

	#if EXT_INFO
	MessageBox (0,extensions, "supported GL extensions", MB_OK or MB_ICONINFORMATION)
	#endif

	if (glfwExtensionSupported( "GL_ARB_multitexture" ) = GL_TRUE and _       '' Is Multitexturing Supported?
		__ARB_ENABLE = 1 and _                                                '' Override-Flag
		glfwExtensionSupported("GL_EXT_texture_env_combine") = GL_TRUE) then  '' Is texture_env_combining Supported?

		glGetIntegerv(GL_MAX_TEXTURE_UNITS_ARB,@maxTexelUnits)
		
		'' Set addresses of functions we will use
		glMultiTexCoord1fARB = cast( PFNGLMULTITEXCOORD1FARBPROC, glfwGetProcAddress( "glMultiTexCoord1fARB" ) )
		glMultiTexCoord2fARB = cast( PFNGLMULTITEXCOORD2FARBPROC, glfwGetProcAddress( "glMultiTexCoord2fARB" ) )
		glMultiTexCoord3fARB = cast( PFNGLMULTITEXCOORD3FARBPROC, glfwGetProcAddress( "glMultiTexCoord3fARB" ) )
		glMultiTexCoord4fARB = cast( PFNGLMULTITEXCOORD4FARBPROC, glfwGetProcAddress( "glMultiTexCoord4fARB" ) )
		glActiveTextureARB   = cast( PFNGLACTIVETEXTUREARBPROC, glfwGetProcAddress( "glActiveTextureARB" ) )
		glClientActiveTextureARB = cast( PFNGLCLIENTACTIVETEXTUREARBPROC, glfwGetProcAddress( "glClientActiveTextureARB" ) )
		
		#if EXT_INFO
		MessageBox(0,"The GL_ARB_multitexture extension will be used.","feature supported!",MB_OK or MB_ICONINFORMATION)
		#endif
		
		return true
	end if
	useMultitexture=false                                      '' We Can't Use It If It Isn't Supported!
	return false
end function

''------------------------------------------------------------------------
sub initLights()

	glLightfv( GL_LIGHT1, GL_AMBIENT, @LightAmbient(0))        '' Load Light-Parameters Into GL_LIGHT1
	glLightfv( GL_LIGHT1, GL_DIFFUSE, @LightDiffuse(0))
	glLightfv( GL_LIGHT1, GL_POSITION, @LightPosition(0))

	glEnable(GL_LIGHT1)
end sub

''------------------------------------------------------------------------
'' Load Bitmaps And Convert To Textures
function LoadGLTextures() as integer
	dim status as integer = true                      '' Status Indicator
	dim Image as BITMAP_RGBImageRec ptr               '' Create Storage Space For The Texture
	dim alpha as byte ptr
	dim as integer i, a

	'' Load The Tile-Bitmap For Base-Texture
	Image = LoadBMP(exepath + "/data/Base.bmp")
	if (Image) then
		glGenTextures(3, @texture(0))                 '' Create Three Textures

		'' Create Nearest Filtered Texture
		glBindTexture(GL_TEXTURE_2D, texture(0))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Image->sizeX, Image->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)
		''                              ========
		'' Use GL_RGB8 Instead Of "3" In glTexImage2D. Also Defined By GL: GL_RGBA8 Etc.
		'' NEW: Now Creating GL_RGBA8 Textures, Alpha Is 1.0 Where Not Specified By Format.

		'' Create Linear Filtered Texture
		glBindTexture(GL_TEXTURE_2D, texture(1))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Image->sizeX, Image->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		'' Create MipMapped Texture
		glBindTexture(GL_TEXTURE_2D, texture(2))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_NEAREST)
		gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGB8, Image->sizeX, Image->sizeY, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

	else
		status=false
	end if
	if (Image) then                                         '' If Texture Exists
		if (Image->buffer) then deallocate(Image->buffer)   '' If Texture Image Exists
		deallocate(Image)
	end if

	'' Load The Bumpmaps
	Image = LoadBMP(exepath + "/data/Bump.bmp")
	if (Image) then
		glPixelTransferf(GL_RED_SCALE,0.5)                  '' Scale RGB By 50%, So That We Have Only
		glPixelTransferf(GL_GREEN_SCALE,0.5)                '' Half Intenstity
		glPixelTransferf(GL_BLUE_SCALE,0.5)

		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP)      '' No Wrapping, Please!
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP)
		glTexParameterfv(GL_TEXTURE_2D,GL_TEXTURE_BORDER_COLOR,@Gray(0))

		glGenTextures(3, @bump(0))                                     '' Create Three Textures

		'' Create Nearest Filtered Texture
		glBindTexture(GL_TEXTURE_2D, bump(0))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Image->sizeX, Image->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		'' Create Linear Filtered Texture
		glBindTexture(GL_TEXTURE_2D, bump(1))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Image->sizeX, Image->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		'' Create MipMapped Texture
		glBindTexture(GL_TEXTURE_2D, bump(2))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_NEAREST)
		gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGB8, Image->sizeX, Image->sizeY, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		for i = 0 to 3*Image->sizeX*Image->sizeY -1            '' Invert The Bumpmap
			Image->buffer[i] = 255-Image->buffer[i]
		next

		glGenTextures(3, @invbump(0))                          '' Create Three Textures

		'' Create Nearest Filtered Texture
		glBindTexture(GL_TEXTURE_2D, invbump(0))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Image->sizeX, Image->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		'' Create Linear Filtered Texture
		glBindTexture(GL_TEXTURE_2D, invbump(1))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, Image->sizeX, Image->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		'' Create MipMapped Texture
		glBindTexture(GL_TEXTURE_2D, invbump(2))
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_NEAREST)
		gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGB8, Image->sizeX, Image->sizeY, GL_RGB, GL_UNSIGNED_BYTE, Image->buffer)

		glPixelTransferf(GL_RED_SCALE,1.0)                  '' Scale RGB Back To 100% Again
		glPixelTransferf(GL_GREEN_SCALE,1.0)
		glPixelTransferf(GL_BLUE_SCALE,1.0)

	else
		status=false
	end if
	if (Image) then                                         '' If Texture Exists
		if (Image->buffer) then deallocate(Image->buffer)   '' If Texture Image Exists
		deallocate(Image)
	end if

	''   sector1.triangle = (TRIANGLE *) malloc(sizeof(TRIANGLE)*numtriangles)
	'' sector1.triangle = new TRIANGLE(numtriangles)

	'' Load The Logo-Bitmaps
	Image=LoadBMP(exepath + "/data/OpenGL_Alpha.bmp")
	if (Image) then
		alpha = allocate( 4*Image->sizeX*Image->sizeY)      '' Create Memory For RGBA8-Texture
		for a=0 to Image->sizeX*Image->sizeY - 1
			alpha[4*a+3]=Image->buffer[a*3]                 '' Pick Only Red Value As Alpha!
		next

		Image=LoadBMP(exepath + "/data/OpenGL.bmp")
		if (Image = NULL) then status=false
		for a=0 to Image->sizeX*Image->sizeY - 1
			alpha[4*a] = Image->buffer[a*3]                 '' R
			alpha[4*a+1] = Image->buffer[a*3+1]             '' G
			alpha[4*a+2] = Image->buffer[a*3+2]             '' B
		next

		glGenTextures(1, @glLogo)                           '' Create One Textures

		'' Create Linear Filtered RGBA8-Texture
		glBindTexture(GL_TEXTURE_2D, glLogo)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, Image->sizeX, Image->sizeY, 0, GL_RGBA, GL_UNSIGNED_BYTE, alpha)
		deallocate (alpha)
	else
		status=false
	end if

	if (Image) then                                         '' If Texture Exists
		if (Image->buffer) then deallocate(Image->buffer)   '' If Texture Image Exists
		deallocate (Image)
		Image=NULL
	end if

	'' Load The "Extension Enabled"-Logo
	Image=LoadBMP(exepath + "/data/Multi_On_Alpha.bmp")
	if Image then
		alpha = allocate(4*Image->sizeX*Image->sizeY)       '' Create Memory For RGBA8-Texture
		for a=0 to Image->sizeX*Image->sizeY - 1
			alpha[4*a+3] = Image->buffer[a*3]               '' Pick Only Red Value As Alpha!
		next
		Image=LoadBMP(exepath + "/data/Multi_On.bmp")
		if (Image = NULL) then status=false
		for a=0 to Image->sizeX*Image->sizeY -1
			alpha[4*a] = Image->buffer[a*3]                 '' R
			alpha[4*a+1] = Image->buffer[a*3+1]             '' G
			alpha[4*a+2] = Image->buffer[a*3+2]             '' B
		next

		glGenTextures(1, @multiLogo)                        '' Create One Textures

		'' Create Linear Filtered RGBA8-Texture
		glBindTexture(GL_TEXTURE_2D, multiLogo)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, Image->sizeX, Image->sizeY, 0, GL_RGBA, GL_UNSIGNED_BYTE, alpha)
		deallocate( alpha)

	else
		status=false
	end if
	if (Image) then                                         '' If Texture Exists
		if (Image->buffer) then deallocate (Image->buffer)  '' If Texture Image Exists
		deallocate( Image)
		Image=NULL
	end if

	return status                                           '' Return The Status
end function

''------------------------------------------------------------------------
sub doCube ()
	dim i as integer
	glBegin(GL_QUADS)
		'' Front Face
		glNormal3f( 0.0, 0.0, +1.0)
		for i=0 to 3
			glTexCoord2f(CubeData(5*i),CubeData(5*i+1))
			glVertex3f(CubeData(5*i+2),CubeData(5*i+3),CubeData(5*i+4))
		next
		'' Back Face
		glNormal3f( 0.0, 0.0,-1.0)
		for i=4 to 7
			glTexCoord2f(CubeData(5*i),CubeData(5*i+1))
			glVertex3f(CubeData(5*i+2),CubeData(5*i+3),CubeData(5*i+4))
		next
		'' Top Face
		glNormal3f( 0.0, 1.0, 0.0)
		for i=8 to 11
			glTexCoord2f(CubeData(5*i),CubeData(5*i+1))
			glVertex3f(CubeData(5*i+2),CubeData(5*i+3),CubeData(5*i+4))
		next
		'' Bottom Face
		glNormal3f( 0.0,-1.0, 0.0)
		for i=12 to 15
			glTexCoord2f(CubeData(5*i),CubeData(5*i+1))
			glVertex3f(CubeData(5*i+2),CubeData(5*i+3),CubeData(5*i+4))
		next
		'' Right face
		glNormal3f( 1.0, 0.0, 0.0)
		for i=16 to 19
			glTexCoord2f(CubeData(5*i),CubeData(5*i+1))
			glVertex3f(CubeData(5*i+2),CubeData(5*i+3),CubeData(5*i+4))
		next
		'' Left Face
		glNormal3f(-1.0, 0.0, 0.0)
		for i=20 to 23
			glTexCoord2f(CubeData(5*i),CubeData(5*i+1))
			glVertex3f(CubeData(5*i+2),CubeData(5*i+3),CubeData(5*i+4))
		next
	glEnd()
end sub

''------------------------------------------------------------------------
' Calculates v=vM, M Is 4x4 In Column-Major, v Is 4dim. Row (i.e. "Transposed")
sub VMatMult(byval M as single ptr, byval v as single ptr)
	dim res(0 to 2) as single
	res(0) = M[0]*v[0]+M[1]*v[1] + M[ 2]*v[2] + M[3]*v[3]
	res(1) = M[4]*v[0]+M[5]*v[1] + M[ 6]*v[2] + M[7]*v[3]
	res(2) = M[8]*v[0]+M[9]*v[1] + M[10]*v[2] + M[11]*v[3]
	v[0] = res(0)
	v[1] = res(1)
	v[2] = res(2)
	v[3] = M[15]                                            '' Homogenous Coordinate
end sub

''------------------------------------------------------------------------
''  Okay, Here Comes The Important Stuff:
''
''    On http:'www.nvidia.com/marketing/Developer/DevRel.nsf/TechnicalDemosFrame?OpenPage
''    You Can Find A Demo Called GL_BUMP That Is A Little Bit More Complicated.
''    GL_BUMP:   Copyright Diego Tártara, 1999.
''             -  diego_tartara@ciudad.com.ar  -
''
''    The Idea Behind GL_BUMP Is, That You Compute The Texture-Coordinate Offset As Follows:
''        0) All Coordinates Either In Object Or In World Space.
''        1) Calculate Vertex v From Actual Position (The Vertex You're At) To The Lightposition
''        2) Normalize v
''        3) Project This v Into Tangent Space.
''            Tangent Space Is The Plane "Touching" The Object In Our Current Position On It.
''            Typically, If You're Working With Flat Surfaces, This Is The Surface Itself.
''        4) Offset s,t-Texture-Coordinates By The Projected v's x And y-Component.
''
''    * This Would Be Called Once Per Vertex In Our Geometry, If Done Correctly.
''    * This Might Lead To Incoherencies In Our Texture Coordinates, But Is Ok As Long As You Did Not
''    * Wrap The Bumpmap.
''
''    Basically, We Do It The Same Way With Some Exceptions:
''        ad 0) We'll Work In Object Space All Time. This Has The Advantage That We'll Only
''              Have To Transform The Lightposition From Frame To Frame. This Position Obviously
''              Has To Be Transformed Using The Inversion Of The Modelview Matrix. This Is, However,
''              A Considerable Drawback, If You Don't Know How Your Modelview Matrix Was Built, Since
''              Inverting A Matrix Is Costly And Complicated.
''        ad 1) Do It Exactly That Way.
''        ad 2) Do It Exactly That Way.
''        ad 3) To Project The Lightvector Into Tangent Space, We'll Support The Setup-Routine
''              With Two Directions: One Of Increasing s-Texture-Coordinate Axis, The Other In
''              Increasing t-Texture-Coordinate Axis. The Projection Simply Is (Assumed Both
''              texCoord Vectors And The Lightvector Are Normalized) The Dotproduct Between The
''              Respective texCoord Vector And The Lightvector.
''        ad 4) The Offset Is Computed By Taking The Result Of Step 3 And Multiplying The Two
''              Numbers With MAX_EMBOSS, A Constant That Specifies How Much Quality We're Willing To
''              Trade For Stronger Bump-Effects. Just Temper A Little Bit With MAX_EMBOSS!
''
''    WHY THIS IS COOL:
''        * Have A Look!
''        * Very Cheap To Implement (About One Squareroot And A Couple Of MULs)!
''        * Can Even Be Further Optimized!
''        * SetUpBump Doesn't Disturb glBegin()/glEnd()
''        * THIS DOES ALWAYS WORK - Not Only With XY-Tangent Spaces!!
''
''    DRAWBACKS:
''        * Must Know "Structure" Of Modelview-Matrix Or Invert It. Possible To Do The Whole Thing
''        * In World Space, But This Involves One Transformation For Each Vertex!
''

sub SetUpBumps(byval n as single ptr, byval c as single ptr, byval l as single ptr, byval s as single ptr, byval t as single ptr)
	dim v(0 to 2) as single                                '' Vertex From Current Position To Light
	dim lenQ as single                                     '' Used To Normalize

	'' Calculate v From Current Vector c To Lightposition And Normalize v
	v(0)=l[0]-c[0]
	v(1)=l[1]-c[1]
	v(2)=l[2]-c[2]
	lenQ = sqr(v(0)*v(0)+v(1)*v(1)+v(2)*v(2))
	v(0)/=lenQ:     v(1)/=lenQ:     v(2)/=lenQ
	'' Project v Such That We Get Two Values Along Each Texture-Coordinat Axis.
	c[0]=(s[0]*v(0)+s[1]*v(1)+s[2]*v(2))*MAX_EMBOSS
	c[1]=(t[0]*v(0)+t[1]*v(1)+t[2]*v(2))*MAX_EMBOSS
end sub

''------------------------------------------------------------------------
'' MUST CALL THIS LAST!!!, Billboards The Two Logos.
sub doLogo()
	glDepthFunc(GL_ALWAYS)
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
	glEnable(GL_BLEND)
	glDisable(GL_LIGHTING)
	glLoadIdentity()
	glBindTexture(GL_TEXTURE_2D,glLogo)
	glBegin(GL_QUADS)
		glTexCoord2f(0.0,0.0): glVertex3f(0.23, -0.4,-1.0)
		glTexCoord2f(1.0,0.0): glVertex3f(0.53, -0.4,-1.0)
		glTexCoord2f(1.0,1.0): glVertex3f(0.53, -0.25,-1.0)
		glTexCoord2f(0.0,1.0): glVertex3f(0.23, -0.25,-1.0)
	glEnd()
	if (useMultitexture) then
		glBindTexture(GL_TEXTURE_2D,multiLogo)
		glBegin(GL_QUADS)
			glTexCoord2f(0.0,0.0): glVertex3f(-0.53, -0.4,-1.0)
			glTexCoord2f(1.0,0.0): glVertex3f(-0.33, -0.4,-1.0)
			glTexCoord2f(1.0,1.0): glVertex3f(-0.33, -0.3,-1.0)
			glTexCoord2f(0.0,1.0): glVertex3f(-0.53, -0.3,-1.0)
		glEnd()
	end if
	glDepthFunc(GL_LEQUAL)
end sub

''------------------------------------------------------------------------
function doMesh1TexelUnits() as integer

	dim c(0 to 3) as single => {0.0,0.0,0.0,1.0}         '' Holds Current Vertex
	dim n(0 to 3) as single => {0.0,0.0,0.0,1.0}         '' Normalized Normal Of Current Surface
	dim s(0 to 3) as single => {0.0,0.0,0.0,1.0}         '' s-Texture Coordinate Direction, Normalized
	dim t(0 to 3) as single => {0.0,0.0,0.0,1.0}         '' t-Texture Coordinate Direction, Normalized

	dim l(0 to 3) as single                              '' Holds Our Lightposition To Be Transformed Into Object Space
	dim Minv(15) as single                               '' Holds The Inverted Modelview Matrix To Do So.
	dim i as integer

	glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)  '' Clear The Screen And The Depth Buffer

	'' Build Inverse Modelview Matrix First. This Substitutes One Push/Pop With One glLoadIdentity();
	'' Simply Build It By Doing All Transformations Negated And In Reverse Order.
	glLoadIdentity()
	glRotatef(-yrot,0.0,1.0,0.0)
	glRotatef(-xrot,1.0,0.0,0.0)
	glTranslatef(0.0,0.0,-z)
	glGetFloatv(GL_MODELVIEW_MATRIX,@Minv(0))
	glLoadIdentity()
	glTranslatef(0.0,0.0,z)

	glRotatef(xrot,1.0,0.0,0.0)
	glRotatef(yrot,0.0,1.0,0.0)

	'' Transform The Lightposition Into Object Coordinates:
	l(0)=LightPosition(0)
	l(1)=LightPosition(1)
	l(2)=LightPosition(2)
	l(3)=1.0                                             '' Homogenous Coordinate
	VMatMult(@Minv(0),@l(0))

	''    PASS#1: Use Texture "Bump"
	''            No Blend
	''            No Lighting
	''            No Offset Texture-Coordinates
	glBindTexture(GL_TEXTURE_2D, bump(filter))
	glDisable(GL_BLEND)
	glDisable(GL_LIGHTING)
	doCube()

	''   PASS#2:  Use Texture "Invbump"
	''            Blend GL_ONE To GL_ONE
	''            No Lighting
	''            Offset Texture Coordinates
	glBindTexture(GL_TEXTURE_2D,invbump(filter))
	glBlendFunc(GL_ONE,GL_ONE)
	glDepthFunc(GL_LEQUAL)
	glEnable(GL_BLEND)

	glBegin(GL_QUADS)
		'' Front Face
		n(0)=0.0:      n(1)=0.0:      n(2)=1.0
		s(0)=1.0:      s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=0 to 3
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glTexCoord2f(CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Back Face
		n(0)=0.0:      n(1)=0.0:      n(2)=-1.0
		s(0)=-1.0:     s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=4 to 7
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glTexCoord2f(CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Top Face
		n(0)=0.0:      n(1)=1.0:      n(2)=0.0
		s(0)=1.0:      s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=0.0:      t(2)=-1.0
		for i=8 to 11
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glTexCoord2f(CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Bottom Face
		n(0)=0.0:      n(1)=-1.0:     n(2)=0.0
		s(0)=-1.0:     s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=0.0:      t(2)=-1.0
		for i=12 to 15
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glTexCoord2f(CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Right Face
		n(0)=1.0:      n(1)=0.0:      n(2)=0.0
		s(0)=0.0:      s(1)=0.0:      s(2)=-1.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=16 to 19
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glTexCoord2f(CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Left Face
		n(0)=-1.0:     n(1)=0.0:      n(2)=0.0
		s(0)=0.0:      s(1)=0.0:      s(2)=1.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=20 to 23
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glTexCoord2f(CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
	glEnd()

	''   PASS#3:  Use Texture "Base"
	''            Blend GL_DST_COLOR To GL_SRC_COLOR (Multiplies By 2)
	''            Lighting Enabled
	''            No Offset Texture-Coordinates

	if (not emboss) then
		glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE)
		glBindTexture(GL_TEXTURE_2D,texture(filter))
		glBlendFunc(GL_DST_COLOR,GL_SRC_COLOR)
		glEnable(GL_LIGHTING)
		doCube()
	end if

	xrot+=xspeed
	yrot+=yspeed
	if xrot > 360.0 then xrot = xrot - 360.0
	if xrot < 0.0   then xrot = xrot + 360.0
	if yrot > 360.0 then yrot = yrot - 360.0
	if yrot < 0.0   then yrot = yrot + 360.0

	''  LAST PASS:  Do The Logos!
	doLogo()

	return  true                                         '' Keep Going
end function
''------------------------------------------------------------------------

function doMesh2TexelUnits() as integer
	dim c(0 to 3) as single => {0.0, 0.0, 0.0, 1.0}      '' holds current vertex
	dim n(0 to 3) as single => {0.0, 0.0, 0.0, 1.0}      '' normalized normal of current surface
	dim s(0 to 3) as single => {0.0, 0.0, 0.0, 1.0}      '' s-texture coordinate direction, normalized
	dim t(0 to 3) as single=> {0.0, 0.0, 0.0, 1.0}       '' t-texture coordinate direction, normalized

	dim l(3) as single                                   '' holds our lightposition to be transformed into object space
	dim Minv(15) as single                               '' holds the inverted modelview matrix to do so.
	dim i as integer

	glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)  '' Clear The Screen And The Depth Buffer

	'' Build Inverse Modelview Matrix First. This Substitutes One Push/Pop With One glLoadIdentity();
	'' Simply Build It By Doing All Transformations Negated And In Reverse Order.
	glLoadIdentity()
	glRotatef(-yrot,0.0,1.0,0.0)
	glRotatef(-xrot,1.0,0.0,0.0)
	glTranslatef(0.0,0.0,-z)
	glGetFloatv(GL_MODELVIEW_MATRIX,@Minv(0))
	glLoadIdentity()
	glTranslatef(0.0,0.0,z)

	glRotatef(xrot,1.0,0.0,0.0)
	glRotatef(yrot,0.0,1.0,0.0)

	'' Transform The Lightposition Into Object Coordinates:
	l(0)=LightPosition(0)
	l(1)=LightPosition(1)
	l(2)=LightPosition(2)
	l(3)=1.0                                             '' Homogenous Coordinate
	VMatMult(@Minv(0),@l(0))

	''    PASS#1: Texel-Unit 0:   Use Texture "Bump"
	''                            No Blend
	''                            No Lighting
	''                            No Offset Texture-Coordinates
	''                            Texture-Operation "Replace"
	''            Texel-Unit 1:   Use Texture "Invbump"
	''                            No Lighting
	''                            Offset Texture Coordinates
	''                            Texture-Operation "Replace"

	'' TEXTURE-UNIT #0
	glActiveTextureARB(GL_TEXTURE0_ARB)
	glEnable(GL_TEXTURE_2D)
	glBindTexture(GL_TEXTURE_2D, bump(filter))
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE_EXT)
	glTexEnvf (GL_TEXTURE_ENV, GL_COMBINE_RGB_EXT, GL_REPLACE)
	'' TEXTURE-UNIT #1:
	glActiveTextureARB(GL_TEXTURE1_ARB)
	glEnable(GL_TEXTURE_2D)
	glBindTexture(GL_TEXTURE_2D, invbump(filter))
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_COMBINE_EXT)
	glTexEnvf (GL_TEXTURE_ENV, GL_COMBINE_RGB_EXT, GL_ADD)
	'' General Switches:
	glDisable(GL_BLEND)
	glDisable(GL_LIGHTING)
	glBegin(GL_QUADS)
		'' Front Face
		n(0)=0.0:      n(1)=0.0:      n(2)=1.0
		s(0)=1.0:      s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=0 to 3
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glMultiTexCoord2fARB(GL_TEXTURE0_ARB,CubeData(5*i), CubeData(5*i+1))
			glMultiTexCoord2fARB(GL_TEXTURE1_ARB,CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Back Face
		n(0)=0.0:      n(1)=0.0:      n(2)=-1.0
		s(0)=-1.0:     s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=4 to 7
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glMultiTexCoord2fARB(GL_TEXTURE0_ARB,CubeData(5*i), CubeData(5*i+1))
			glMultiTexCoord2fARB(GL_TEXTURE1_ARB,CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Top Face
		n(0)=0.0:      n(1)=1.0:      n(2)=0.0
		s(0)=1.0:      s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=0.0:      t(2)=-1.0
		for i=8 to 11
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glMultiTexCoord2fARB(GL_TEXTURE0_ARB,CubeData(5*i), CubeData(5*i+1))
			glMultiTexCoord2fARB(GL_TEXTURE1_ARB,CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Bottom Face
		n(0)=0.0:      n(1)=-1.0:     n(2)=0.0
		s(0)=-1.0:     s(1)=0.0:      s(2)=0.0
		t(0)=0.0:      t(1)=0.0:      t(2)=-1.0
		for i=12 to 15
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glMultiTexCoord2fARB(GL_TEXTURE0_ARB,CubeData(5*i), CubeData(5*i+1))
			glMultiTexCoord2fARB(GL_TEXTURE1_ARB,CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Right Face
		n(0)=1.0:      n(1)=0.0:      n(2)=0.0
		s(0)=0.0:      s(1)=0.0:      s(2)=-1.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=16 to 19
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glMultiTexCoord2fARB(GL_TEXTURE0_ARB,CubeData(5*i), CubeData(5*i+1))
			glMultiTexCoord2fARB(GL_TEXTURE1_ARB,CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
		'' Left Face
		n(0)=-1.0:     n(1)=0.0:      n(2)=0.0
		s(0)=0.0:      s(1)=0.0:      s(2)=1.0
		t(0)=0.0:      t(1)=1.0:      t(2)=0.0
		for i=20 to 23
			c(0)=CubeData(5*i+2)
			c(1)=CubeData(5*i+3)
			c(2)=CubeData(5*i+4)
			SetUpBumps(@n(0),@c(0),@l(0),@s(0),@t(0))
			glMultiTexCoord2fARB(GL_TEXTURE0_ARB,CubeData(5*i), CubeData(5*i+1))
			glMultiTexCoord2fARB(GL_TEXTURE1_ARB,CubeData(5*i)+c(0), CubeData(5*i+1)+c(1))
			glVertex3f(CubeData(5*i+2), CubeData(5*i+3), CubeData(5*i+4))
		next
	glEnd()

	''   PASS#2   Use Texture "Base"
	''            Blend GL_DST_COLOR To GL_SRC_COLOR (Multiplies By 2)
	''            Lighting Enabled
	''            No Offset Texture-Coordinates

	glActiveTextureARB(GL_TEXTURE1_ARB)
	glDisable(GL_TEXTURE_2D)
	glActiveTextureARB(GL_TEXTURE0_ARB)
	if not emboss then
		glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE)
		glBindTexture(GL_TEXTURE_2D,texture(filter))
		glBlendFunc(GL_DST_COLOR,GL_SRC_COLOR)
		glEnable(GL_BLEND)
		glEnable(GL_LIGHTING)
		doCube()
	end if

	xrot = xrot + xspeed
	yrot = yrot + yspeed
	if xrot>360.0 then xrot = xrot-360.0
	if xrot<0.0   then xrot = xrot+360.0
	if yrot>360.0 then yrot = yrot-360.0
	if yrot<0.0   then yrot = yrot+360.0

	'' LAST PASS:   Do The Logos!
	doLogo()

	return true                                          '' Keep Going
end function

''------------------------------------------------------------------------
function doMeshNoBumps() as integer

	glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)  '' Clear The Screen And The Depth Buffer
	glLoadIdentity()                                     '' Reset The View
	glTranslatef(0.0,0.0,z)

	glRotatef(xrot,1.0,0.0,0.0)
	glRotatef(yrot,0.0,1.0,0.0)
	if (useMultitexture) then
		glActiveTextureARB(GL_TEXTURE1_ARB)
		glDisable(GL_TEXTURE_2D)
		glActiveTextureARB(GL_TEXTURE0_ARB)
	end if
	glDisable(GL_BLEND)
	glBindTexture(GL_TEXTURE_2D,texture(filter))
	glBlendFunc(GL_DST_COLOR,GL_SRC_COLOR)
	glEnable(GL_LIGHTING)
	doCube()

	xrot = xrot + xspeed
	yrot = yrot + yspeed
	if xrot>360.0 then xrot = xrot - 360.0
	if xrot<0.0   then xrot = xrot + 360.0
	if yrot>360.0 then yrot = yrot - 360.0
	if yrot<0.0   then yrot = yrot + 360.0

	'' LAST PASS:   Do The Logos!
	doLogo()

	return true                                          '' Keep Going
end function

''------------------------------------------------------------------------
function DrawGLScene() as integer                        '' Here's Where We Do All The Drawing
	if (bumps) then
		if (useMultitexture and (maxTexelUnits > 1)) then
			return doMesh2TexelUnits()
		else
			return doMesh1TexelUnits()
		end if
	else
		return doMeshNoBumps()
	end if
end function
