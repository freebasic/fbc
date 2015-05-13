''
''    This Code Was Created By Jeff Molofee 2000
''    A HUGE Thanks To Fredric Echols For Cleaning Up
''    And Optimizing The Base Code, Making It More Flexible!
''    If You've Found This Code Useful, Please Let Me Know.
''    Visit My Site At nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press any key to quit
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson11.bas



#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "createtex.bi"

'' Setup our booleans
const FALSE = 0
const TRUE  = not FALSE


	dim texture(0) as uinteger                    '' Storage For One Texture

	dim points(44, 44, 2) as single               '' The Array For The Points On The Grid Of Our "Wave"
	dim wiggle_count as integer                   '' Counter Used To Control How Fast Flag Waves

	dim xrot as single                            '' X Rotation
	dim yrot as single                            '' Y Rotation
	dim zrot as single                            '' Z Rotation
	dim hold as single                            '' Temporarily Holds A Floating Point Value

	dim as integer x, y                           '' Loop Variables
	dim as single float_x, float_y, float_xb, float_yb  '' Used To Break The Flag Into Tiny Quads

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix

	'' Use BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte             '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Tim.bmp", @buffer(0)    '' BLOAD data from bitmap
	texture(0) = CreateTexture(@buffer(0))         '' Tim Texture
	if texture(0) = 0 then end 1                   '' Exit if error loading data file

	'' All Setup For OpenGL Goes Here
	glEnable GL_TEXTURE_2D                         '' Enable Texture Mapping
	glShadeModel GL_SMOOTH                         '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                '' Black Background
	glClearDepth 1.0                               '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                         '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                          '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST    '' Really Nice Perspective Calculations
	glPolygonMode GL_BACK, GL_FILL                      '' Back Face Is Solid
	glPolygonMode GL_FRONT, GL_LINE                     '' Front Face Is Made Of Lines

	'' Loop Through The X Plane
	for x = 0 to 44
		'' Loop Through The Y Plane
		for y = 0 to 44
			'' Apply The Wave To Our Mesh
			points(x,y,0)=(x/5.0)-4.5
			points(x,y,1)=(y/5.0)-4.5
			points(x,y,2)=sin((((x/5.0)*40.0)/360.0)*3.141592654*2.0)
		next
	next

	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear Screen And Depth Buffer
		glLoadIdentity                                          '' Reset The View

		glTranslatef 0.0, 0.0, -12.0                  '' Translate 12 Units Into The Screen

		glRotatef xrot, 1.0, 0.0, 0.0                 '' Rotate On The X Axis
		glRotatef yrot, 0.0, 1.0, 0.0                 '' Rotate On The Y Axis
		glRotatef zrot, 0.0, 0.0, 1.0                 '' Rotate On The Z Axis

		glBindTexture GL_TEXTURE_2D, texture(0)       '' Select Our Texture

		glBegin GL_QUADS                              '' Start Drawing Our Quads

			'' Loop Through The X Plane 0-44 (45 Points)
			for x = 0 to 43                            '' Max value of X = 43 so X+1 = 44 (=45 points)
				'' Loop Through The Y Plane 0-44 (45 Points)
				for y = 0 to 43
					float_x = (x)/44.0                '' Create A Floating Point X Value
					float_y = (y)/44.0                '' Create A Floating Point Y Value
					float_xb = (x+1)/44.0             '' Create A Floating Point X Value+0.0227
					float_yb = (y+1)/44.0             '' Create A Floating Point Y Value+0.0227

					glTexCoord2f float_x, float_y     '' First Texture Coordinate (Bottom Left)
					glVertex3f points(x,y,0), points(x,y,1), points(x,y,2)

					glTexCoord2f float_x, float_yb    '' Second Texture Coordinate (Top Left)
					glVertex3f points(x,y+1,0), points(x,y+1,1), points(x,y+1,2)

					glTexCoord2f float_xb, float_yb   '' Third Texture Coordinate (Top Right)
					glVertex3f points(x+1,y+1,0), points(x+1,y+1,1), points(x+1,y+1,2)

					glTexCoord2f float_xb, float_y    '' Fourth Texture Coordinate (Bottom Right)
					glVertex3f points(x+1,y,0), points(x+1,y,1), points(x+1,y,2)
				next
			next
		glEnd                                         '' Done Drawing Our Quads

		if wiggle_count = 2 then                      '' Used To Slow Down The Wave (Every 2nd Frame Only)
			for y = 0 to 44                           '' Loop Through The Y Plane
				hold=points(0,y,2)                    '' Store Current Value One Left Side Of Wave
				for x = 0 to 44                       '' Loop Through The X Plane
					if x < 44 then
						points(x,y,2) = points(x+1,y,2)   '' Current Wave Value Equals Value To The Right
					else
						points(x,y,2) = points(x-1,y,2)   '' Current Wave Value Equals Value To The Left
					end if
				next
				points(44,y,2)=hold                   '' Last Value Becomes The Far Left Stored Value
			next
			wiggle_count = 0                          '' Set Counter Back To Zero
		end if

		wiggle_count = wiggle_count + 1               '' Increase The Counter

		xrot = xrot + 0.3                             '' Increase The X Rotation Variable
		yrot = yrot + 0.2                             '' Increase The Y Rotation Variable
		zrot = zrot + 0.4                             '' Increase The Z Rotation Variable

		flip                                          '' flip or crash
	loop while inkey = ""
	end
