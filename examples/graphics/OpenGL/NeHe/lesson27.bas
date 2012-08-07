''  This code has been created by Banu Cosmin aka Choko - 20 may 2000
''  and uses NeHe tutorials as a starting point (window initialization,
''  texture loading, GL initialization and code for keypresses) - very good
''  tutorials, Jeff. If anyone is interested about the presented algorithm
''  please e-mail me at boct@romwest.ro
''
''  Attention!!! This code is not for beginners.
''
''   NeHe Productions ... http://nehe.gamedev.net
''
''------------------------------------------------------------------------------
'' Press ESC key to quit
'' Use Arrow keys to spin object
'' Use L, J, I, K, O & U keys to move light
'' Use 4, 5, 6, 7, 8, & 9 keys to move Object
'' Use A, D, W, S, E & Q keys to move Ball
''------------------------------------------------------------------------------

'' compile as: fbc -s gui lesson27.bas



'' Setup our booleans
const false = 0
const true  = not false
const null = false

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "fbgfx.bi"                '' for Scan code constants
#include once "crt.bi"

#include once "3Dobject.bi"            '' Header File For 3D Object Handling


''------------------------------------------------------------------------------
declare sub VMatMult(byval M as single ptr, byval v as single ptr)
declare function InitGLObjects() as integer
declare sub DrawGLRoom()

''------------------------------------------------------------------------------


dim shared as glObject obj              '' Object

	dim as single xrot=0, xspeed=0      '' X Rotation & X Speed
	dim as single yrot=0, yspeed=0      '' Y Rotation & Y Speed

	dim as single LightPos(0 to 3) => {0.0, 5.0, -4.0, 1.0}     '' Light Position
	dim as single LightAmb(0 to 3) => {0.2, 0.2, 0.2, 1.0}      '' Ambient Light Values
	dim as single LightDif(0 to 3) => {0.6, 0.6, 0.6, 1.0}      '' Diffuse Light Values
	dim as single LightSpc(0 to 3) => {-0.2, -0.2, -0.2, 1.0}   '' Specular Light Values

	dim as single MatAmb(0 to 3) => {0.4, 0.4, 0.4, 1.0}        '' Material - Ambient Values
	dim as single MatDif(0 to 3) => {0.2, 0.6, 0.9, 1.0}        '' Material - Diffuse Values
	dim as single MatSpc(0 to 3) => {0.0, 0.0, 0.0, 1.0}        '' Material - Specular Values
	dim as single MatShn(0) => {0.0}                            '' Material - Shininess

	dim as single ObjPos(0 to 2) => {-2.0, -2.0, -5.0}          '' Object Position

	dim as GLUquadricObj ptr q                                  '' Quadratic For Drawing A Sphere
	dim as single SpherePos(0 to 2) => {-4.0, -5.0, -6.0}

	dim Minv(0 to 15) as single
	dim as single wlp(0 to 3), lp(0 to 3)


	screen 19, 16, , FB.GFX_OPENGL or FB.GFX_STENCIL_BUFFER
	windowtitle "Banu Octavian & NeHe's Shadow Casting Tutorial"   '' Set window title

	'' ReSizeGLScene
	glViewport 0, 0, 800, 600                    '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                   '' Select The Projection Matrix
	glLoadIdentity                               '' Reset The Projection Matrix
	gluPerspective 45.0, 800/600, 0.001, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                    '' Select The Modelview Matrix
	glLoadIdentity                               '' Reset The Projection Matrix

	'' All Setup For OpenGL Goes Here
	if (InitGLObjects()= 0) then end 1           '' Function For Initializing Our Object(s)

	glShadeModel(GL_SMOOTH)                      '' Enable Smooth Shading
	glClearColor(0.0, 0.0, 0.0, 0.5)             '' Black Background
	glClearDepth(1.0)                            '' Depth Buffer Setup
	glClearStencil(0)                            '' Stencil Buffer Setup
	glEnable(GL_DEPTH_TEST)                      '' Enables Depth Testing
	glDepthFunc(GL_LEQUAL)                       '' The Type Of Depth Testing To Do
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)     '' Really Nice Perspective Calculations

	glLightfv(GL_LIGHT1, GL_POSITION, @LightPos(0))       '' Set Light1 Position
	glLightfv(GL_LIGHT1, GL_AMBIENT, @LightAmb(0))        '' Set Light1 Ambience
	glLightfv(GL_LIGHT1, GL_DIFFUSE, @LightDif(0))        '' Set Light1 Diffuse
	glLightfv(GL_LIGHT1, GL_SPECULAR, @LightSpc(0))       '' Set Light1 Specular
	glEnable(GL_LIGHT1)                                   '' Enable Light1
	glEnable(GL_LIGHTING)                                 '' Enable Lighting

	glMaterialfv(GL_FRONT, GL_AMBIENT, @MatAmb(0))        '' Set Material Ambience
	glMaterialfv(GL_FRONT, GL_DIFFUSE, @MatDif(0))        '' Set Material Diffuse
	glMaterialfv(GL_FRONT, GL_SPECULAR, @MatSpc(0))       '' Set Material Specular
	glMaterialfv(GL_FRONT, GL_SHININESS, @MatShn(0))      '' Set Material Shininess

	glCullFace(GL_BACK)                          '' Set Culling Face To Back Face
	glEnable(GL_CULL_FACE)                       '' Enable Culling
	glClearColor(0.1, 1.0, 0.5, 1.0)             '' Set Clear Color (Greenish Color)

	q = gluNewQuadric()                          '' Initialize Quadratic
	gluQuadricNormals(q, GL_SMOOTH)              '' Enable Smooth Normal Generation
	gluQuadricTexture(q, GL_FALSE)               '' Disable Auto Texture Coords

	do
		'' Clear Color Buffer, Depth Buffer, Stencil Buffer
		glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT)

		glLoadIdentity()                                  '' Reset Modelview Matrix
		glTranslatef(0.0, 0.0, -20.0)                     '' Zoom Into Screen 20 Units
		glLightfv(GL_LIGHT1, GL_POSITION, @LightPos(0))   '' Position Light1
		glTranslatef(SpherePos(0), SpherePos(1), SpherePos(2))     '' Position The Sphere
		gluSphere(q, 1.5, 32, 16)                         '' Draw A Sphere

		'' calculate light's position relative to local coordinate system
		'' dunno if this is the best way to do it, but it actually works
		'' if u find another aproach, let me know  )

		'' we build the inversed matrix by doing all the actions in reverse order
		'' and with reverse parameters (notice -xrot, -yrot, -ObjPos[], etc.)
		glLoadIdentity()                                  '' Reset Matrix
		glRotatef(-yrot, 0.0, 1.0, 0.0)                   '' Rotate By -yrot On Y Axis
		glRotatef(-xrot, 1.0, 0.0, 0.0)                   '' Rotate By -xrot On X Axis
		glGetFloatv(GL_MODELVIEW_MATRIX,@Minv(0))         '' Retrieve ModelView Matrix (Stores In Minv)
		lp(0) = LightPos(0)                               '' Store Light Position X In lp[0]
		lp(1) = LightPos(1)                               '' Store Light Position Y In lp[1]
		lp(2) = LightPos(2)                               '' Store Light Position Z In lp[2]
		lp(3) = LightPos(3)                               '' Store Light Direction In lp[3]
		VMatMult(@Minv(0), @lp(0))                        '' We Store Rotated Light Vector In 'lp' Array
		glTranslatef(-ObjPos(0), -ObjPos(1), -ObjPos(2))  '' Move Negative On All Axis Based On ObjPos[] Values (X, Y, Z)
		glGetFloatv(GL_MODELVIEW_MATRIX,@Minv(0))         '' Retrieve ModelView Matrix From Minv
		wlp(0) = 0.0                                      '' World Local Coord X To 0
		wlp(1) = 0.0                                      '' World Local Coord Y To 0
		wlp(2) = 0.0                                      '' World Local Coord Z To 0
		wlp(3) = 1.0
		VMatMult(@Minv(0), @wlp(0))                       '' We Store The Position Of The World Origin Relative To The
		'' Local Coord. System In 'wlp' Array
		lp(0) += wlp(0)                                   '' Adding These Two Gives Us The
		lp(1) += wlp(1)                                   '' Position Of The Light Relative To
		lp(2) += wlp(2)                                   '' The Local Coordinate System
		glColor4f(0.7, 0.4, 0.0, 1.0)                     '' Set Color To An Orange
		glLoadIdentity()                                  '' Reset Modelview Matrix
		glTranslatef(0.0, 0.0, -20.0)                     '' Zoom Into The Screen 20 Units
		DrawGLRoom()                                      '' Draw The Room
		glTranslatef(ObjPos(0), ObjPos(1), ObjPos(2))     '' Position The Object
		glRotatef(xrot, 1.0, 0.0, 0.0)                    '' Spin It On The X Axis By xrot
		glRotatef(yrot, 0.0, 1.0, 0.0)                    '' Spin It On The Y Axis By yrot
		DrawGLObject(@obj)                                '' Procedure For Drawing The Loaded Object
		CastShadow(@obj, @lp(0))                          '' Procedure For Casting The Shadow Based On The Silhouette
		glColor4f(0.7, 0.4, 0.0, 1.0)                     '' Set Color To Purplish Blue
		glDisable(GL_LIGHTING)                            '' Disable Lighting
		glDepthMask(GL_FALSE)                             '' Disable Depth Mask
		glTranslatef(lp(0), lp(1), lp(2))                 '' Translate To Light's Position
		'' Notice We're Still In Local Coordinate System
		gluSphere(q, 0.2, 16, 8)                          '' Draw A Little Yellow Sphere (Represents Light)
		glEnable(GL_LIGHTING)                             '' Enable Lighting
		glDepthMask(GL_TRUE)                              '' Enable Depth Mask

		xrot += xspeed                                    '' Increase xrot By xspeed
		yrot += yspeed                                    '' Increase yrot By yspeed

		glFlush()                                         '' Flush The OpenGL Pipeline
		'' Keyboard handlers
		'' Spin Object
		if MULTIKEY(FB.SC_LEFT) then yspeed -= 0.1           '' 'Arrow Left' Decrease yspeed
		if MULTIKEY(FB.SC_RIGHT) then yspeed += 0.1          '' 'Arrow Right' Increase yspeed
		if MULTIKEY(FB.SC_UP) then xspeed -= 0.1             '' 'Arrow Up' Decrease xspeed
		if MULTIKEY(FB.SC_DOWN) then xspeed += 0.1           '' 'Arrow Down' Increase xspeed

		'' Adjust Light's Position
		if MULTIKEY(FB.SC_L) then LightPos(0) += 0.05        '' 'L' Moves Light Right
		if MULTIKEY(FB.SC_J) then LightPos(0) -= 0.05        '' 'J' Moves Light Left

		if MULTIKEY(FB.SC_I) then LightPos(1) += 0.05        '' 'I' Moves Light Up
		if MULTIKEY(FB.SC_K) then LightPos(1) -= 0.05        '' 'K' Moves Light Down

		if MULTIKEY(FB.SC_O) then LightPos(2) += 0.05        '' 'O' Moves Light Toward Viewer
		if MULTIKEY(FB.SC_U) then LightPos(2) -= 0.05        '' 'U' Moves Light Away From Viewer

		'' Adjust Object's Position
		if MULTIKEY(FB.SC_6) then ObjPos(0) += 0.05          '' '6' Move Object Right
		if MULTIKEY(FB.SC_4) then ObjPos(0) -= 0.05          '' '4' Move Object Left

		if MULTIKEY(FB.SC_8) then ObjPos(1) += 0.05          '' '8' Move Object Up
		if MULTIKEY(FB.SC_5) then ObjPos(1) -= 0.05          '' '5' Move Object Down

		if MULTIKEY(FB.SC_9) then ObjPos(2) += 0.05          '' '9' Move Object Toward Viewer
		if MULTIKEY(FB.SC_7) then ObjPos(2) -= 0.05          '' '7' Move Object Away From Viewer

		'' Adjust Ball's Position
		if MULTIKEY(FB.SC_D) then SpherePos(0) += 0.05       '' 'D' Move Ball Right
		if MULTIKEY(FB.SC_A) then SpherePos(0) -= 0.05       '' 'A' Move Ball Left

		if MULTIKEY(FB.SC_W) then SpherePos(1) += 0.05       '' 'W' Move Ball Up
		if MULTIKEY(FB.SC_S) then SpherePos(1) -= 0.05       '' 'S' Move Ball Down

		if MULTIKEY(FB.SC_E) then SpherePos(2) += 0.05       '' 'E' Move Ball Toward Viewer
		if MULTIKEY(FB.SC_Q) then SpherePos(2) -= 0.05       '' 'Q' Move Ball Away From Viewer

		flip  '' flip or crash
		if inkey = chr(255)+"k" then exit do            '' exit if close box is clicked
	loop while MULTIKEY(FB.SC_ESCAPE) = 0

	'' Empty keyboard buffer
	while INKEY <> "": wend


	end


sub VMatMult(byval M as single ptr, byval v as single ptr)
	dim as single res(0 to 3)                             '' Hold Calculated Results
	res(0)=M[ 0]*v[0]+M[ 4]*v[1]+M[ 8]*v[2]+M[12]*v[3]
	res(1)=M[ 1]*v[0]+M[ 5]*v[1]+M[ 9]*v[2]+M[13]*v[3]
	res(2)=M[ 2]*v[0]+M[ 6]*v[1]+M[10]*v[2]+M[14]*v[3]
	res(3)=M[ 3]*v[0]+M[ 7]*v[1]+M[11]*v[2]+M[15]*v[3]
	v[0]=res(0)                                           '' Results Are Stored Back In v[]
	v[1]=res(1)
	v[2]=res(2)
	v[3]=res(3)                                           '' Homogenous Coordinate
end sub

'' Initialize Objects
function InitGLObjects() as integer
	dim as uinteger i

	if (ReadObject(exepath + "/data/Object2.txt", @obj) = 0) then    '' Read Object2 Into obj
		return FALSE                                      '' If Failed Return False
	end if

	SetConnectivity(@obj)                                 '' Set Face To Face Connectivity

	for i=0  to obj.nPlanes-1            '' Loop Through All Object Planes
		CalcPlane(@obj, @obj.planes(i))  '' Compute Plane Equations For All Faces
	next

	return TRUE                          '' Return True
end function

'' Draw The Room (Box)
sub DrawGLRoom()
	glBegin(GL_QUADS)                    '' Begin Drawing Quads
		'' Floor
		glNormal3f(0.0, 1.0, 0.0)                     '' Normal Pointing Up
		glVertex3f(-10.0,-10.0,-20.0)                 '' Back Left
		glVertex3f(-10.0,-10.0, 20.0)                 '' Front Left
		glVertex3f( 10.0,-10.0, 20.0)                 '' Front Right
		glVertex3f( 10.0,-10.0,-20.0)                 '' Back Right
		'' Ceiling
		glNormal3f(0.0,-1.0, 0.0)                     '' Normal Point Down
		glVertex3f(-10.0, 10.0, 20.0)                 '' Front Left
		glVertex3f(-10.0, 10.0,-20.0)                 '' Back Left
		glVertex3f( 10.0, 10.0,-20.0)                 '' Back Right
		glVertex3f( 10.0, 10.0, 20.0)                 '' Front Right
		'' Front Wall
		glNormal3f(0.0, 0.0, 1.0)                     '' Normal Pointing Away From Viewer
		glVertex3f(-10.0, 10.0,-20.0)                 '' Top Left
		glVertex3f(-10.0,-10.0,-20.0)                 '' Bottom Left
		glVertex3f( 10.0,-10.0,-20.0)                 '' Bottom Right
		glVertex3f( 10.0, 10.0,-20.0)                 '' Top Right
		'' Back Wall
		glNormal3f(0.0, 0.0,-1.0)                     '' Normal Pointing Towards Viewer
		glVertex3f( 10.0, 10.0, 20.0)                 '' Top Right
		glVertex3f( 10.0,-10.0, 20.0)                 '' Bottom Right
		glVertex3f(-10.0,-10.0, 20.0)                 '' Bottom Left
		glVertex3f(-10.0, 10.0, 20.0)                 '' Top Left
		'' Left Wall
		glNormal3f(1.0, 0.0, 0.0)                     '' Normal Pointing Right
		glVertex3f(-10.0, 10.0, 20.0)                 '' Top Front
		glVertex3f(-10.0,-10.0, 20.0)                 '' Bottom Front
		glVertex3f(-10.0,-10.0,-20.0)                 '' Bottom Back
		glVertex3f(-10.0, 10.0,-20.0)                 '' Top Back
		'' Right Wall
		glNormal3f(-1.0, 0.0, 0.0)                    '' Normal Pointing Left
		glVertex3f( 10.0, 10.0,-20.0)                 '' Top Back
		glVertex3f( 10.0,-10.0,-20.0)                 '' Bottom Back
		glVertex3f( 10.0,-10.0, 20.0)                 '' Bottom Front
		glVertex3f( 10.0, 10.0, 20.0)                 '' Top Front
	glEnd()                              '' Done Drawing Quads
end sub
