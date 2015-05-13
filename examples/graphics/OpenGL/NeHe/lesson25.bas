''
''  This Code Was Created By Pet & Commented/Cleaned Up By Jeff Molofee
''  If You've Found This Code Useful, Please Let Me Know.
''  Visit NeHe Productions At http://nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' PgUp increases speed on Z axis
'' PgDn decreases speed on Z axis
'' Down Arrow increases speed on X axis
'' Up Arrow decreases speed on X axis
'' Right Arrow increases speed of y axis
'' Left Arrow decreases speed on Y axis
'' Q Move Object Away From Viewer
'' Z Move Object Towards Viewer
'' W Move Object Up
'' S Move Object Down
'' D Move Object Right
'' A Move Object Left
'' 1, 2, 3 & 4 to select the different models
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson25.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                   '' for Scan code constants
#include once "crt.bi"

''------------------------------------------------------------------------------
type VERTEX                                '' Structure Called VERTEXFor 3D Points
	x as single
	y as single
	z as single                            '' X, Y & Z Points
end type

type OBJECT_                               '' Structure Called OBJECT For An Object
	verts as integer                       '' Number Of Vertices For The Object
	points as VERTEX ptr                   '' One Vertice (Vertex x,y & z)
end type

''------------------------------------------------------------------------------
declare sub objallocate (byval k as OBJECT_ ptr, byval n as integer)
declare sub objfree (byval k as OBJECT_ ptr)
declare sub readstr(byval f as integer, byref sstring as string)
declare sub objload (byref fname as string, byval k as OBJECT_ ptr)
declare sub calculate (byval i as integer, byval v as VERTEX ptr)

dim shared maxver as integer                     '' Will Eventually Hold The Maximum Number Of Vertices
dim shared as integer steps = 200                '' Maximum Number Of Steps
dim shared as OBJECT_ ptr sour, dest              '' Source Object, Destination Object

	dim as single xrot, yrot, zrot               '' X, Y & Z Rotation
	dim as single xspeed, yspeed, zspeed         '' X, Y & Z Spin Speed
	dim as single cx, cy, cz = - 15              '' X, Y & Z Position

	dim as integer key = 1                       '' Used To Make Sure Same Morph Key Is Not Pressed
	dim as integer iSTEP = 0 '' Step Counter
	dim as integer morph = FALSE                 '' Default morph To False (Not Morphing)

	
	dim as OBJECT_ morph1, morph2, morph3, morph4 '' Our 4 Morphable Objects (morph1,2,3 & 4)
	dim as OBJECT_ helper                         '' Helper Object
	dim as single tx, ty, tz                      '' Temp X, Y & Z Variables
	dim q as VERTEX                               '' Holds Returned Calculated Values For One Vertex

	windowtitle "Piotr Cieslak & NeHe's Morphing Points Tutorial"   '' Set window title
	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640/480, 0.1, 100.0       '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity

	'' All Setup For OpenGL Goes Here
	glBlendFunc (GL_SRC_ALPHA , GL_ONE)                     '' Set The Blending Function For Translucency
	glClearColor (0.0f , 0.0f , 0.0f , 0.0f)                '' This Will Clear The Background Color To Black
	glClearDepth (1.0)                                      '' Enables Clearing Of The Depth Buffer
	glDepthFunc (GL_LESS)                                   '' The Type Of Depth Test To Do
	glEnable (GL_DEPTH_TEST)                                '' Enables Depth Testing
	glShadeModel (GL_SMOOTH)                                '' Enables Smooth Color Shading
	glHint (GL_PERSPECTIVE_CORRECTION_HINT , GL_NICEST)     '' Really Nice Perspective Calculations

	maxver = 0                                              '' Sets Max Vertices To 0 By Default
	objload (exepath + "/data/Sphere.txt" , @morph1)                   '' Load The First Object Into morph1 From File sphere.txt
	objload (exepath + "/data/Torus.txt" , @morph2)                    '' Load The Second Object Into morph2 From File torus.txt
	objload (exepath + "/data/Tube.txt" , @morph3)                     '' Load The Third Object Into morph3 From File tube.txt

	objallocate (@morph4 , 486)                             '' Manually Reserver Ram For A 4th 468 Vertice Object (morph4)

	'' Loop Through All 468 Vertices
	dim as integer i=0
	while i < 486
		morph4.points[i].x = (int(rnd*14000)/1000) - 7    '' morph4 x Point Becomes A Random Float Value From -7 to 7
		morph4.points[i].y = (int(rnd*14000)/1000) - 7    '' morph4 y Point Becomes A Random Float Value From -7 to 7
		morph4.points[i].z = (int(rnd*14000)/1000) - 7    '' morph4 z Point Becomes A Random Float Value From -7 to 7
		i = i + 1
	wend

	objload (exepath + "/data/Sphere.txt" , @helper)   '' Load sphere.txt Object Into Helper (Used As Starting Point)
	dest = @morph1          '' Source & Destination Are Set To Equal First Object (morph1)
	sour = @morph1

	do
		glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)    '' Clear The Screen And The Depth Buffer
		glLoadIdentity()                                       '' Reset The View
		glTranslatef(cx, cy, cz)                            '' Translate The The Current Position To Start Drawing
		glRotatef(xrot, 1, 0, 0)                            '' Rotate On The X Axis By xrot
		glRotatef(yrot, 0, 1, 0)                            '' Rotate On The Y Axis By yrot
		glRotatef(zrot, 0, 0, 1)                            '' Rotate On The Z Axis By zrot

		xrot += xspeed : yrot += yspeed : zrot += zspeed    '' Increase xrot,yrot & zrot by xspeed, yspeed & zspeed

		glBegin (GL_POINTS)                                 '' Begin Drawing Points
			'' Loop Through All The Verts Of morph1 (All Objects Have The Same Amount Of Verts For Simplicity, Could Use maxver Also)
			i=0
			while i< morph1.verts
				if (morph) then                             '' If morph Is True Calculate Movement Otherwise Movement=0
					calculate (i, @q)
				else
					q.x = 0 : q.y = 0 : q.z = 0
				end if
				helper.points[i].x -= q.x                   '' Subtract q.x Units From helper.points[i].x (Move On X Axis)
				helper.points[i].y -= q.y                   '' Subtract q.y Units From helper.points[i].y (Move On Y Axis)
				helper.points[i].z -= q.z                   '' Subtract q.z Units From helper.points[i].z (Move On Z Axis)
				tx = helper.points[i].x                     '' Make Temp X Variable Equal To Helper's X Variable
				ty = helper.points[i].y                     '' Make Temp Y Variable Equal To Helper's Y Variable
				tz = helper.points[i].z                     '' Make Temp Z Variable Equal To Helper's Z Variable

				glColor3f (0, 1, 1)                         '' Set Color To A Bright Shade Of Off Blue
				glVertex3f (tx, ty, tz)                     '' Draw A Point At The Current Temp Values (Vertex)
				glColor3f (0, 0.5, 1)                       '' Darken Color A Bit
				tx -= 2 * q.x : ty -= 2 * q.y : ty -= 2 * q.y  '' Calculate Two Positions Ahead
				glVertex3f (tx, ty, tz)                        '' Draw A Second Point At The Newly Calculate Position
				glColor3f (0, 0, 1)                            '' Set Color To A Very Dark Blue
				tx -= 2 * q.x : ty -= 2 * q.y : ty -= 2 * q.y  '' Calculate Two More Positions Ahead
				glVertex3f (tx, ty, tz)                        '' Draw A Third Point At The Second New Position
				i= i + 1
			wend
			'' This Creates A Ghostly Tail As Points Move
		glEnd ()                                               '' Done Drawing Points

		'' If We're Morphing And We Haven't Gone Through All 200 Steps Increase Our Step Counter
		'' Otherwise Set Morphing To False, Make Source=Destination And Set The Step Counter Back To Zero.
		if (morph and iSTEP<=steps) then
			iSTEP = iSTEP + 1
		else
			morph = FALSE
			sour = dest
			iSTEP = 0
		end if

		'' Keyboard handlers
		'' Is Page Up Being Pressed?
		if MULTIKEY(FB.SC_PAGEUP) then                '' Increase zspeed
			zspeed += 0.01f
		end if
		'' Is Page Down Being Pressed?
		if MULTIKEY(FB.SC_PAGEDOWN) then              '' Decrease zspeed
			zspeed -= 0.01f
		end if
		'' Is Down Key Being Pressed?
		if MULTIKEY(FB.SC_DOWN) then                  '' Increase xspeed
			xspeed += 0.01f
		end if
		'' Is Up Key Being Pressed?
		if MULTIKEY(FB.SC_UP) then                    '' Decrease xspeed
			xspeed -= 0.01f
		end if
		'' Is Right Key Being Pressed?
		if MULTIKEY(FB.SC_RIGHT) then                 '' Increase yspeed
			yspeed += 0.01f
		end if
		'' Is Left Key Being Pressed?
		if MULTIKEY(FB.SC_LEFT) then                  '' Decrease yspeed
			yspeed -= 0.01f
		end if
		'' Is Q Key Being Pressed?
		if MULTIKEY(FB.SC_Q) then                     '' Q Move Object Away From Viewer
			cz -= 0.01f
		end if
		'' Is Z Key Being Pressed?
		if MULTIKEY(FB.SC_Z) then                     '' Z Move Object Towards Viewer
			cz += 0.01f
		end if
		'' Is W Key Being Pressed?
		if MULTIKEY(FB.SC_W) then                     '' W Move Object Up
			cy += 0.01f
		end if
		'' Is S Key Being Pressed?
		if MULTIKEY(FB.SC_S) then                     '' S Move Object Down
			cy -= 0.01f
		end if
		'' Is D Key Being Pressed?
		if MULTIKEY(FB.SC_D) then                     '' D Move Object Right
			cx += 0.01f
		end if
		'' Is A Key Being Pressed?
		if MULTIKEY(FB.SC_A) then                     '' A Move Object Left
			cx -= 0.01f
		end if
		'' Is 1 Pressed, key Not Equal To 1 And Morph False?
		if MULTIKEY(FB.SC_1) and key <> 1 and not morph then
			key = 1                                     '' Sets key To 1 (To Prevent Pressing 1 2x In A Row)
			morph = TRUE                                '' Set morph To True (Starts Morphing Process)
			dest = @morph1                              '' Destination Object To Morph To Becomes morph1
		end if
		'' Is 2 Pressed, key Not Equal To 2 And Morph False?
		if MULTIKEY(FB.SC_2) and key <> 2 and not morph then
			key = 2                                     '' Sets key To 2 (To Prevent Pressing 2 2x In A Row)
			morph = TRUE                                '' Set morph To True (Starts Morphing Process)
			dest = @morph2                              '' Destination Object To Morph To Becomes morph2
		end if
		'' Is 3 Pressed, key Not Equal To 3 And Morph False?
		if MULTIKEY(FB.SC_3) and key <> 3 and not  morph then
			key = 3                                     '' Sets key To 3 (To Prevent Pressing 3 2x In A Row)
			morph = TRUE                                '' Set morph To True (Starts Morphing Process)
			dest = @morph3                              '' Destination Object To Morph To Becomes morph3
		end if
		'' Is 4 Pressed, key Not Equal To 4 And Morph False?
		if MULTIKEY(FB.SC_4) and key <> 4 and not morph then
			key = 4                                     '' Sets key To 4 (To Prevent Pressing 4 2x In A Row)
			morph = TRUE                                '' Set morph To True (Starts Morphing Process)
			dest = @morph4                              '' Destination Object To Morph To Becomes morph4
		end if

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do    '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend

	objfree (@morph1)              '' Jump To Code To Release morph1 Allocated Ram
	objfree (@morph2)              '' Jump To Code To Release morph2 Allocated Ram
	objfree (@morph3)              '' Jump To Code To Release morph3 Allocated Ram
	objfree (@morph4)              '' Jump To Code To Release morph4 Allocated Ram
	objfree (@helper)              '' Jump To Code To Release helper Allocated Ram

	end


'---------------------------------------------------
sub objallocate (byval k as OBJECT_ ptr, byval n as integer)  '' Allocate Memory For Each Object and Defines points
	k->points = allocate(len(VERTEX)* n)          '' Sets points Equal To VERTEX * Number Of Vertices
end sub                                           '' (3 Points For Each Vertice)

'---------------------------------------------------
sub objfree (byval k as OBJECT_ ptr)              '' Frees The Object (Releasing The Memory)
	deallocate(k->points)                         '' Frees Points
end sub

'---------------------------------------------------
'' Reads A String From File (f)
sub readstr(byval f as integer, byref sstring as string)                 
	if eof(f) then
		sstring = ""
	else
		line input #f, sstring                     '' Gets A String Of 255 Chars Max From f (File)
	end if
end sub

'---------------------------------------------------
'' Loads Object From File (name)
sub objload (byref fname as string, byval k as OBJECT_ ptr)          
	dim ver as integer                                  '' Will Hold Vertice Count
	dim as single rx, ry, rz                            '' Hold Vertex X, Y & Z Position
	dim oneline as string * 256                         '' Holds One Line Of Text
	dim filein as integer

	filein = freefile
	open fname for input as #filein
	readstr(filein, oneline)                            '' Jumps To Code That Reads One Line Of Text From The File
	sscanf (strptr(oneline), !"Vertices: %d\n", @ver)   '' Scans Text For "Vertices: ".  Number After Is Stored In ver
	k->verts = ver                                      '' Sets Objects verts Variable To Equal The Value Of ver
	objallocate (k, ver)                                '' Jumps To Code That Allocates Ram To Hold The Object

	'' Loops Through The Vertices
	dim as integer i=0
	while i < ver
		readstr (filein, oneline)                       '' Reads In The Next Line Of Text
		sscanf (strptr(oneline), "%f %f %f", @rx, @ry, @rz)      '' Searches For 3 Floating Point Numbers, Store In rx,ry & rz
		k->points[i].x = rx                             '' Sets Objects (k) points.x Value To rx
		k->points[i].y = ry                             '' Sets Objects (k) points.y Value To ry
		k->points[i].z = rz                             '' Sets Objects (k) points.z Value To rz)
		i = i + 1
	wend
	close #filein                                       '' Close The File

	if (ver > maxver) then                              '' If ver Is Greater Than maxver Set maxver Equal To ver
		maxver = ver                                    '' Keeps Track Of Highest Number Of Vertices Used In Any Of The
	end if                                              '' Objects

end sub

'---------------------------------------------------
'' Calculates Movement Of Points During Morphing
sub calculate (byval i as integer, byval v as VERTEX ptr)                
	v->x = (sour->points[i].x - dest->points[i].x) / steps    '' a.x Value Equals Source x - Destination x Divided By Steps
	v->y = (sour->points[i].y - dest->points[i].y) / steps    '' a.y Value Equals Source y - Destination y Divided By Steps
	v->z = (sour->points[i].z - dest->points[i].z) / steps    '' a.z Value Equals Source z - Destination z Divided By Steps
	'' This Makes Points Move At A Speed So They All Get To Their
	'' Destination At The Same Time
end sub
