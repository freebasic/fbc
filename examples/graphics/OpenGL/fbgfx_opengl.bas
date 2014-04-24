''
''	This is a quick port of NeHe lesson 4
''
''	Go to http://nehe.gamedev.net for his other great OpenGL tutorials!
''


#include "fbgfx.bi"
#include "GL/gl.bi"
#include "GL/glu.bi"

	dim rtri as single, rquad as single
	
	screen 18, 32, , FB.GFX_OPENGL or FB.GFX_MULTISAMPLE
	
	glViewport 0, 0, 640, 480
	glMatrixMode GL_PROJECTION
	glLoadIdentity
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0
	glMatrixMode GL_MODELVIEW
	glLoadIdentity
	
	glShadeModel GL_SMOOTH
	glClearColor 0.0, 0.0, 0.0, 1.0
	glClearDepth 1.0
	glEnable GL_DEPTH_TEST
	glDepthFunc GL_LEQUAL
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST
	
	do
		glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT
		glLoadIdentity
		glTranslatef -1.5, 0.0, -6.0
		glRotatef rtri, 0, 1, 0
		glBegin GL_TRIANGLES
			glColor3f 1.0, 0.0, 0.0
			glVertex3f 0.0, 1.0, 0.0
			glColor3f 0.0, 1.0, 0.0
			glVertex3f -1.0, -1.0, 0.0
			glColor3f 0.0, 0.0, 1.0
			glVertex3f 1.0, -1.0, 0.0
		glEnd
		
		glLoadIdentity
		glTranslatef 1.5, 0.0, -6.0
		glColor3f 0.5, 0.5, 1.0
		glRotatef rquad, 1, 0, 0
		glBegin GL_QUADS
			glVertex3f -1.0, 1.0, 0.0
			glVertex3f 1.0, 1.0, 0.0
			glVertex3f 1.0, -1.0, 0.0
			glVertex3f -1.0, -1.0, 0.0
		glEnd

		glFlush

		rtri += 0.2
		rquad += 0.15
		flip
	loop while inkey = ""
