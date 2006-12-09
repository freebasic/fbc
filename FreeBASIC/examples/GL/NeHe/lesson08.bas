''
'' This Code Was Created By Jeff Molofee 2000
'' A HUGE Thanks To Fredric Echols For Cleaning Up
'' And Optimizing The Base Code, Making It More Flexible!
'' If You've Found This Code Useful, Please Let Me Know.
'' Visit My Site At nehe.gamedev.net
''

'' compile as: fbc -s gui lesson08.bas

''------------------------------------------------------------------------------
'' Use ESC key to quit
'' L key to toggle lighting (on/off)
'' F key to cycle filters (Nearest, Linear , MipMapped)
'' B key to toggle blending (on/off)
'' PgUp key and PgDn key to Zoom in and out
'' UpArrow, DnArrow, RightArrow, Left Arrow to change rotate speed of cube
''
''------------------------------------------------------------------------------



#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "bmpload.bi"
#include once "fbgfx.bi"                   ''for Scan code constants

'' Setup our booleans
const false = 0
const true  = not false

declare function LoadGLTextures() as integer

	dim shared filter as uinteger                  '' Which Filter To Use
	dim shared texture(0 to 2) as uinteger         '' Storage For 3 Textures
	
	dim shared light as integer                    '' Lighting ON/OFF
	dim shared blend as integer                    '' Blending OFF/ON? ( NEW )
	dim shared lp as integer                       '' L Pressed?
	dim shared fp as integer                       '' F Pressed?
	dim shared bp as integer                       '' B Pressed? ( NEW )
	
	dim LightAmbient(0 to 3) as single => {0.5, 0.5, 0.5, 1.0}   '' Ambient Light Values
	dim LightDiffuse(0 to 3) as single => {1.0, 1.0, 1.0, 1.0}   '' Diffuse Light Values
	dim LightPosition(0 to 3) as single => {0.0, 0.0, 2.0, 1.0}  '' Light Position
	
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
	
	'' Jump To Texture Loading Routine
	if (not LoadGLTextures()) then
	  end 1                                        '' If Texture Didn't Load Quit
	end if
	
	'' All Setup For OpenGL Goes Here
	glEnable GL_TEXTURE_2D                         '' Enable Texture Mapping
	glShadeModel GL_SMOOTH                         '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                '' Black Background
	glClearDepth 1.0                               '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                         '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                          '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST    '' Really Nice Perspective Calculations
	
	glLightfv GL_LIGHT1, GL_AMBIENT, @LightAmbient(0)   '' Setup The Ambient Light
	glLightfv GL_LIGHT1, GL_DIFFUSE, @LightDiffuse(0)   '' Setup The Diffuse Light
	glLightfv GL_LIGHT1, GL_POSITION, @LightPosition(0) '' Position The Light
	glEnable GL_LIGHT1                                  '' Enable Light One
	
	glColor4f 1.0, 1.0, 1.0, 0.5                        '' Full Brightness.  50% Alpha
	glBlendFunc GL_SRC_ALPHA, GL_ONE                    '' Set The Blending Function For Translucency
	
	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear Screen And Depth Buffer
		glLoadIdentity                                          '' Reset The View
		glTranslatef 0.0,0.0,z
	
		glRotatef xrot,1.0,0.0,0.0                              '' Rotate On The X Axis By xrot
		glRotatef yrot,0.0,1.0,0.0                              '' Rotate On The Y Axis By yrot
	
		glBindTexture GL_TEXTURE_2D, texture(filter)            '' Select A Texture Based On filter
	
		glBegin GL_QUADS                                        '' Start Drawing Quads
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
		glEnd                                                   '' Done Drawing Quads
	
		xrot = xrot + xspeed                    '' Add xspeed To xrot
		yrot = yrot + yspeed                    '' Add yspeed To yrot
	
		'' Keyboard handlers
		if MULTIKEY(FB.SC_L) and not lp then       '' L Key down
			lp = true
			light = not light                     '' toggle light on /off
			if (not light) then
				glDisable(GL_LIGHTING)              '' disable lighting
			else
				glEnable(GL_LIGHTING)               '' enable lighting
			end if
		end if
		if not MULTIKEY(FB.SC_L) then lp = false   '' L key up
	
		if MULTIKEY(FB.SC_F) and not fp then       '' F Key down
			fp = true
			filter += 1                           '' Cycle filter 0 -> 1 -> 2
			if (filter > 2) then filter = 0       '' 2 -> 0
		end if
		if not MULTIKEY(FB.SC_F) then fp = false   '' F Key Up
	
		'' Blending Code Starts Here
		if MULTIKEY(FB.SC_B) and not bp then       '' B Key down
			bp = true
			blend = not blend                     '' toggle blending On/Off
			if blend then
				glEnable(GL_BLEND)                  '' Turn Blending On
				glDisable(GL_DEPTH_TEST)            '' Turn Depth Testing Off
			else
				glDisable(GL_BLEND)                 '' Turn Blending Off
				glEnable(GL_DEPTH_TEST)             '' Turn Depth Testing On
			end if
		end if
		if not MULTIKEY(FB.SC_B) then bp = false   '' B Key up
		'' Blending Code Ends Here
	
		if MULTIKEY(FB.SC_PAGEUP) then z-=0.02     '' If Page Up is Being Pressed, Move Into The Screen
		if MULTIKEY(FB.SC_PAGEDOWN) then z+=0.02   '' If Page Down is Being Pressed, Move Towards The Viewer
		if MULTIKEY(FB.SC_UP) then xspeed-=0.01    '' If Up Arrow is Being Pressed, Decrease xspeed
		if MULTIKEY(FB.SC_DOWN) then xspeed+=0.01  '' If Down Arrow Being Pressed, Increase xspeed
		if MULTIKEY(FB.SC_RIGHT) then yspeed+=0.01 '' If Right Arrow Being Pressed, Increase yspeed
		if MULTIKEY(FB.SC_LEFT) then yspeed-=0.01  '' If Left Arrow Being Pressed, Decrease yspeed
	
		flip  '' flip or crash
	loop while MULTIKEY(FB.SC_ESCAPE) = 0
	
	'Empty keyboard buffer
	while inkey <> "": wend
	
	end

'' Load Bitmaps And Convert To Textures
function LoadGLTextures() as integer
  dim Status as integer = false                     '' Status Indicator
  dim TextureImage(0) as BITMAP_RGBImageRec ptr     '' Create Storage Space For The Texture

  ' Load The Bitmap, Check For Errors, If Bitmap's Not Found Quit
  TextureImage(0) = LoadBMP(exepath + "/data/Glass.bmp")
  if TextureImage(0) then
    Status = true                                   '' Set The Status To TRUE
    glGenTextures 3, @texture(0)                    '' Create The Texture

    ' Create Nearest Filtered Texture
    glBindTexture GL_TEXTURE_2D, texture(0)
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST
    glTexImage2D GL_TEXTURE_2D, 0, 3, TextureImage(0)->sizeX, TextureImage(0)->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, TextureImage(0)->buffer

    ' Create Linear Filtered Texture
    glBindTexture GL_TEXTURE_2D, texture(1)
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR
    glTexImage2D GL_TEXTURE_2D, 0, 3, TextureImage(0)->sizeX, TextureImage(0)->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, TextureImage(0)->buffer

    ' Create MipMapped Texture
    glBindTexture GL_TEXTURE_2D, texture(2)
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_NEAREST
    gluBuild2DMipmaps GL_TEXTURE_2D, 3, TextureImage(0)->sizeX, TextureImage(0)->sizeY, GL_RGB, GL_UNSIGNED_BYTE, TextureImage(0)->buffer

  end if

  if TextureImage(0) then                           '' If Texture Exists
    if TextureImage(0)->buffer then                 '' If Texture Image Exist
      deallocate(TextureImage(0)->buffer)           '' Free The Texture Image Memory
    end if
    deallocate(TextureImage(0))                     '' Free The Image Structure
  end if

  return Status                                     '' Return The Status
end function
