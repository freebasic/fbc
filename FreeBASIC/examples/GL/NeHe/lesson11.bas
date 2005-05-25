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

option explicit

#include once "GL/gl.bi"
#include once "GL/glu.bi"

'' Setup our booleans
const FALSE = 0
const TRUE  = not FALSE

const TEX_MASKED = &h1
const TEX_MIPMAP = &h2
const TEX_NOFILTER = &h4
const TEX_HASALPHA = &h8
'-------------------------------------------------------------------------------
declare function CreateTexture( byval buffer as any ptr, byval flags as integer = 0) as uinteger

	dim texture(0) as uinteger                    '' Storage For One Texture

	dim points(44, 44, 2) as single               '' The Array For The Points On The Grid Of Our "Wave"
	dim wiggle_count as integer                   '' Counter Used To Control How Fast Flag Waves

	dim xrot as single                            '' X Rotation
	dim yrot as single                            '' Y Rotation
	dim zrot as single                            '' Z Rotation
	dim hold as single                            '' Temporarily Holds A Floating Point Value

	dim as integer x, y                           '' Loop Variables
	dim as single float_x, float_y, float_xb, float_yb  '' Used To Break The Flag Into Tiny Quads

	screen 18, 32, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix

	'' Use BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte             '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload "data/Tim.bmp", @buffer(0)               '' BLOAD data from bitmap
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
					points(x,y,2) = points(x+1,y,2)   '' Current Wave Value Equals Value To The Right
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
	loop while inkey$ = ""
	end

'------------------------------------------------------------------------
'' Create texture creates textures from BLOAD buffer
function CreateTexture( byval buffer as any ptr, byval flags as integer = 0 ) as uinteger

	redim dat(0) as ubyte
	dim p as uinteger ptr, s as ushort ptr
	dim as integer w, h, x, y, col
	dim tex as uinteger
	dim as GLenum format, minfilter, magfilter

	CreateTexture = 0

	s = buffer
	w = s[0] shr 3
	h = s[1]

	if( (w < 64) or (h < 64) ) then
		exit function
	end if
	if( (w and (w-1)) or (h and (h-1)) ) then
		'' Width/height not powers of 2
		exit function
	end if

	redim dat(w * h * 4) as ubyte
	p = @dat(0)

	glGenTextures 1, @tex
	glBindTexture GL_TEXTURE_2D, tex

	for y = h-1 to 0 step -1
		for x = 0 to w-1
			col = point(x, y, buffer)
			'' Swap R and B so we can use the GL_RGBA texture format
			col = rgb(col and &hFF, _
				(col shr 8) and &hFF, _
				(col shr 16) and &hFF)
			if( (flags and TEX_MASKED) and (col = &hFF00FF) ) then
				*p = 0
			else
				*p = col or &hFF000000
			end if
			p += 4
		next x
	next y

	if (flags and (TEX_MASKED or TEX_HASALPHA)) then
		format = GL_RGBA
	else
		format = GL_RGB
	end if

	if (flags and TEX_NOFILTER) then
		magfilter = GL_NEAREST
	else
		magfilter = GL_LINEAR
	end if

	if( flags and TEX_MIPMAP) then
		gluBuild2DMipmaps GL_TEXTURE_2D, format, w, h, GL_RGBA, _
			GL_UNSIGNED_BYTE, @dat(0)

		if (flags and TEX_NOFILTER) then
			minfilter = GL_LINEAR_MIPMAP_NEAREST
		else
			minfilter = GL_LINEAR_MIPMAP_LINEAR
		end if
	else
		glTexImage2D GL_TEXTURE_2D, 0, format, w, h, 0, GL_RGBA, _
			GL_UNSIGNED_BYTE, @dat(0)
		minfilter = magfilter
	end if
	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, minfilter
	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, magfilter

	CreateTexture = tex

end function
