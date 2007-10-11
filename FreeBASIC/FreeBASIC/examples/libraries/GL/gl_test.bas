''
'' gltest.bas - freeBASIC opengl example, using GLUT for simplicity
'' by Blitz
''
'' Opengl code ported from nehe's gl tutorials
''

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "GL/glut.bi"

''
declare sub         doMain           ( )
declare sub         doShutdown		 ( )



    ''
    '' Entry point
    ''
    doMain
    

    

'' ::::::::::::
'' name: doRender
'' desc: Is called by glut to render scene
''
'' ::::::::::::
sub doRender cdecl
    static rtri as single
    static rqud as single
    
    glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT
    glPushMatrix
    
    glLoadIdentity
    glTranslatef -1.5, 0.0, -6.0
    glRotatef rtri, 0, 1, 0
         
    glBegin GL_TRIANGLES
		glColor3f   1.0, 0.0, 0.0			'' Red
		glVertex3f  0.0, 1.0, 0.0			'' Top Of Triangle  Front)
		glColor3f   0.0, 1.0, 0.0			'' Green
		glVertex3f -1.0,-1.0, 1.0			'' Left Of Triangle  Front)
		glColor3f   0.0, 0.0, 1.0			'' Blue
		glVertex3f  1.0,-1.0, 1.0			'' Right Of Triangle  Front)
		glColor3f   1.0, 0.0, 0.0			'' Red
		glVertex3f  0.0, 1.0, 0.0			'' Top Of Triangle  Right)
		glColor3f   0.0, 0.0, 1.0			'' Blue
		glVertex3f  1.0,-1.0, 1.0			'' Left Of Triangle  Right)
		glColor3f   0.0, 1.0, 0.0			'' Green
		glVertex3f  1.0,-1.0,-1.0			'' Right Of Triangle  Right)
        glColor3f   1.0, 0.0, 0.0			'' Red
		glVertex3f  0.0, 1.0, 0.0			'' Top Of Triangle  Back)
		glColor3f   0.0, 1.0, 0.0			'' Green
		glVertex3f  1.0,-1.0,-1.0			'' Left Of Triangle  Back)
		glColor3f   0.0, 0.0, 1.0			'' Blue
		glVertex3f -1.0,-1.0,-1.0			'' Right Of Triangle  Back)
		glColor3f   1.0, 0.0, 0.0			'' Red
		glVertex3f  0.0, 1.0, 0.0			'' Top Of Triangle  Left)
		glColor3f   0.0, 0.0, 1.0			'' Blue
		glVertex3f -1.0,-1.0,-1.0			'' Left Of Triangle  Left)
		glColor3f   0.0, 1.0, 0.0			'' Green
		glVertex3f -1.0,-1.0, 1.0			'' Right Of Triangle  Left)
    glEnd
    
    glColor3f 0.5, 0.5, 1.0
    glLoadIdentity    
    glTranslatef -1.5, 0.0, -6.0
	glTranslatef 3.0,0.0,0.0	
	glRotatef rqud, 1.0, 0.0, 0.0
	
	glBegin GL_QUADS
		glVertex3f -1.0, 1.0, 0.0
		glVertex3f  1.0, 1.0, 0.0
		glVertex3f  1.0,-1.0, 0.0
		glVertex3f -1.0,-1.0, 0.0
	glEnd    

    glPopMatrix            
    glutSwapBuffers
    
    rtri = rtri + 2.0
    rqud = rqud + 1.5
    
end sub



'' ::::::::::::
'' name: doInput
'' desc: Handles input
''
'' ::::::::::::
sub doInput CDECL ( byval kbcode as unsigned byte, _
              byval mousex as integer, _
              byval mousey as integer )
              
    if ( kbcode = 27 ) then
        doShutdown
        end 0
    end if

end sub



'' ::::::::::::
'' name: doInitGL
'' desc: Inits OpenGL
''
'' ::::::::::::
sub doInitGL
    dim i as integer
    dim lightAmb(3) as single
    dim lightDif(3) as single
    dim lightPos(3) as single
    
    ''
    '' Rendering stuff
    ''
    glShadeModel GL_SMOOTH
	glClearColor 0.0, 0.0, 0.0, 0.5
	glClearDepth 1.0
	glEnable GL_DEPTH_TEST
	glDepthFunc GL_LEQUAL
    glEnable GL_COLOR_MATERIAL
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST
    
    ''
    '' Light setup ( not used at the moment )
    ''
    for i = 0 to 3
        lightAmb(i) = 0.5
        lightDif(i) = 1.0
        lightPos(i) = 0.0
    next i

    lightAmb(3) = 1.0
    lightPos(2) = 2.0
    lightPos(3) = 1.0    
	
    glLightfv GL_LIGHT1, GL_AMBIENT, @lightAmb(0)
	glLightfv GL_LIGHT1, GL_DIFFUSE, @lightDif(0)
	glLightfv GL_LIGHT1, GL_POSITION,@lightPos(0)
	glEnable GL_LIGHT1

    ''
    '' Blending ( not used at the moment )
    ''
    glColor4f 1.0, 1.0, 1.0, 0.5
    glBlendFunc GL_SRC_ALPHA, GL_ONE

end sub



'' ::::::::::::
'' name: doReshapeGL
'' desc: Reshapes GL window
''
'' ::::::::::::
sub doReshapeGL CDECL ( byval w as integer, _
                        byval h as integer )
    
    glViewport 0, 0, w, h 
    glMatrixMode GL_PROJECTION
    glLoadIdentity
    
    if ( h = 0 ) then
        gluPerspective  80/2, w, 1.0, 5000.0 
    else
        gluPerspective  80/2, w / h, 1.0, 5000.0
    end if
    
    glMatrixMode GL_MODELVIEW
    glLoadIdentity

end sub

'':::::
sub initGLUT
    ''
    '' Setup glut
    ''
    glutInit 1, strptr( " " )    
    
    glutInitWindowPosition 0, 0
    glutInitWindowSize 640, 480
    glutInitDisplayMode GLUT_RGBA or GLUT_DOUBLE or GLUT_DEPTH
    glutCreateWindow "FreeBASIC OpenGL example"
    
    doInitGL
    
    glutDisplayFunc  @doRender
    glutIdleFunc     @doRender
    glutReshapeFunc  @doReshapeGL
    glutKeyboardFunc @doInput

end sub

'':::::
sub doInit
    
	''
	'' Init GLUT
	''
	initGLUT    
	
end sub

'':::::
sub shutdownGLUT

	'' GLUT shutdown will be done automatically by atexit()

end sub

'':::::
sub doShutdown
    
	''
	'' GLUT
	''
	shutdownGLUT
	
end sub

'' ::::::::::::
'' name: doMain
'' desc: Main routine
''
'' ::::::::::::
sub doMain
    
    ''
    '' 
    ''
    doInit
    
    ''
    ''
    ''
    glutMainLoop
    
end sub


