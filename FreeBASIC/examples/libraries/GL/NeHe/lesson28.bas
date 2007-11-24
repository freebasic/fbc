''
''  This Code Was Published By Jeff Molofee 2000
''  Code Was Created By David Nikdel For NeHe Productions
''  If You've Found This Code Useful, Please Let Me Know.
''  Visit My Site At nehe.gamedev.net
''
''   NeHe Productions ... http://nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' Use Up and Down arrow keys to apply Bezier
'' Space bar to toggle grid lines
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson28.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                '' for Scan code constants
#include once "createtex.bi"

type POINT_3D                                  '' Structure for a 3-dimensional point (NEW)
	x as double
	y as double
	z as double
end type

type BEZIER_PATCH                              '' Structure for a 3rd degree bezier patch (NEW)
	anchors(0 to 3, 0 to 3) as POINT_3D        '' 4x4 grid of anchor points
	dlBPatch as uinteger                       '' Display List for Bezier Patch
	texture as uinteger                        '' Texture for the patch
end type

declare sub pointAdd (byref p as POINT_3D, byref q as POINT_3D, byref ret as POINT_3D)
declare sub pointTimes (byval c as double, byref p as POINT_3D, byref ret as POINT_3D)
declare sub makePoint (byval a as double, byval b as double, byval c as double, byref ret as POINT_3D)
declare sub Bernstein (byval u as single, byval p as POINT_3D ptr, byref ret as POINT_3D)
declare function genBezier (byref patch as BEZIER_PATCH, byval divs as integer) as uinteger
declare sub initBezier()

dim shared as BEZIER_PATCH mybezier            '' The bezier patch we're going to use (NEW)

	dim as integer showCPoints = true          '' Toggles displaying the control point grid (NEW)
	dim as integer divs = 7                    '' Number of intrapolations (conrols poly resolution) (NEW)
	dim i as integer, j as integer
	dim as single rotz = 0.0                   '' Rotation about the Z axis
	dim as integer upp, dnp, sp                '' key pressed flags

	windowtitle "David Nikdel & NeHe's Bezier Tutorial"   '' Set window title
	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                  '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                 '' Select The Projection Matrix
	glLoadIdentity                             '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                  '' Select The Modelview Matrix
	glLoadIdentity                             '' Reset The Projection Matrix

	'' All Setup For OpenGL Goes Here
	glEnable (GL_TEXTURE_2D)                   '' Enable Texture Mapping
	glShadeModel (GL_SMOOTH)                   '' Enable Smooth Shading
	glClearColor (0.05, 0.05, 0.05, 0.5)       '' Black Background
	glClearDepth (1.0)                         '' Depth Buffer Setup
	glEnable (GL_DEPTH_TEST)                   '' Enables Depth Testing
	glDepthFunc (GL_LEQUAL)                    '' The Type Of Depth Testing To Do
	glHint (GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)     '' Really Nice Perspective Calculations

	initBezier ()                              '' Initialize the Bezier's control grid
	redim buffer(256*256*4+4) as ubyte         '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/NeHe.bmp", @buffer(0)        '' BLOAD data from bitmap
	mybezier.texture = CreateTexture(@buffer(0))           '' Linear Texture (default)
	if mybezier.texture = 0 then end 1                     '' exit if texture did not load
	mybezier.dlBPatch = genBezier (mybezier, divs)         '' Generate the patch

	do
		glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)  '' Clear Screen And Depth Buffer
		glLoadIdentity ()                                     '' Reset The Current Modelview Matrix
		glTranslatef (0.0, 0.0, - 4.0)         '' Move Left 1.5 Units And Into The Screen 6.0
		glRotatef (- 75.0, 1.0, 0.0, 0.0)
		glRotatef (rotz, 0.0, 0.0, 1.0)        '' Rotate The Triangle On The Z axis ( NEW )
		glCallList (mybezier.dlBPatch)         '' Call the Bezier's display list
		                                       '' this need only be updated when the patch changes
		if (showCPoints) then                  '' If drawing the grid is toggled on
			glDisable (GL_TEXTURE_2D)
			glColor3f (1.0, 0.0, 0.0)
			for i= 0 to 3                      '' draw the horizontal lines
				glBegin (GL_LINE_STRIP)
					for j= 0 to 3
						glVertex3d (mybezier.anchors(i,j).x, mybezier.anchors(i,j).y, mybezier.anchors(i,j).z)
					next
				glEnd ()
			next
			for i = 0 to 3                     '' draw the vertical lines
				glBegin (GL_LINE_STRIP)
					for j = 0 to 3
						glVertex3d (mybezier.anchors(j,i).x, mybezier.anchors(j,i).y, mybezier.anchors(j,i).z)
					next
				glEnd ()
			next
			glColor3f (1.0, 1.0, 1.0)
			glEnable (GL_TEXTURE_2D)
		end if


		'' Keyboard handlers
		if MULTIKEY(FB.SC_LEFT) then                           '' rotate left
			rotz -= 0.8f
		end if
		if MULTIKEY(FB.SC_RIGHT) then                          '' rotate right
			rotz += 0.8f
		end if
		if MULTIKEY(FB.SC_UP) and not upp then                 '' resolution up
			upp = true
			divs = divs +1
			mybezier.dlBPatch = genBezier (mybezier, divs)  '' Update the patch
		end if
		if not MULTIKEY(FB.SC_UP) then upp = false

		if MULTIKEY(FB.SC_DOWN) and  divs > 1 and not dnp then
			dnp = true
			divs = divs -1
			mybezier.dlBPatch = genBezier (mybezier, divs)  '' Update the patch
		end if
		if not MULTIKEY(FB.SC_DOWN) then dnp = false

		if MULTIKEY(FB.SC_SPACE) and not sp then               '' SPACE toggles showCPoints
			sp = true
			showCPoints =  not  showCPoints
		end if
		if not MULTIKEY(FB.SC_SPACE) then sp = false

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do              '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while inkey <> "": wend


	end

''---------------------------------------------------
'' Adds 2 points. Don't just use '+' ;)
sub pointAdd (byref p as POINT_3D, byref q as POINT_3D, byref ret as POINT_3D)
	ret.x = p.x + q.x
	ret.y = p.y + q.y
	ret.z = p.z + q.z
end sub

''---------------------------------------------------
'' Multiplies a point and a constant. Don't just use '*'
sub pointTimes (byval c as double, byref p as POINT_3D, byref ret as POINT_3D)
	ret.x = p.x*c
	ret.y = p.y * c
	ret.z = p.z * c
end sub

''---------------------------------------------------
'' Function for quick point creation
sub makePoint (byval a as double, byval b as double, byval c as double, byref ret as POINT_3D)
	ret.x = a
	ret.y = b
	ret.z = c
end sub

''---------------------------------------------------
'' Calculates 3rd degree polynomial based on array of 4 points
'' and a single variable (u) which is generally between 0 and 1
sub Bernstein (byval u as single, byval p as POINT_3D ptr, byref ret as POINT_3D)
	dim  as POINT_3D a, b, c, d
	dim as POINT_3D r1, r2

	pointTimes ((u^3), p[0], a)
	pointTimes (3 * (u^2) * (1 - u), p[1], b)
	pointTimes (3 * u * ((1 - u)^2), p[2], c)
	pointTimes (((1 - u)^3), p[3], d)

	pointAdd (a, b, r1)
	pointAdd (c, d, r2)
	pointAdd (r1, r2, ret)

end sub

''---------------------------------------------------
'' Generates a display list based on the data in the patch
'' and the number of divisions
function genBezier (byref patch as BEZIER_PATCH, byval divs as integer) as uinteger
	dim as integer u = 0, v
	dim as single py, px, pyold
	dim drawlist as uinteger                         '' make the display list
	dim temp(0 to 3) as POINT_3D
	dim last as POINT_3D ptr

	drawlist = glGenLists(1)

	last = allocate(len(POINT_3D)*(divs + 1))        '' array of points to mark the first line of polys

	'' get rid of any old display lists
	if (patch.dlBPatch <> 0) then
		glDeleteLists (patch.dlBPatch, 1)
	end if

	temp(0)= patch.anchors(0,3)                      '' the first derived curve (along x axis)
	temp(1)= patch.anchors(1,3)
	temp(2)= patch.anchors(2,3)
	temp(3)= patch.anchors(3,3)

	v=0
	while v<=divs            '' create the first line of points
		px = v/divs          '' percent along y axis
		'' use the 4 points from the derives curve to calculate the points along that curve
		Bernstein (px, @temp(0), last[v])
		v = v + 1
	wend

	glNewList (drawlist, GL_COMPILE)                 '' Start a new display list
	glBindTexture (GL_TEXTURE_2D, patch.texture)     '' Bind the texture

	u=1
	while u<=divs
		py = u/divs                 '' Percent along Y axis
		pyold = (u - 1.0)/divs      '' Percent along old Y axis

		Bernstein (py, @patch.anchors(0,0), temp(0))           '' Calculate new bezier points
		Bernstein (py, @patch.anchors(1,0), temp(1))
		Bernstein (py, @patch.anchors(2,0), temp(2))
		Bernstein (py, @patch.anchors(3,0), temp(3))

		glBegin (GL_TRIANGLE_STRIP) '' Begin a new triangle strip
			v=0
			while v <= divs
				px = v/divs         '' Percent along the X axis
				glTexCoord2f (pyold, px)                       '' Apply the old texture coords
				glVertex3d (last[v].x, last[v].y, last[v].z)   '' Old Point
				Bernstein (px, @temp(0), last[v])              '' Generate new point
				glTexCoord2f (py, px)                          '' Apply the new texture coords
				glVertex3d (last[v].x, last[v].y, last[v].z)   '' New Point
				v = v + 1
			wend
		glEnd ()                    '' END the triangle srip
		u = u + 1
	wend
	glEndList ()                    '' END the list

	deallocate (last)               '' Free the old vertices array

	return drawlist                 '' Return the display list
end function

''---------------------------------------------------
sub initBezier ()
	dim r as POINT_3D
	'' set the bezier vertices
	makePoint (- 0.75, - 0.75, - 0.5, r)  : mybezier.anchors(0,0)= r
	makePoint (- 0.25, - 0.75, 0.0, r)    : mybezier.anchors(0,1)= r
	makePoint (0.25, - 0.75, 0.0, r)      : mybezier.anchors(0,2)= r
	makePoint (0.75, - 0.75, - 0.5, r)    : mybezier.anchors(0,3)= r
	makePoint (- 0.75, - 0.25, - 0.75, r) : mybezier.anchors(1,0)= r
	makePoint (- 0.25, - 0.25, 0.5, r)    : mybezier.anchors(1,1)= r
	makePoint (0.25, - 0.25, 0.5, r)      : mybezier.anchors(1,2)= r
	makePoint (0.75, - 0.25, - 0.75, r)   : mybezier.anchors(1,3)= r
	makePoint (- 0.75, 0.25, 0.0, r)      : mybezier.anchors(2,0)= r
	makePoint (- 0.25, 0.25, - 0.5, r)    : mybezier.anchors(2,1)= r
	makePoint (0.25, 0.25, - 0.5, r)      : mybezier.anchors(2,2)= r
	makePoint (0.75, 0.25, 0.0, r)        : mybezier.anchors(2,3)= r
	makePoint (- 0.75, 0.75, - 0.5, r)    : mybezier.anchors(3,0)= r
	makePoint (- 0.25, 0.75, - 1.0, r)    : mybezier.anchors(3,1)= r
	makePoint (0.25, 0.75, - 1.0, r)      : mybezier.anchors(3,2)= r
	makePoint (0.75, 0.75, - 0.5, r)      : mybezier.anchors(3,3)= r
	mybezier.dlBPatch = 0
end sub
