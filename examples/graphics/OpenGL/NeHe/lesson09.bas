''
'' This Code Was Created By Jeff Molofee 2000
'' A HUGE Thanks To Fredric Echols For Cleaning Up
'' And Optimizing The Base Code, Making It More Flexible!
'' If You've Found This Code Useful, Please Let Me Know.
'' Visit My Site At nehe.gamedev.net
''

'' compile as: fbc -s gui lesson09.bas

''------------------------------------------------------------------------------
'' Use ESC key to quit
'' T key to toggle Twinkling (on/off)
'' PgUp key and PgDn key to Zoom in and out
'' UpArrow, DnArrow to tilt screen up and down
''
''------------------------------------------------------------------------------



#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "bmpload.bi"
#include once "fbgfx.bi"                   ''for Scan code constants

'' Setup our booleans
const false = 0
const true  = not false

const num = 50                                 '' Number Of Stars To Draw
	
type STARS                                     '' Create A Structure For Star
	r as integer                                '' Stars Color
	g as integer                                '' Stars Color
	b as integer                                '' Stars Color
	dist as single                              '' Stars Distance From Center
	angle as single                             '' Stars Current Angle
end type
	
declare function LoadGLTextures() as integer

	dim shared texture(0) as GLuint                '' Storage For One Texture
	dim shared twinkle as integer                  '' Twinkling Stars
	dim shared tp as integer                       '' T Pressed?
	
	dim star(0 to num-1) as STARS                  '' Need To Keep Track Of 'num' Stars
	
	dim zoom as single = -15.0                     '' Distance Away From Stars
	dim tilt as single = 90.0                      '' Tilt The View
	dim spin as single                             '' Spin Stars
	
	dim gl_loop as uinteger                        '' General loop Variable
	
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
	glEnable GL_TEXTURE_2D                              '' Enable Texture Mapping
	glShadeModel GL_SMOOTH                              '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                     '' Black Background
	glClearDepth 1.0                                    '' Depth Buffer Setup
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST    '' Really Nice Perspective Calculations
	glBlendFunc(GL_SRC_ALPHA,GL_ONE)                    '' Set The Blending Function For Translucency
	glEnable(GL_BLEND)
	
	randomize timer
	for gl_loop=0 to num -1                             '' Create A Loop That Goes Through All The Stars
		star(gl_loop).angle = 0.0                         '' Start All The Stars At Angle Zero
		star(gl_loop).dist = (gl_loop/num)*5.0            '' Calculate Distance From The Center
		star(gl_loop).r = int(rnd * 256)                  '' Give star(loop) A Random Red Intensity
		star(gl_loop).g = int(rnd * 256)                  '' Give star(loop) A Random Green Intensity
		star(gl_loop).b = int(rnd * 256)                  '' Give star(loop) A Random Blue Intensity
	next
	
	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT     '' Clear The Screen And The Depth Buffer
		glBindTexture GL_TEXTURE_2D, texture(0)                '' Select Our Texture
	
		for gl_loop=0 to num-1                                 '' loop Through All The Stars
	
			glLoadIdentity                                       '' Reset The View Before We Draw Each Star
			glTranslatef 0.0, 0.0, zoom                          '' Zoom Into The Screen (Using The Value In 'zoom')
			glRotatef tilt, 1.0, 0.0, 0.0                        '' Tilt The View (Using The Value In 'tilt')
			glRotatef star(gl_loop).angle, 0.0, 1.0, 0.0         '' Rotate To The Current Stars Angle
			glTranslatef star(gl_loop).dist, 0.0, 0.0            '' Move Forward On The X Plane
			glRotatef -star(gl_loop).angle, 0.0, 1.0, 0.0        '' Cancel The Current Stars Angle
			glRotatef -tilt, 1.0, 0.0, 0.0                       '' Cancel The Screen Tilt
	
			if twinkle then                                      '' Twinkling Stars Enabled
				'' Assign A Color Using Bytes
				glColor4ub star((num-gl_loop)-1).r, star((num-gl_loop)-1).g, star((num-gl_loop)-1).b, 255
				glBegin GL_QUADS                                   '' Begin Drawing The Textured Quad
					glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0, 0.0
					glTexCoord2f 1.0, 0.0 : glVertex3f 1.0, -1.0, 0.0
					glTexCoord2f 1.0, 1.0 : glVertex3f 1.0, 1.0, 0.0
					glTexCoord2f 0.0, 1.0 : glVertex3f -1.0, 1.0, 0.0
				glEnd                                              '' Done Drawing The Textured Quad
			end if
	
			glRotatef spin, 0.0, 0.0, 1.0                        '' Rotate The Star On The Z Axis
			'' Assign A Color Using Bytes
			glColor4ub star(gl_loop).r, star(gl_loop).g, star(gl_loop).b, 255
			glBegin GL_QUADS                                     '' Begin Drawing The Textured Quad
				glTexCoord2f 0.0, 0.0 : glVertex3f -1.0, -1.0, 0.0
				glTexCoord2f 1.0, 0.0 : glVertex3f 1.0, -1.0, 0.0
				glTexCoord2f 1.0, 1.0 : glVertex3f 1.0, 1.0, 0.0
				glTexCoord2f 0.0, 1.0 : glVertex3f -1.0, 1.0, 0.0
			glEnd                                                '' Done Drawing The Textured Quad
	
			spin = spin + 0.01                                   '' Used To Spin The Stars
			star(gl_loop).angle += gl_loop/num                   '' Changes The Angle Of A Star
			star(gl_loop).dist  -= 0.01                          '' Changes The Distance Of A Star
	
			if star(gl_loop).dist < 0.0 then                     '' Is The Star In The Middle Yet
				star(gl_loop).dist = star(gl_loop).dist + 5.0      '' Move The Star 5 Units From The Center
				star(gl_loop).r = int(rnd * 256)                   '' Give It A New Red Value
				star(gl_loop).g = int(rnd * 256)                   '' Give It A New Green Value
				star(gl_loop).b = int(rnd * 256)                   '' Give It A New Blue Value
			end if
		next
	
		'' Keyboard handlers
		if MULTIKEY(FB.SC_T) and not tp then       '' T Key down
			tp = true
			twinkle = not twinkle                 '' toggle twinkle on /off
		end if
		if not MULTIKEY(FB.SC_T) then tp = false   '' T key up
	
		if MULTIKEY(FB.SC_UP) then tilt = tilt - 0.5          '' If Up Arrow is Being Pressed, Tilt The Screen Up
		if MULTIKEY(FB.SC_DOWN) then tilt = tilt + 0.5        '' If Down Arrow Being Pressed, Tilt The Screen Down
		if MULTIKEY(FB.SC_PAGEUP) then zoom = zoom - 0.2f     '' If Page Up is Being Pressed, Zoom Out
		if MULTIKEY(FB.SC_PAGEDOWN) then zoom = zoom + 0.2    '' If Page Down is Being Pressed, Zoom In
	
	
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
  TextureImage(0) = LoadBMP(exepath + "/data/Star.bmp")
  if TextureImage(0) then
    Status = true                                   '' Set The Status To TRUE
    glGenTextures 1, @texture(0)                    '' Create The Texture

    ' Create Linear Filtered Texture
    glBindTexture GL_TEXTURE_2D, texture(0)
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR
    glTexParameteri GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR
    glTexImage2D GL_TEXTURE_2D, 0, 3, TextureImage(0)->sizeX, TextureImage(0)->sizeY, 0, GL_RGB, GL_UNSIGNED_BYTE, TextureImage(0)->buffer

  end if

  if TextureImage(0) then                           '' If Texture Exists
    if TextureImage(0)->buffer then                 '' If Texture Image Exist
      deallocate(TextureImage(0)->buffer)           '' Free The Texture Image Memory
    end if
    deallocate(TextureImage(0))                     '' Free The Image Structure
  end if

  return Status                                     '' Return The Status
end function
