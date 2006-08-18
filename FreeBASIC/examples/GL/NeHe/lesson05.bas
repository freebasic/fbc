''
''    This Code Was Created By Jeff Molofee 2000
''    A HUGE Thanks To Fredric Echols For Cleaning Up
''    And Optimizing The Base Code, Making It More Flexible!
''    If You've Found This Code Useful, Please Let Me Know.
''    Visit My Site At nehe.gamedev.net




#include once "GL/gl.bi"
#include once "GL/glu.bi"

	dim rtri as single, rquad as single

	screen 18, 16, , 2

	'' ReSizeGLScene
	glViewport 0, 0, 640, 480                      '' Reset The Current Viewport
	glMatrixMode GL_PROJECTION                     '' Select The Projection Matrix
	glLoadIdentity                                 '' Reset The Projection Matrix
	gluPerspective 45.0, 640.0/480.0, 0.1, 100.0   '' Calculate The Aspect Ratio Of The Window
	glMatrixMode GL_MODELVIEW                      '' Select The Modelview Matrix
	glLoadIdentity                                 '' Reset The Modelview Matrix
	
	'' All Setup For OpenGL Goes Here
	glShadeModel GL_SMOOTH                         '' Enable Smooth Shading
	glClearColor 0.0, 0.0, 0.0, 0.5                '' Black Background
	glClearDepth 1.0                               '' Depth Buffer Setup
	glEnable GL_DEPTH_TEST                         '' Enables Depth Testing
	glDepthFunc GL_LEQUAL                          '' The Type Of Depth Testing To Do
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST    '' Really Nice Perspective Calculations


	do
   		glClear GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT      '' Clear Screen And Depth Buffer
   		glLoadIdentity                                          '' Reset The Current Modelview Matrix
   	
   		glTranslatef -1.5, 0.0, -6.0                            '' Move Left 1.5 Units And Into The Screen 6.0
	   	glRotatef rtri, 0.0, 1.0, 0.0                           '' Rotate The Triangle On The X axis ( NEW )
	
	   	glBegin GL_TRIANGLES                                    '' Start Drawing A Triangle
	    
		    glColor3f 1.0, 0.0, 0.0                              '' Red
		    glVertex3f 0.0, 1.0, 0.0                             '' Top Of Triangle (Front)
		    glColor3f 0.0, 1.0, 0.0                              '' Green
		    glVertex3f -1.0, -1.0, 1.0                           '' Left Of Triangle (Front)
		    glColor3f   0.0, 0.0, 1.0                            '' Blue
		    glVertex3f 1.0, -1.0, 1.0                            '' Right Of Triangle (Front)
		
		    glColor3f 1.0, 0.0, 0.0                              '' Red
		    glVertex3f 0.0, 1.0, 0.0                             '' Top Of Triangle (Right)
		    glColor3f 0.0, 0.0, 1.0                              '' Blue
		    glVertex3f 1.0, -1.0, 1.0                            '' Left Of Triangle (Right)
		    glColor3f 0.0, 1.0, 0.0                              '' Green
		    glVertex3f 1.0, -1.0, -1.0                           '' Right Of Triangle (Right)
		
		    glColor3f 1.0, 0.0, 0.0                              '' Red
		    glVertex3f 0.0, 1.0, 0.0                             '' Top Of Triangle (Back)
		    glColor3f 0.0, 1.0, 0.0                              '' Green
		    glVertex3f 1.0, -1.0, -1.0                           '' Left Of Triangle (Back)
		    glColor3f 0.0, 0.0, 1.0                              '' Blue
		    glVertex3f -1.0, -1.0, -1.0                          '' Right Of Triangle (Back)
		
		    glColor3f 1.0, 0.0, 0.0                              '' Red
		    glVertex3f 0.0, 1.0, 0.0                             '' Top Of Triangle (Left)
		    glColor3f 0.0, 0.0, 1.0                              '' Blue
		    glVertex3f -1.0, -1.0, -1.0                          '' Left Of Triangle (Left)
		    glColor3f 0.0, 1.0, 0.0                              '' Green
		    glVertex3f -1.0, -1.0, 1.0                           '' Right Of Triangle (Left)
		glEnd                                                   '' Done Drawing The Pyramid

   		glLoadIdentity                                          '' Reset The Current Modelview Matrix
   		glTranslatef 1.5, 0.0, -7.0                             '' Move Right 1.5 Units And Into The Screen 7.0
   		glRotatef rquad,1.0, 1.0, 1.0                           '' Rotate The Quad On The X axis ( NEW )
   		
   		glBegin GL_QUADS                                        '' Draw A Quad
			glColor3f 0.0, 1.0, 0.0                              '' Set The Color To Blue
		    glVertex3f 1.0, 1.0, -1.0                            '' Top Right Of The Quad (Top)
		    glVertex3f -1.0, 1.0, -1.0                           '' Top Left Of The Quad (Top)
		    glVertex3f -1.0, 1.0, 1.0                            '' Bottom Left Of The Quad (Top)
		    glVertex3f 1.0, 1.0, 1.0                             '' Bottom Right Of The Quad (Top)
		    
		    glColor3f 1.0, 0.5, 0.0                              '' Set The Color To Orange
		    glVertex3f 1.0, -1.0, 1.0                            '' Top Right Of The Quad (Bottom)
		    glVertex3f -1.0, -1.0, 1.0                           '' Top Left Of The Quad (Bottom)
		    glVertex3f -1.0, -1.0, -1.0                          '' Bottom Left Of The Quad (Bottom)
		    glVertex3f 1.0, -1.0, -1.0                           '' Bottom Right Of The Quad (Bottom)
		    
		    glColor3f 1.0, 0.0, 0.0                              '' Set The Color To Red
		    glVertex3f 1.0, 1.0, 1.0                             '' Top Right Of The Quad (Front)
		    glVertex3f -1.0, 1.0, 1.0                            '' Top Left Of The Quad (Front)
		    glVertex3f -1.0, -1.0, 1.0                           '' Bottom Left Of The Quad (Front)
		    glVertex3f 1.0, -1.0, 1.0                            '' Bottom Right Of The Quad (Front)
		    
		    glColor3f 1.0, 1.0, 0.0                              '' Set The Color To Yellow
		    glVertex3f 1.0, -1.0, -1.0                           '' Top Right Of The Quad (Back)
		    glVertex3f -1.0, -1.0, -1.0                          '' Top Left Of The Quad (Back)
		    glVertex3f -1.0, 1.0, -1.0                           '' Bottom Left Of The Quad (Back)
		    glVertex3f 1.0, 1.0, -1.0                            '' Bottom Right Of The Quad (Back)
		    
		    glColor3f 0.0, 0.0, 1.0                              '' Set The Color To Blue
		    glVertex3f -1.0, 1.0, 1.0                            '' Top Right Of The Quad (Left)
		    glVertex3f -1.0, 1.0, -1.0                           '' Top Left Of The Quad (Left)
		    glVertex3f -1.0, -1.0, -1.0                          '' Bottom Left Of The Quad (Left)
		    glVertex3f -1.0, -1.0, 1.0                           '' Bottom Right Of The Quad (Left)
		    
		    glColor3f 1.0, 0.0, 1.0                              '' Set The Color To Violet
		    glVertex3f 1.0, 1.0, -1.0                            '' Top Right Of The Quad (Right)
		    glVertex3f 1.0, 1.0, 1.0                             '' Top Left Of The Quad (Right)
		    glVertex3f 1.0, -1.0, 1.0                            '' Bottom Left Of The Quad (Right)
		    glVertex3f 1.0, -1.0, -1.0                           '' Bottom Right Of The Quad (Right)
   		glEnd                                                   '' Done Drawing The Quad

   		rtri  = rtri + 0.2                                      '' Increase The Rotation Variable For The Triangle ( NEW )
   		rquad = rquad -0.15                                     '' Decrease The Rotation Variable For The Quad ( NEW )

		flip
	loop while inkey = ""
