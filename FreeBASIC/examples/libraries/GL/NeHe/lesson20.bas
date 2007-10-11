''------------------------------------------------------------------------------
''
''  This Code Was Created By Jeff Molofee 2000
''  And Modified By Giuseppe D'Agata (waveform@tiscalinet.it)
''  If You've Found This Code Useful, Please Let Me Know.
''  Visit My Site At nehe.gamedev.net
''

'' compile as: fbc -s gui lesson20.bas

''------------------------------------------------------------------------------
'' Use Space Bar to toggle bitmaps and M on keybpard to toggle masking
''
''------------------------------------------------------------------------------


 
#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "bmpload.bi"
#include once "fbgfx.bi"                   ''for Scan code constants

''------------------------------------------------------------------------------
'' Common window constants
'' Setup our booleans
const false = 0
const true  = not false
const null = false

declare function LoadGLTextures() as integer

	'' Global variable
	dim shared texture(5) as uinteger        '' Storage For Our Five Textures
	
	'' Local variables
	dim roll    as single                    '' Rolling Texture
	dim masking as integer                   '' Masking On/Off
	dim scene   as integer                   '' Which Scene To Draw
	dim sm      as integer, sp as integer    '' flags to indicate key states
	
	'' Start
	
	screen 18, 16, , 2
	
	glViewport 0, 0, 640, 480
	glMatrixMode GL_PROJECTION
	glLoadIdentity
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0
	glMatrixMode GL_MODELVIEW
	glLoadIdentity
	
	if (not LoadGLTextures()) then       '' Jump To Texture Loading Routine
	  end 1                              '' If Texture Didn't Load Quit
	end if
	
	glClearColor(0.0, 0.0, 0.0, 0.0)     '' Clear The Background Color To Black
	glClearDepth(1.0)                    '' Enables Clearing Of The Depth Buffer
	glEnable(GL_DEPTH_TEST)              '' Enable Depth Testing
	glShadeModel(GL_SMOOTH)              '' Enables Smooth Color Shading
	glEnable(GL_TEXTURE_2D)              '' Enable 2D Texture Mapping
	
	'' Set masking as default
	masking = true
	
	do
		glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)      '' Clear The Screen And The Depth Buffer
		glLoadIdentity()                                         '' Reset The Modelview Matrix
		glTranslatef(0.0,0.0,-2.0)                               '' Move Into The Screen 5 Units
	
		glBindTexture(GL_TEXTURE_2D, texture(0))                 '' Select Our Logo Texture
		glBegin(GL_QUADS)                    '' Start Drawing A Textured Quad
			glTexCoord2f(0.0, -roll+0.0): glVertex3f(-1.1, -1.1,  0.0)    '' Bottom Left
			glTexCoord2f(3.0, -roll+0.0): glVertex3f( 1.1, -1.1,  0.0)    '' Bottom Right
			glTexCoord2f(3.0, -roll+3.0): glVertex3f( 1.1,  1.1,  0.0)    '' Top Right
			glTexCoord2f(0.0, -roll+3.0): glVertex3f(-1.1,  1.1,  0.0)    '' Top Left
		glEnd()                              '' Done Drawing The Quad
	
		glEnable(GL_BLEND)                   '' Enable Blending
		glDisable(GL_DEPTH_TEST)             '' Disable Depth Testing
	
		if masking then                      '' Is Masking Enabled?
			glBlendFunc(GL_DST_COLOR,GL_ZERO)  '' Blend Screen Color With Zero (Black)
		end if
	
		if (scene) then                      '' Are We Drawing The Second Scene?
			glTranslatef(0.0,0.0,-1.0)         '' Translate Into The Screen One Unit
			glRotatef(roll*360,0.0,0.0,1.0)    '' Rotate On The Z Axis 360 Degrees.
			if masking then                    '' Is Masking On?
				glBindTexture(GL_TEXTURE_2D, texture(3))          '' Select The Second Mask Texture
				glBegin(GL_QUADS)           '' Start Drawing A Textured Quad
					glTexCoord2f(0.0, 0.0): glVertex3f(-1.1, -1.1,  0.0)    '' Bottom Left
					glTexCoord2f(1.0, 0.0): glVertex3f( 1.1, -1.1,  0.0)    '' Bottom Right
					glTexCoord2f(1.0, 1.0): glVertex3f( 1.1,  1.1,  0.0)    '' Top Right
					glTexCoord2f(0.0, 1.0): glVertex3f(-1.1,  1.1,  0.0)    '' Top Left
				glEnd()                     '' Done Drawing The Quad
			end if
	
			glBlendFunc(GL_ONE, GL_ONE)                          '' Copy Image 2 Color To The Screen
			glBindTexture(GL_TEXTURE_2D, texture(4))             '' Select The Second Image Texture
			glBegin(GL_QUADS)             '' Start Drawing A Textured Quad
				glTexCoord2f(0.0, 0.0): glVertex3f(-1.1, -1.1,  0.0)    '' Bottom Left
				glTexCoord2f(1.0, 0.0): glVertex3f( 1.1, -1.1,  0.0)    '' Bottom Right
				glTexCoord2f(1.0, 1.0): glVertex3f( 1.1,  1.1,  0.0)    '' Top Right
				glTexCoord2f(0.0, 1.0): glVertex3f(-1.1,  1.1,  0.0)    '' Top Left
			glEnd()                       '' Done Drawing The Quad
	
		else                            '' Otherwise
	
			if masking then             '' Is Masking On?
				glBindTexture(GL_TEXTURE_2D, texture(1))          '' Select The First Mask Texture
				glBegin(GL_QUADS)           '' Start Drawing A Textured Quad
					glTexCoord2f(roll+0.0, 0.0): glVertex3f(-1.1, -1.1,  0.0)    '' Bottom Left
					glTexCoord2f(roll+4.0, 0.0): glVertex3f( 1.1, -1.1,  0.0)    '' Bottom Right
					glTexCoord2f(roll+4.0, 4.0): glVertex3f( 1.1,  1.1,  0.0)    '' Top Right
					glTexCoord2f(roll+0.0, 4.0): glVertex3f(-1.1,  1.1,  0.0)    '' Top Left
				glEnd()                     '' Done Drawing The Quad
			end if
	
			glBlendFunc(GL_ONE, GL_ONE)                          '' Copy Image 1 Color To The Screen
			glBindTexture(GL_TEXTURE_2D, texture(2))             '' Select The First Image Texture
			glBegin(GL_QUADS)             '' Start Drawing A Textured Quad
				glTexCoord2f(roll+0.0, 0.0): glVertex3f(-1.1, -1.1,  0.0)    '' Bottom Left
				glTexCoord2f(roll+4.0, 0.0): glVertex3f( 1.1, -1.1,  0.0)    '' Bottom Right
				glTexCoord2f(roll+4.0, 4.0): glVertex3f( 1.1,  1.1,  0.0)    '' Top Right
				glTexCoord2f(roll+0.0, 4.0): glVertex3f(-1.1,  1.1,  0.0)    '' Top Left
			glEnd()                        '' Done Drawing The Quad
		end if
	
		glEnable(GL_DEPTH_TEST)          '' Enable Depth Testing
		glDisable(GL_BLEND)              '' Disable Blending
	
		roll = roll + 0.002              '' Increase Our Texture Roll Variable
		if (roll > 1.0) then             '' Is Roll Greater Than One
			roll = roll - 1.0              '' Subtract 1 From Roll
		end if
	
		flip
	
		'' Keyboard handlers
		if MULTIKEY(FB.SC_M) and not sm then masking = not masking : sm = true
		if not MULTIKEY(FB.SC_M) then sm = false
	
		if MULTIKEY(FB.SC_SPACE) and not sp then scene = not scene : sp = true
		if not MULTIKEY(FB.SC_SPACE) then sp = false
	
	loop while MULTIKEY(FB.SC_ESCAPE) = 0
	
	'' Empty keyboard buffer
	while inkey <> "": wend
	
	end

'' Load Bitmaps And Convert To Textures
function LoadGLTextures() as integer
  dim gloop as integer

  dim TextureImage(5) as BITMAP_RGBImageRec ptr           '' Create Storage Space For The Textures

  TextureImage(0)=LoadBMP(exepath + "/data/Logo.bmp")                '' Logo Texture
  TextureImage(1)=LoadBMP(exepath + "/data/Mask1.bmp")               '' First Mask
  TextureImage(2)=LoadBMP(exepath + "/data/Image1.bmp")              '' First Image
  TextureImage(3)=LoadBMP(exepath + "/data/Mask2.bmp")               '' Second Mask
  TextureImage(4)=LoadBMP(exepath + "/data/Image2.bmp")              '' Second Image

  if (TextureImage(0) <> NULL and _
  	  TextureImage(1) <> NULL and _
  	  TextureImage(2) <> NULL and _
  	  TextureImage(3) <> NULL and _
  	  TextureImage(4) <> NULL) then
    LoadGLTextures = true
    glGenTextures(5, @texture(0))     '' Create Five Textures

    for gloop=0 to 4                  '' Loop Through All 5 Textures
      glBindTexture(GL_TEXTURE_2D, texture(gloop))
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR)
      glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR)
      glTexImage2D(GL_TEXTURE_2D, 0, 3, TextureImage(gloop)->sizeX, TextureImage(gloop)->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, TextureImage(gloop)->buffer)
    next
  else
    LoadGLTextures = false              '' Set return value to FALSE if textures not loaded
  end if

  for gloop=0 to 4                     '' Loop Through All 5 Textures
    if (TextureImage(gloop)) then      '' If Texture Exists
      if (TextureImage(gloop)->buffer) then               '' If Texture Image Exists
        deallocate(TextureImage(gloop)->buffer)           '' Free The Texture Image Memory
      end if
      deallocate(TextureImage(gloop))  '' Free The Image Structure
    end if
  next

end function
