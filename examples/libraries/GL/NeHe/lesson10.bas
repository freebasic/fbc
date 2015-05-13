''
'' This Code Was Created By Jeff Molofee 2000
'' A HUGE Thanks To Fredric Echols For Cleaning Up
'' And Optimizing The Base Code, Making It More Flexible!
'' If You've Found This Code Useful, Please Let Me Know.
'' Visit My Site At nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Use ESC key to quit
'' F key to cycle filters (Nearest, Linear , MipMapped)
'' B key to toggle blending (on/off)
'' PgUp key and PgDn key to look up and look down
'' UpArrow, DnArrow, RightArrow, Left Arrow to move around
''
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson10.bas




#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "crt.bi"          '' scanf is used to parse data file
#include once "fbgfx.bi"        '' for Scan code constants
#include once "createtex.bi"

'' Setup our booleans
const false = 0
const true  = not false

const piover180 = 0.0174532925f
''------------------------------------------------------------------------------
'' Types used by the model
type VERTEX                      '' Build Our Vertex Structure called VERTEX
	x as single                  '' 3D Coordinates (x, y, z)
	y as single
	z as single
	u as single                  '' Texture Coordinates (u, v)
	v as single
end type

type TRIANGLE                    '' Build Our Triangle Structure called TRIANGLE
	vertex(0 to 2) as VERTEX     '' Array Of Three Vertices
end type

type SECTOR                      '' Build Our Sector Structure called SECTOR
	numtriangles as integer      '' Number Of Triangles In Sector
	triangle as TRIANGLE ptr     '' Pointer To Array Of Triangles
end type

''------------------------------------------------------------------------------
declare sub readstr(byval f as integer, byref Buffer as string)
declare sub SetupWorld()


dim shared sector1 as SECTOR                   '' Our Model Goes Here
	
dim shared filter as uinteger                  '' Which Filter To Use
dim shared texture(0 to 2) as uinteger         '' Storage For 3 Textures
	
	dim blend as integer                    '' Blending OFF/ON?
	dim fp as integer                       '' F Pressed?
	dim bp as integer                       '' B Pressed?

	dim heading as single              '' direction of movement
	dim xpos as single                 '' X position
	dim zpos as single                 '' Y position
	
	dim yrot as single                 '' Y Rotation = heading
	dim walkbias as single             '' used with walkbiasangle for bouncing effect
	dim walkbiasangle as single        '' used with walkbias for bouncing effect
	dim lookupdown as single           '' View direction
	
	dim x_m as single            '' Floating Point For Temp X, Y, Z, U And V Vertices
	dim y_m as single
	dim z_m as single
	dim u_m as single
	dim v_m as single
	
	dim xtrans as single         '' Used For Player Translation
	dim ztrans as single         '' Used For Player Translation
	dim ytrans as single         '' Used For Bouncing Motion Up And Down
	dim sceneroty as single      '' 360 Degree Angle For Player Direction

	dim as integer numtriangles  '' Integer To Hold The Number Of Triangles
	dim as integer loop_m        '' Loop counter

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix

	'' This Lesson is the first to demonstrate the use of BLOAD to load the bitmaps.
	redim buffer(256*256*4+4) as ubyte                    '' Size = Width x Height x 4 bytes per pixel + 4 bytes for header
	bload exepath + "/data/Mud.bmp", @buffer(0)                      '' BLOAD data from bitmap
	texture(0) = CreateTexture(@buffer(0),TEX_NOFILTER)   '' Nearest Texture
	texture(1) = CreateTexture(@buffer(0))                '' Linear Texture (default)
	texture(2) = CreateTexture(@buffer(0),TEX_MIPMAP)     '' MipMapped Texture
	'' Exit if error loading textures
	if texture(0) = 0 or texture(1) = 0 or texture(2) = 0 then end 1

	'' All Setup For OpenGL Goes Here
	glEnable GL_TEXTURE_2D                                '' Enable Texture Mapping
	glBlendFunc GL_SRC_ALPHA, GL_ONE                      '' Set The Blending Function For Translucency
	glClearColor 0.0, 0.0, 0.0, 0.5                       '' Black Background
	glClearDepth 1.0                                      '' Depth Buffer Setup
	glDepthFunc GL_LESS                                   '' The Type Of Depth Test To Do
	glEnable GL_DEPTH_TEST                                '' Enables Depth Testing
	glShadeModel GL_SMOOTH                                '' Enable Smooth Shading
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST      '' Really Nice Perspective Calculations

	SetupWorld()

	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT      '' Clear Screen And Depth Buffer
		glLoadIdentity()                                        '' Reset The View
		
		xtrans = - xpos
		ztrans = - zpos
		ytrans = - walkbias - 0.25                      '' Used For Bouncing Motion Up And Down
		sceneroty = 360.0 - yrot                        '' 360 Degree Angle For Player Direction
		
		glRotatef lookupdown, 1.0, 0,0                  '' Rotate Up And Down To Look Up And Down
		glRotatef sceneroty, 0, 1.0, 0                  '' Rotate Depending On Direction Player Is Facing
		
		glTranslatef xtrans, ytrans, ztrans             '' Translate The Scene Based On Player Position
		glBindTexture GL_TEXTURE_2D, texture(filter)    '' Select A Texture Based On filter
		
		numtriangles = sector1.numtriangles             '' Get The Number Of Triangles In Sector 1
		
		' Process Each Triangle
		for loop_m = 0 to numtriangles - 1
		
			glBegin GL_TRIANGLES                          '' Start Drawing Triangles
				glNormal3f 0.0, 0.0, 1.0                  '' Normal Pointing Forward
				x_m = sector1.triangle[loop_m].vertex(0).x         '' X Vertex Of 1st Point
				y_m = sector1.triangle[loop_m].vertex(0).y         '' Y Vertex Of 1st Point
				z_m = sector1.triangle[loop_m].vertex(0).z         '' Z Vertex Of 1st Point
				u_m = sector1.triangle[loop_m].vertex(0).u         '' U Texture Coord Of 1st Point
				v_m = sector1.triangle[loop_m].vertex(0).v         '' V Texture Coord Of 1st Point
				glTexCoord2f u_m, v_m : glVertex3f x_m, y_m, z_m   '' Set The TexCoord And Vertice
			
				x_m = sector1.triangle[loop_m].vertex(1).x         '' X Vertex Of 2nd Point
				y_m = sector1.triangle[loop_m].vertex(1).y         '' Y Vertex Of 2nd Point
				z_m = sector1.triangle[loop_m].vertex(1).z         '' Z Vertex Of 2nd Point
				u_m = sector1.triangle[loop_m].vertex(1).u         '' U Texture Coord Of 2nd Point
				v_m = sector1.triangle[loop_m].vertex(1).v         '' V Texture Coord Of 2nd Point
				glTexCoord2f u_m, v_m : glVertex3f x_m, y_m, z_m   '' Set The TexCoord And Vertice
			
				x_m = sector1.triangle[loop_m].vertex(2).x         '' X Vertex Of 3rd Point
				y_m = sector1.triangle[loop_m].vertex(2).y         '' Y Vertex Of 3rd Point
				z_m = sector1.triangle[loop_m].vertex(2).z         '' Z Vertex Of 3rd Point
				u_m = sector1.triangle[loop_m].vertex(2).u         '' U Texture Coord Of 3rd Point
				v_m = sector1.triangle[loop_m].vertex(2).v         '' V Texture Coord Of 3rd Point
				glTexCoord2f u_m, v_m : glVertex3f x_m, y_m, z_m   '' Set The TexCoord And Vertice
			glEnd
		next

		'' Keyboard handlers
		if MULTIKEY(FB.SC_F) and not fp then           '' F Key down
			fp = true
			filter += 1                             '' Cycle filter 0 -> 1 -> 2
			if (filter > 2) then filter = 0         '' 2 -> 0
		end if
		if not MULTIKEY(FB.SC_F) then fp = false       '' F Key Up
	
		if MULTIKEY(FB.SC_B) and not bp then           '' B Key down
			bp = true
			blend = not blend                       '' toggle blending On/Off
			if blend then
				glEnable(GL_BLEND)                  '' Turn Blending On
				glDisable(GL_DEPTH_TEST)            '' Turn Depth Testing Off
			else
				glDisable(GL_BLEND)                 '' Turn Blending Off
				glEnable(GL_DEPTH_TEST)             '' Turn Depth Testing On
			end if
		end if
		if not MULTIKEY(FB.SC_B) then bp = false       '' B Key up
	
		if MULTIKEY(FB.SC_UP) then
			xpos = xpos - sin(heading*piover180) * 0.05    '' Move On The X-Plane Based On Player Direction
			zpos = zpos - cos(heading*piover180) * 0.05    '' Move On The Z-Plane Based On Player Direction
			if walkbiasangle >= 359.0 then                 '' Is walkbiasangle>=359?
				walkbiasangle = 0.0                        '' Make walkbiasangle Equal 0
			else
				walkbiasangle = walkbiasangle + 10         '' If walkbiasangle < 359 Increase It By 10
			end if
			walkbias = sin(walkbiasangle * piover180)/20.0 '' Causes The Player To Bounce
		end if
	
		if MULTIKEY(FB.SC_DOWN) then
			xpos = xpos + sin(heading*piover180) * 0.05    '' Move On The X-Plane Based On Player Direction
			zpos = zpos + cos(heading*piover180) * 0.05    '' Move On The Z-Plane Based On Player Direction
			if walkbiasangle <= 1.0 then                   '' Is walkbiasangle<=1?
				walkbiasangle = 359.0                      '' Make walkbiasangle Equal 359
			else
				walkbiasangle = walkbiasangle - 10         '' If walkbiasangle > 1 Decrease It By 10
			end if
			walkbias = sin(walkbiasangle * piover180)/20.0 '' Causes The Player To Bounce
		end if
	
		if MULTIKEY(FB.SC_RIGHT) then
			heading = heading - 1.0        '' Rotate The Scene To The Left
			yrot = heading
		end if
	
		if MULTIKEY(FB.SC_LEFT) then
			heading = heading + 1.0        '' Rotate The Scene To The Right
			yrot = heading
		end if

		if MULTIKEY(FB.SC_PAGEUP) then
			lookupdown = lookupdown - 1.0  '' look up
		end if

		if MULTIKEY(FB.SC_PAGEDOWN) then
			lookupdown = lookupdown + 1.0  '' look down
		end if

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while inkey <> "": wend

	end

''------------------------------------------------------------------------------
sub readstr(byval f as integer, byref Buffer as string)
	do
		line input #f, Buffer        '' Get one line
	loop while (left(Buffer,1) = "/") or (Buffer = "")   '' See If It Is Worthy Of Processing
end sub

'-------------------------------------------------------------------------------
sub SetupWorld()
	dim as single x, y, z, u, v         '' 3D And Texture Coordinates
	dim as integer numtriangles         '' Number Of Triangles In Sector
	dim oneline as string               '' String To Store Data In
	dim as integer gl_loop, vert
	dim fp as integer

	fp = freefile
	'' File To Load World Data From, quit if file not found
	if (open (exepath + "\data\World.txt", for input, as #fp) <> 0) then end 1
	readstr(fp, oneline)                                      '' Get Single Line Of Data
	if oneline = "" then end 1                                '' Data file error, exit
	sscanf(strptr(oneline), !"NUMPOLLIES %d\n", @numtriangles) '' Read In Number Of Triangles
	sector1.triangle = allocate(len(TRIANGLE)*numtriangles)   '' Allocate Memory For numtriangles And Set Pointer
	sector1.numtriangles = numtriangles                       '' Define The Number Of Triangles In Sector 1
	for gl_loop = 0 to numtriangles-1                         '' Loop Through All The Triangles
		for vert = 0 to 2                                     '' Loop Through All The Vertices
			readstr(fp, oneline)                              '' Read String To Work With
			if oneline = "" then end 1                        '' Data file error, exit
			'' Read Data Into Respective Vertex Values
			sscanf(strptr(oneline), "%f %f %f %f %f", @x, @y, @z, @u, @v)
			'' Store Values Into Respective Vertices
			sector1.triangle[gl_loop].vertex(vert).x = x    '' Sector 1, Triangle triloop, Vertice vertloop, x Value=x
			sector1.triangle[gl_loop].vertex(vert).y = y    '' Sector 1, Triangle triloop, Vertice vertloop, y Value=y
			sector1.triangle[gl_loop].vertex(vert).z = z    '' Sector 1, Triangle triloop, Vertice vertloop, z Value=z
			sector1.triangle[gl_loop].vertex(vert).u = u    '' Sector 1, Triangle triloop, Vertice vertloop, u Value=u
			sector1.triangle[gl_loop].vertex(vert).v = v    '' Sector 1, Triangle triloop, Vertice vertloop, v Value=v
		next
	next
	close #fp
end sub

