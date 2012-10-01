''  The OpenGL Basecode Used In This Project Was Created By
''  Jeff Molofee ( NeHe ).  1997-2000.  If You Find This Code
''  Useful, Please Let Me Know.
''
''  Original Code & Tutorial Text By Andreas L�ffler
''  Excellent Job Andreas!
''
''  Code Heavily Modified By Rob Fletcher ( rpf1@york.ac.uk )
''  Proper Image Structure, Better Blitter Code, Misc Fixes
''  Thanks Rob!
''
''
''  Visit Me At nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson29.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = 0


#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                '' for Scan code constants

''------------------------------------------------------------------------------
'' User Types
'' Types must be before function declares
type TEXTURE_IMAGE
	wwidth as integer                   '' Width Of Image In Pixels
	height as integer                   '' Height Of Image In Pixels
	format as integer                   '' Number Of Bytes Per Pixel
	buffer as ubyte ptr                 '' Texture Data
end type

''------------------------------------------------------------------------------
'' Declare user functions
declare function AllocateTextureBuffer(byval w as integer, byval h as integer, byval f as integer) as TEXTURE_IMAGE ptr
declare sub DeallocateTexture(byval t as TEXTURE_IMAGE ptr)
declare function ReadTextureData(byref filename as string, byval buffer as TEXTURE_IMAGE ptr) as integer
declare sub BuildTexture(byval tex as TEXTURE_IMAGE ptr)
declare sub Blit(byval src as TEXTURE_IMAGE ptr, byval dst as TEXTURE_IMAGE ptr, _
	byval src_xstart as integer, byval src_ystart as integer, byval src_width as integer, _
	byval src_height as integer, byval dst_xstart as integer, byval dst_ystart as integer, _
	byval blend as integer, byval alpha as integer)
declare function InitGL() as integer

''------------------------------------------------------------------------------
'' Declare Global Variables
dim shared texture(0) as uinteger     '' Storage For 1 Texture
dim shared t1 as TEXTURE_IMAGE ptr    '' Pointer To The Texture Image Data Type
dim shared t2 as TEXTURE_IMAGE ptr    '' Pointer To The Texture Image Data Type

	dim xrot as single            '' X Rotation
	dim yrot as single            '' Y Rotation
	dim zrot as single            '' Z Rotation

	windowtitle "Andreas L�ffler, Rob Fletcher & NeHe's Blitter & Raw Image Loading Tutorial"   '' Set window title
	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                  '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                 '' Select The Projection Matrix
	glLoadIdentity                             '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                  '' Select The Modelview Matrix
	glLoadIdentity                             '' Reset The Projection Matrix

	InitGL()                                   '' All Setup For OpenGL Goes Here

	do
		glClear(GL_COLOR_BUFFER_BIT  or  GL_DEPTH_BUFFER_BIT)  '' Clear The Screen And The Depth Buffer
		glLoadIdentity()                                       '' Reset The View
		glTranslatef(0.0, 0.0, - 5.0)

		glRotatef(xrot, 1.0, 0.0, 0.0)
		glRotatef(yrot, 0.0, 1.0, 0.0)
		glRotatef(zrot, 0.0, 0.0, 1.0)

		glBindTexture(GL_TEXTURE_2D, texture(0))

		glBegin(GL_QUADS)
			'' Front Face
			glNormal3f(0.0, 0.0, 1.0)
			glTexCoord2f(1.0, 1.0) : glVertex3f(1.0, 1.0, 1.0)
			glTexCoord2f(0.0, 1.0) : glVertex3f(- 1.0, 1.0, 1.0)
			glTexCoord2f(0.0, 0.0) : glVertex3f(- 1.0, - 1.0, 1.0)
			glTexCoord2f(1.0, 0.0) : glVertex3f(1.0, - 1.0, 1.0)
			'' Back Face
			glNormal3f(0.0, 0.0, - 1.0)
			glTexCoord2f(1.0, 1.0) : glVertex3f(- 1.0, 1.0, - 1.0)
			glTexCoord2f(0.0, 1.0) : glVertex3f(1.0, 1.0, - 1.0)
			glTexCoord2f(0.0, 0.0) : glVertex3f(1.0, - 1.0, - 1.0)
			glTexCoord2f(1.0, 0.0) : glVertex3f(- 1.0, - 1.0, - 1.0)
			'' Top Face
			glNormal3f(0.0, 1.0, 0.0)
			glTexCoord2f(1.0, 1.0) : glVertex3f(1.0, 1.0, - 1.0)
			glTexCoord2f(0.0, 1.0) : glVertex3f(- 1.0, 1.0, - 1.0)
			glTexCoord2f(0.0, 0.0) : glVertex3f(- 1.0, 1.0, 1.0)
			glTexCoord2f(1.0, 0.0) : glVertex3f(1.0, 1.0, 1.0)
			'' Bottom Face
			glNormal3f(0.0, - 1.0, 0.0)
			glTexCoord2f(0.0, 0.0) : glVertex3f(1.0, - 1.0, 1.0)
			glTexCoord2f(1.0, 0.0) : glVertex3f(- 1.0, - 1.0, 1.0)
			glTexCoord2f(1.0, 1.0) : glVertex3f(- 1.0, - 1.0, - 1.0)
			glTexCoord2f(0.0, 1.0) : glVertex3f(1.0, - 1.0, - 1.0)
			'' Right Face
			glNormal3f(1.0, 0.0, 0.0)
			glTexCoord2f(1.0, 0.0) : glVertex3f(1.0, - 1.0, - 1.0)
			glTexCoord2f(1.0, 1.0) : glVertex3f(1.0, 1.0, - 1.0)
			glTexCoord2f(0.0, 1.0) : glVertex3f(1.0, 1.0, 1.0)
			glTexCoord2f(0.0, 0.0) : glVertex3f(1.0, - 1.0, 1.0)
			'' Left Face
			glNormal3f(- 1.0, 0.0, 0.0)
			glTexCoord2f(0.0, 0.0) : glVertex3f(- 1.0, - 1.0, - 1.0)
			glTexCoord2f(1.0, 0.0) : glVertex3f(- 1.0, - 1.0, 1.0)
			glTexCoord2f(1.0, 1.0) : glVertex3f(- 1.0, 1.0, 1.0)
			glTexCoord2f(0.0, 1.0) : glVertex3f(- 1.0, 1.0, - 1.0)
		glEnd()

		xrot = xrot + 0.3
		yrot = yrot + 0.2
		zrot = zrot + 0.4

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do              '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while inkey <> "": wend

	end

''------------------------------------------------------------------------------
'' Allocate An Image Structure And Inside Allocate Its Memory Requirements
function AllocateTextureBuffer(byval w as integer, byval h as integer, byval f as integer) as TEXTURE_IMAGE ptr
	dim ti as TEXTURE_IMAGE ptr         '' Pointer To Image Struct
	dim c as ubyte ptr                  '' Pointer To Block Memory For Image

	ti = allocate(len(TEXTURE_IMAGE))   '' One Image Struct Please
	if ti <> null then
		ti->wwidth = w                  '' Set Width
		ti->height = h                  '' Set Height
		ti->format = f                  '' Set Format
		c = allocate (w * h * f)
		if c <> null then
			ti->buffer = c
		else
			AllocateTextureBuffer = null
			exit function
		end if
	else
		AllocateTextureBuffer = null
		exit function
	end if
	AllocateTextureBuffer = ti
	exit function                       '' Return Pointer To Image Struct
end function

''------------------------------------------------------------------------------
'' Free Up The Image Data
sub DeallocateTexture(byval t as TEXTURE_IMAGE ptr)
	if t then
		if t->buffer then
			deallocate(t->buffer)       '' Free Its Image Buffer
		end if
		deallocate(t)                   '' Free Itself
	end if
end sub

''------------------------------------------------------------------------------
'' Read A .RAW File In To The Allocated Image Buffer Using Data In The Image Structure Header.
'' Flip The Image Top To Bottom.  Returns 0 For Failure Of Read, Or Number Of Bytes Read.
function ReadTextureData(byref filename as string, byval buffer as TEXTURE_IMAGE ptr) as integer
	dim f as integer
	dim i as integer, j as integer, k as integer, done as integer
	dim stride as integer
	dim p as ubyte ptr

	stride = buffer->wwidth * buffer->format    '' Size Of A Row (Width * Bytes Per Pixel)

	f = freefile
	if (open (filename, for binary, as #f) = 0) then
		'' Loop Through Height (Bottoms Up - Flip Image)
		i=buffer->height-1
		while i>=0
			p = buffer->buffer + (i * stride)
			for j = 0 to buffer->wwidth - 1     '' Loop Through Width
				for k= 0 to buffer->format-2
					get #f,, *p                 '' Read Value From File And Store In Memory
					p = p + 1 : done = done + 1
				next
				*p = 255 : p = P + 1            '' Store 255 In Alpha Channel And Increase Pointer
			next
			i = i - 1
		wend
		close #f                                '' Close The File
	end if
	ReadTextureData = done                      '' Returns Number Of Bytes Read In
end function

''------------------------------------------------------------------------------
sub BuildTexture(byval tex as TEXTURE_IMAGE ptr)
	glGenTextures(1, @texture(0))
	glBindTexture(GL_TEXTURE_2D, texture(0))
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
	gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGB, tex->wwidth, tex->height, GL_RGBA, GL_UNSIGNED_BYTE, tex->buffer)
end sub

''------------------------------------------------------------------------------
sub Blit(byval src as TEXTURE_IMAGE ptr, byval dst as TEXTURE_IMAGE ptr, _
		byval src_xstart as integer, byval src_ystart as integer, byval src_width as integer, _
		byval src_height as integer, byval dst_xstart as integer, byval dst_ystart as integer, _
		byval blend as integer, byval alpha as integer)

	dim i as integer, j as integer, k as integer
	dim s as ubyte ptr, d as ubyte ptr          '' Source & Destination

	'' Clamp Alpha If Value Is Out Of Range
	if alpha > 255 then alpha = 255
	if alpha < 0 then alpha = 0

	'' Check For Incorrect Blend Flag Values
	if blend < 0 then blend = 0
	if blend > 1 then blend = 1

	d = dst->buffer + (dst_ystart * dst->wwidth * dst->format)     '' Start Row - dst (Row * Width In Pixels * Bytes Per Pixel)
	s = src->buffer + (src_ystart * src->wwidth * src->format)     '' Start Row - src (Row * Width In Pixels * Bytes Per Pixel)

	for i = 0 to src_height - 1                 '' Height Loop
		s = s + (src_xstart * src->format)      '' Move Through Src Data By Bytes Per Pixel
		d = d + (dst_xstart * dst->format)      '' Move Through Dst Data By Bytes Per Pixel
		for j = 0 to src_width-1                '' Width Loop
			'' "n" Bytes At A Time
			for k = 0 to src->format -1
				if blend then                 '' If Blending Is On
					'' Multiply Src Data*alpha Add Dst Data*(255-alpha)
					*d = ((*s * alpha) + (*d * (255 - alpha))) shr 8  '' Keep in 0-255 Range With >> 8
				else                                                  '' No Blending Just Do A Straight Copy
					*d = *s
				end if
				d = d + 1 : s = s + 1
			next
		next
		d = d + (dst->wwidth - (src_width + dst_xstart)) * dst->format        '' Add End Of Row
		s = s + (src->wwidth - (src_width + src_xstart)) * src->format        '' Add End Of Row
	next
end sub


''------------------------------------------------------------------------------
'' This Will Be Called Right After The GL Window Is Set up
function InitGL() as integer
	t1 = AllocateTextureBuffer(128, 128, 4)             '' Get An Image Structure
	'' Fill The Image Structure With Data
	if ReadTextureData(exepath + "/data/Monitor.raw", t1) = 0 then '' Nothing Read?
		InitGL = false
		exit function
	end if
	t2 = AllocateTextureBuffer(128, 128, 4)             '' Second Image Structure
	'' Fill The Image Structure With Data
	if ReadTextureData(exepath + "/data/GL.raw", t2) = 0 then      '' Nothing Read?
		InitGL = false
		exit function
	end if
	'' Image To Blend In, Original Image, Src Start X & Y, Src Width & Height, Dst Location X & Y, Blend Flag, Alpha Value
	Blit(t2, t1, 63, 63, 64, 64, 32, 32, 1, 127)    '' Call The Blitter Routine

	BuildTexture(t1)                                    '' Load The Texture Map Into Texture Memory

	DeallocateTexture(t1)                               '' Clean Up Image Memory Because Texture Is
	DeallocateTexture(t2)                               '' In GL Texture Memory Now

	glEnable(GL_TEXTURE_2D)                             '' Enable Texture Mapping

	glShadeModel(GL_SMOOTH)                             '' Enables Smooth Color Shading
	glClearColor(0.0, 0.0, 0.0, 0.0)                    '' This Will Clear The Background Color To Black
	glClearDepth(1.0)                                   '' Enables Clearing Of The Depth Buffer
	glEnable(GL_DEPTH_TEST)                             '' Enables Depth Testing
	glDepthFunc(GL_LESS)                                '' The Type Of Depth Test To Do

	InitGL = true
end function

