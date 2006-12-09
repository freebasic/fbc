''------------------------------------------------------------------------------
''
''   Jeff Molofee''s Basecode Example
''          nehe.gamedev.net
''                2001
''
''    All Code / Tutorial Commenting
''       by Jeff Molofee ( NeHe )
''
''------------------------------------------------------------------------------



'' Setup our booleans
const false = 0
const true  = not false
const null = 0


#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                       '' for Scan code constants

declare sub Initialize ()
declare sub drawscr ()
declare sub DrawBlur (byval times as integer, byval inc as single)
declare sub RenderToTexture ()
declare sub ViewPerspective ()
declare sub ViewOrtho ()
declare sub ProcessHelix ()
declare sub calcNormal (v() as single, oout() as single)
declare sub ReduceToUnit (vector() as single)
declare function EmptyTexture () as unsigned integer

'' User Defined Variables
dim shared angle as single                            '' Used To Rotate The Helix
dim shared vertexes(0 to 3, 0 to 2) as single         '' Holds single Info For 4 Sets Of Vertices
dim shared normal(0 to 2) as single                   '' An Array To Store The Normal Data
dim shared BlurTexture as unsigned integer            '' An Unsigned Int To Store The Texture Number

	dim as double lastTickCount, tickCount

	windowtitle "rIO And NeHe's RadialBlur Tutorial." '' Set window title
	screen 18, 32, , 2
	Initialize ()
	lastTickCount  = timer * 1000
	do
		tickCount = timer * 1000			          '' Convert timer to ms
		angle + = (tickCount - lastTickCount) / 5.0f  '' Update angle Based On The Clock
		lastTickCount = tickCount			          '' Set Last Count To Current Count
		drawscr()
		flip
		if inkey = chr(255)+"k" then exit do        '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	glDeleteTextures (1, @BlurTexture)                '' Delete The Blur Texture

	'' Empty keyboard buffer
	while inkey <> "": wend

	end

'' ------------------------------------------------------------------------
function EmptyTexture () as unsigned integer              '' Create An Empty Texture
	dim txtnumber as unsigned integer                     '' Texture ID
	dim ddata as unsigned integer ptr                     '' Stored Data

	''  Create Storage Space For Texture Data (128x128x4)
	ddata = callocate ((128 *128)*4* sizeof (integer))    '' callocate clear Storage Memory

	glGenTextures (1, @txtnumber)                         '' Create 1 Texture
	glBindTexture (GL_TEXTURE_2D, txtnumber)              '' Bind The Texture
	glTexImage2D (GL_TEXTURE_2D, 0, 4, 128, 128, 0, GL_RGBA, GL_UNSIGNED_BYTE, ddata)  '' Build Texture Using Information In data
	glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
	glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)

	''  Release data
	deallocate (ddata)
	ddata = NULL

	return txtnumber                                      '' Return The Texture ID
end function

'' ------------------------------------------------------------------------
sub ReduceToUnit (vector() as single)                     '' Reduces A Normal Vector (3 Coordinates)
	'' To A Unit Normal Vector With A Length Of One.
	dim length as single                                  '' Holds Unit Length
	''  Calculates The Length Of The Vector
	length = sqr ((vector(0)* vector(0)) + (vector(1)* vector(1)) + (vector(2)* vector(2)))

	''  Prevents Divide By 0 Error By Providing
	if length = 0.0f then                                 '' An Acceptable Value For Vectors To Close To 0.
		length = 1.0f
	end if
	vector(0) / = length                                  '' Dividing Each Element By
	vector(1) / = length                                  '' The Length Results In A
	vector(2) / = length                                  '' Unit Normal Vector.
end sub

'' ------------------------------------------------------------------------
sub calcNormal (v() as single, oout() as single)          '' Calculates Normal For A Quad Using 3 Points
	dim v1(0 to 2) as single, v2(0 to 2) as single        '' Vector 1 (x,y,z) & Vector 2 (x,y,z)
	static as integer x = 0                               '' Define X Coord
	static as integer y = 1                               '' Define Y Coord
	static as integer z = 2                               '' Define Z Coord

	''  Finds The Vector Between 2 Points By Subtracting
	''  The x,y,z Coordinates From One Point To Another.

	''  Calculate The Vector From Point 1 To Point 0
	v1(x) = v(0,x) - v(1,x)                               '' Vector 1.x=Vertex(0).x-Vertex(1).x
	v1(y) = v(0,y) - v(1,y)                               '' Vector 1.y=Vertex(0).y-Vertex(1).y
	v1(z) = v(0,z) - v(1,z)                               '' Vector 1.z=Vertex(0).y-Vertex(1).z
	''  Calculate The Vector From Point 2 To Point 1
	v2(x) = v(1,x) - v(2,x)                               '' Vector 2.x=Vertex(0).x-Vertex(1).x
	v2(y) = v(1,y) - v(2,y)                               '' Vector 2.y=Vertex(0).y-Vertex(1).y
	v2(z) = v(1,z) - v(2,z)                               '' Vector 2.z=Vertex(0).z-Vertex(1).z
	''  Compute The Cross Product To Give Us A Surface Normal
	oout(x) = v1(y)*v2(z) - v1(z)*v2(y)                   '' Cross Product For Y - Z
	oout(y) = v1(z)*v2(x) - v1(x)*v2(z)                   '' Cross Product For X - Z
	oout(z) = v1(x)*v2(y) - v1(y)*v2(x)                   '' Cross Product For X - Y

	ReduceToUnit (oout())                                 '' Normalize The Vectors
end sub

'' ------------------------------------------------------------------------
sub ProcessHelix ()                                    '' Draws A Helix
	dim x as single                                    '' Helix x Coordinate
	dim y as single                                    '' Helix y Coordinate
	dim z as single                                    '' Helix z Coordinate
	dim phi as single                                  '' Angle
	dim theta as single                                '' Angle
	dim v as single, u as single                       '' Angles
	dim r as single                                    '' Radius Of Twist
	dim  as integer twists = 5                         '' 5 Twists

	dim glfMaterialColor(0 to 3) as single => { _      '' Set The Material Color
		0.4f, 0.2f, 0.8f, 1.0f _
		}
	dim specular(0 to 3) as single => { _              '' Sets Up Specular Lighting
		1.0f, 1.0f, 1.0f, 1.0f _
		}

	glLoadIdentity ()                                  '' Reset The Modelview Matrix
	gluLookAt (0, 5, 50, 0, 0, 0, 0, 1, 0)             '' Eye Position (0,5,50) Center Of Scene (0,0,0), Up On Y Axis

	glPushMatrix ()                                    '' Push The Modelview Matrix

		glTranslatef (0, 0, - 50)                      '' Translate 50 Units Into The Screen
		glRotatef (angle / 2.0f, 1, 0, 0)              '' Rotate By angle/2 On The X-Axis
		glRotatef (angle / 3.0f, 0, 1, 0)              '' Rotate By angle/3 On The Y-Axis

		glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, @glfMaterialColor(0))
		glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, @specular(0))

		r = 1.5f                                       '' Radius

		glBegin (GL_QUADS)                             '' Begin Drawing Quads
			''  360 Degrees In Steps Of 20
			phi = 0
			while phi<=360
				''  360 Degrees * Number Of Twists In Steps Of 20
				theta = 0
				while theta<=360*twists
					v = (phi / 180.0f*3.142f)                  '' Calculate Angle Of First Point   (  0 )
					u = (theta / 180.0f*3.142f)                '' Calculate Angle Of First Point   (  0 )

					x = cos (u)*(2.0f + cos (v))*r             '' Calculate x Position (1st Point)
					y = sin (u)*(2.0f + cos (v))*r             '' Calculate y Position (1st Point)
					z = ((u - (2.0f*3.142f)) + sin (v))*r      '' Calculate z Position (1st Point)

					vertexes(0, 0) = x                         '' Set x Value Of First Vertex
					vertexes(0, 1) = y                         '' Set y Value Of First Vertex
					vertexes(0, 2) = z                         '' Set z Value Of First Vertex

					v = (phi / 180.0f*3.142f)                  '' Calculate Angle Of Second Point   (  0 )
					u = ((theta + 20) / 180.0f*3.142f)         '' Calculate Angle Of Second Point   ( 20 )

					x = cos (u)*(2.0f + cos (v))*r             '' Calculate x Position (2nd Point)
					y = sin (u)*(2.0f + cos (v))*r             '' Calculate y Position (2nd Point)
					z = ((u - (2.0f*3.142f)) + sin (v))*r      '' Calculate z Position (2nd Point)

					vertexes(1,0) = x                          '' Set x Value Of Second Vertex
					vertexes(1,1) = y                          '' Set y Value Of Second Vertex
					vertexes(1,2) = z                          '' Set z Value Of Second Vertex

					v = ((phi + 20) / 180.0f*3.142f)           '' Calculate Angle Of Third Point   ( 20 )
					u = ((theta + 20) / 180.0f*3.142f)         '' Calculate Angle Of Third Point   ( 20 )

					x = cos (u)*(2.0f + cos (v))*r             '' Calculate x Position (3rd Point)
					y = sin (u)*(2.0f + cos (v))*r             '' Calculate y Position (3rd Point)
					z = ((u - (2.0f*3.142f)) + sin (v))*r      '' Calculate z Position (3rd Point)

					vertexes(2,0) = x                          '' Set x Value Of Third Vertex
					vertexes(2,1) = y                          '' Set y Value Of Third Vertex
					vertexes(2,2) = z                          '' Set z Value Of Third Vertex

					v = ((phi + 20) / 180.0f*3.142f)           '' Calculate Angle Of Fourth Point   ( 20 )
					u = ((theta) / 180.0f*3.142f)              '' Calculate Angle Of Fourth Point   (  0 )

					x = cos (u)*(2.0f + cos (v))*r             '' Calculate x Position (4th Point)
					y = sin (u)*(2.0f + cos (v))*r             '' Calculate y Position (4th Point)
					z = ((u - (2.0f*3.142f)) + sin (v))*r      '' Calculate z Position (4th Point)

					vertexes(3,0) = x                          '' Set x Value Of Fourth Vertex
					vertexes(3,1) = y                          '' Set y Value Of Fourth Vertex
					vertexes(3,2) = z                          '' Set z Value Of Fourth Vertex

					calcNormal (vertexes(), normal())               '' Calculate The Quad Normal

					glNormal3f (normal(0), normal(1), normal(2))    '' Set The Normal

					''  Render The Quad
					glVertex3f (vertexes(0,0), vertexes(0,1), vertexes(0,2))
					glVertex3f (vertexes(1,0), vertexes(1,1), vertexes(1,2))
					glVertex3f (vertexes(2,0), vertexes(2,1), vertexes(2,2))
					glVertex3f (vertexes(3,0), vertexes(3,1), vertexes(3,2))
					theta+=20.0
				wend
				phi+=20.0
			wend
		glEnd ()                              '' Done Rendering Quads

	glPopMatrix ()                            '' Pop The Matrix
end sub

'' ------------------------------------------------------------------------
sub ViewOrtho ()                              '' Set Up An Ortho View
	glMatrixMode (GL_PROJECTION)              '' Select Projection
	glPushMatrix ()                           '' Push The Matrix
	glLoadIdentity ()                         '' Reset The Matrix
	glOrtho (0, 640, 480, 0, - 1, 1)          '' Select Ortho Mode (640x480)
	glMatrixMode (GL_MODELVIEW)               '' Select Modelview Matrix
	glPushMatrix ()                           '' Push The Matrix
	glLoadIdentity ()                         '' Reset The Matrix
end sub

'' ------------------------------------------------------------------------
sub ViewPerspective ()                        '' Set Up A Perspective View
	glMatrixMode (GL_PROJECTION)              '' Select Projection
    glPopMatrix ()                            '' Pop The Matrix
	glMatrixMode (GL_MODELVIEW)               '' Select Modelview
    glPopMatrix ()                            '' Pop The Matrix
end sub

'' ------------------------------------------------------------------------
sub RenderToTexture ()                                      '' Renders To A Texture
	glViewport (0, 0, 128, 128)                             '' Set Our Viewport (Match Texture Size)

	ProcessHelix ()                                         '' Render The Helix

	glBindTexture (GL_TEXTURE_2D, BlurTexture)              '' Bind To The Blur Texture

	''  Copy Our ViewPort To The Blur Texture (From 0,0 To 128,128... No Border)
	glCopyTexImage2D (GL_TEXTURE_2D, 0, GL_LUMINANCE, 0, 0, 128, 128, 0)

	glClearColor (0.0f, 0.0f, 0.5f, 0.5)                    '' Set The Clear Color To Medium Blue
	glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)    '' Clear The Screen And Depth Buffer

	glViewport (0, 0, 640, 480)                             '' Set Viewport (0,0 to 640x480)
end sub

'' ------------------------------------------------------------------------
'' Draw The Blurred Image
sub DrawBlur (byval times as integer, byval inc as single)  
	dim as single spost = 0.0f                              '' Starting Texture Coordinate Offset
	dim as single alphainc = 0.9f / times                   '' Fade Speed For Alpha Blending
	dim as single alpha = 0.2f                              '' Starting Alpha Value

	''  Disable AutoTexture Coordinates
	glDisable (GL_TEXTURE_GEN_S)
	glDisable (GL_TEXTURE_GEN_T)

	glEnable (GL_TEXTURE_2D)                                '' Enable 2D Texture Mapping
	glDisable (GL_DEPTH_TEST)                               '' Disable Depth Testing
	glBlendFunc (GL_SRC_ALPHA, GL_ONE)                      '' Set Blending Mode
	glEnable (GL_BLEND)                                     '' Enable Blending
	glBindTexture (GL_TEXTURE_2D, BlurTexture)              '' Bind To The Blur Texture
	ViewOrtho ()                                            '' Switch To An Ortho View

	alphainc = alpha / times                                '' alphainc=0.2f / Times To Render Blur

	glBegin (GL_QUADS)                                      '' Begin Drawing Quads
		''  Number Of Times To Render Blur
		dim as integer num = 0
		while num<times
			glColor4f (1.0f, 1.0f, 1.0f, alpha)             '' Set The Alpha Value (Starts At 0.2)
			glTexCoord2f (0 + spost, 1 - spost)             '' Texture Coordinate   ( 0, 1 )
			glVertex2f (0, 0)                               '' First Vertex      (   0,   0 )

			glTexCoord2f (0 + spost, 0 + spost)             '' Texture Coordinate   ( 0, 0 )
			glVertex2f (0, 480)                             '' Second Vertex   (   0, 480 )

			glTexCoord2f (1 - spost, 0 + spost)             '' Texture Coordinate   ( 1, 0 )
			glVertex2f (640, 480)                           '' Third Vertex      ( 640, 480 )

			glTexCoord2f (1 - spost, 1 - spost)             '' Texture Coordinate   ( 1, 1 )
			glVertex2f (640, 0)                             '' Fourth Vertex   ( 640,   0 )

			spost + = inc                                   '' Gradually Increase spost (Zooming Closer To Texture Center)
			alpha = alpha - alphainc                        '' Gradually Decrease alpha (Gradually Fading Image Out)
			num+=1
		wend
	glEnd ()                                                '' Done Drawing Quads

	ViewPerspective ()                                      '' Switch To A Perspective View

	glEnable (GL_DEPTH_TEST)                                '' Enable Depth Testing
	glDisable (GL_TEXTURE_2D)                               '' Disable 2D Texture Mapping
	glDisable (GL_BLEND)                                    '' Disable Blending
	glBindTexture (GL_TEXTURE_2D, 0)                        '' Unbind The Blur Texture
end sub

'' ------------------------------------------------------------------------
'' Any GL Init Code & User Initialiazation Goes Here
sub Initialize ()        
	dim as integer w, h
	screeninfo w, h

	'' Start Of User Initialization
	angle = 0.0f                                            '' Set Starting Angle To Zero

	BlurTexture = EmptyTexture ()                           '' Create Our Empty Texture

	glViewport (0, 0, w, h)                                 '' Set Up A Viewport
	glMatrixMode (GL_PROJECTION)                            '' Select The Projection Matrix
	glLoadIdentity ()                                       '' Reset The Projection Matrix
	gluPerspective (50, w/h, 5, 2000)                       '' Set Our Perspective
	glMatrixMode (GL_MODELVIEW)                             '' Select The Modelview Matrix
	glLoadIdentity ()                                       '' Reset The Modelview Matrix

	glEnable (GL_DEPTH_TEST)                                '' Enable Depth Testing

	dim global_ambient(0 to 3) as single => { _             '' Set Ambient Lighting To Fairly Dark Light (No Color)
		0.2f, 0.2f, 0.2f, 1.0f _
		}
	dim light0pos(0 to 3) as single => { _                  '' Set The Light Position
		0.0f, 5.0f, 10.0f, 1.0f _
		}
	dim light0ambient(0 to 3) as single => { _              '' More Ambient Light
		0.2f, 0.2f, 0.2f, 1.0f _
		}
	dim light0diffuse(0 to 3) as single => { _              '' Set The Diffuse Light A Bit Brighter
		0.3f, 0.3f, 0.3f, 1.0f _
		}
	dim light0specular(0 to 3) as single => { _             '' Fairly Bright Specular Lighting
		0.8f, 0.8f, 0.8f, 1.0f _
		}

	dim lmodel_ambient(0 to 3) as single => { _             '' And More Ambient Light
		0.2f, 0.2f, 0.2f, 1.0f _
		}

	glLightModelfv (GL_LIGHT_MODEL_AMBIENT, @lmodel_ambient(0)) '' Set The Ambient Light Model

	glLightModelfv (GL_LIGHT_MODEL_AMBIENT, @global_ambient(0)) '' Set The Global Ambient Light Model
	glLightfv (GL_LIGHT0, GL_POSITION, @light0pos(0))           '' Set The Lights Position
	glLightfv (GL_LIGHT0, GL_AMBIENT, @light0ambient(0))        '' Set The Ambient Light
	glLightfv (GL_LIGHT0, GL_DIFFUSE, @light0diffuse(0))        '' Set The Diffuse Light
	glLightfv (GL_LIGHT0, GL_SPECULAR, @light0specular(0))      '' Set Up Specular Lighting
	glEnable (GL_LIGHTING)                                      '' Enable Lighting
	glEnable (GL_LIGHT0)                                        '' Enable Light0

	glShadeModel (GL_SMOOTH)                                    '' Select Smooth Shading

	glMateriali (GL_FRONT, GL_SHININESS, 128)
	glClearColor (0.0f, 0.0f, 0.0f, 0.5)                        '' Set The Clear Color To Black

end sub

'' ------------------------------------------------------------------------
sub drawscr ()                                              '' Draw The Scene
	glClearColor (0.0f, 0.0f, 0.0f, 0.5)                    '' Set The Clear Color To Black
	glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)    '' Clear Screen And Depth Buffer
	glLoadIdentity ()                                       '' Reset The View
	RenderToTexture ()                                      '' Render To A Texture
	ProcessHelix ()                                         '' Draw Our Helix
	DrawBlur (25, 0.02f)                                    '' Draw The Blur Effect
	glFlush ()                                              '' Flush The GL Rendering Pipeline
end sub
