''
''    This Code Was Created By Jeff Molofee 2000
''    A HUGE Thanks To Fredric Echols For Cleaning Up
''    And Optimizing The Base Code, Making It More Flexible!
''    If You've Found This Code Useful, Please Let Me Know.
''    Visit My Site At nehe.gamedev.net

'' compile as: fbc -s gui lesson06.bas



#include once "GL/gl.bi"
#include once "GL/glu.bi"

'' Setup our booleans
const FALSE = 0
const TRUE  = not FALSE

#include once "bmpload.bi"

declare function LoadGLTextures() as integer


	dim shared texture(0) as GLuint               '' Storage For One Texture ( NEW )
	
	dim xrot as single                            '' X Rotation ( NEW )
	dim yrot as single                            '' Y Rotation ( NEW )
	dim zrot as single                            '' Z Rotation ( NEW )
	
	
	
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
	glEnable GL_TEXTURE_2D                         '' Enable Texture Mapping ( NEW )
	glShadeModel GL_SMOOTH                         '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                '' Black Background
	glClearDepth 1.0                               '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                         '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                          '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST    '' Really Nice Perspective Calculations
	
	
	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear Screen And Depth Buffer
		glLoadIdentity                                          '' Reset The View
		glTranslatef 0.0, 0.0, -5.0                             '' Move Into The Screen 5 Units
		
		glRotatef xrot,1.0, 0.0, 0.0                            '' Rotate On The X Axis
		glRotatef yrot,0.0, 1.0, 0.0                            '' Rotate On The Y Axis
		glRotatef zrot,0.0, 0.0, 1.0                            '' Rotate On The Z Axis
		
		glBindTexture GL_TEXTURE_2D, texture(0)                 '' Select Our Texture
		
		glBegin GL_QUADS
			' Front Face
			glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0,  1.0  '' Bottom Left Of The Texture and Quad
			glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0,  1.0  '' Bottom Right Of The Texture and Quad
			glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0,  1.0  '' Top Right Of The Texture and Quad
			glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0,  1.0  '' Top Left Of The Texture and Quad
			' Back Face
			glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0, -1.0  '' Bottom Right Of The Texture and Quad
			glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0, -1.0  '' Top Right Of The Texture and Quad
			glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0, -1.0  '' Top Left Of The Texture and Quad
			glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0, -1.0  '' Bottom Left Of The Texture and Quad
			' Top Face
			glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0  '' Top Left Of The Texture and Quad
			glTexCoord2f 0.0, 0.0 : glVertex3f -1.0,  1.0,  1.0  '' Bottom Left Of The Texture and Quad
			glTexCoord2f 1.0, 0.0 : glVertex3f  1.0,  1.0,  1.0  '' Bottom Right Of The Texture and Quad
			glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0  '' Top Right Of The Texture and Quad
			' Bottom Face
			glTexCoord2f 1.0, 1.0 : glVertex3f -1.0, -1.0, -1.0  '' Top Right Of The Texture and Quad
			glTexCoord2f 0.0, 1.0 : glVertex3f  1.0, -1.0, -1.0  '' Top Left Of The Texture and Quad
			glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0  '' Bottom Left Of The Texture and Quad
			glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0  '' Bottom Right Of The Texture and Quad
			' Right face
			glTexCoord2f 1.0, 0.0 : glVertex3f  1.0, -1.0, -1.0  '' Bottom Right Of The Texture and Quad
			glTexCoord2f 1.0, 1.0 : glVertex3f  1.0,  1.0, -1.0  '' Top Right Of The Texture and Quad
			glTexCoord2f 0.0, 1.0 : glVertex3f  1.0,  1.0,  1.0  '' Top Left Of The Texture and Quad
			glTexCoord2f 0.0, 0.0 : glVertex3f  1.0, -1.0,  1.0  '' Bottom Left Of The Texture and Quad
			' Left Face
			glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0, -1.0  '' Bottom Left Of The Texture and Quad
			glTexCoord2f 1.0, 0.0 : glVertex3f -1.0, -1.0,  1.0  '' Bottom Right Of The Texture and Quad
			glTexCoord2f 1.0, 1.0 : glVertex3f -1.0,  1.0,  1.0  '' Top Right Of The Texture and Quad
			glTexCoord2f 0.0, 1.0 : glVertex3f -1.0,  1.0, -1.0  '' Top Left Of The Texture and Quad
		glEnd
		
		xrot += 0.3     '' X Axis Rotation
		yrot += 0.2     '' Y Axis Rotation
		zrot += 0.4     '' Z Axis Rotation
		
		flip
	loop while inkey = ""
	

'' Load Bitmaps And Convert To Textures
function LoadGLTextures() as integer
  dim Status as integer = FALSE                     '' Status Indicator
  dim TextureImage(0) as BITMAP_RGBImageRec ptr     '' Create Storage Space For The Texture

  ' Load The Bitmap, Check For Errors, If Bitmap's Not Found Quit
  TextureImage(0) = LoadBMP(exepath + "/data/NeHe.bmp")
  if TextureImage(0) then
    Status = TRUE                                   '' Set The Status To TRUE
    glGenTextures 1, @texture(0)                    '' Create The Texture
    ' Typical Texture Generation Using Data From The Bitmap
    glBindTexture GL_TEXTURE_2D, texture(0)
    glTexImage2D GL_TEXTURE_2D, 0, 3, TextureImage(0)->sizeX, TextureImage(0)->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, TextureImage(0)->buffer
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR
  end if

  if TextureImage(0) then                           '' If Texture Exists
    if TextureImage(0)->buffer then                 '' If Texture Image Exist
      deallocate(TextureImage(0)->buffer)           '' Free The Texture Image Memory
    end if
    deallocate(TextureImage(0))                     '' Free The Image Structure
  end if

  return Status                                     '' Return The Status
end function
