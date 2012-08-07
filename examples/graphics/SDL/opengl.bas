''
'' SDL + Opengl example
''
'' Opengl code ported from nehe's gl tutorials
''



#include  "SDL/SDL.bi"
#include  "GL/gl.bi"
#include  "GL/glu.bi"

declare sub doRender ()

	dim result as unsigned integer
	dim video as SDL_Surface ptr
	dim event as SDL_Event
	
	dim i as integer
	dim lightAmb(3) as single
	dim lightDif(3) as single
	dim lightPos(3) as single
	dim w as integer
	dim h as integer

	w = 1024
	h = 768

	result = SDL_Init(SDL_INIT_EVERYTHING)
	if result <> 0 then
  		end 1
	end if

	video = SDL_SetVideoMode( w, h, 16, SDL_DOUBLEBUF or SDL_OPENGL or SDL_OPENGLBLIT or SDL_FULLSCREEN)
	if video = 0 then 
		SDL_Quit
		end 1
	end if
	
	SDL_GL_SetAttribute SDL_GL_RED_SIZE, 5 
	SDL_GL_SetAttribute SDL_GL_GREEN_SIZE, 5 
	SDL_GL_SetAttribute SDL_GL_BLUE_SIZE, 5 
	SDL_GL_SetAttribute SDL_GL_DEPTH_SIZE, 16 
	SDL_GL_SetAttribute SDL_GL_DOUBLEBUFFER, 1 


	glViewport 0, 0, w, h 
	glMatrixMode GL_PROJECTION
	glLoadIdentity
    
	gluPerspective 80/2, w / h, 1.0, 5000.0
    
	glMatrixMode GL_MODELVIEW
	glLoadIdentity

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



	do
	
  		doRender
	
		SDL_GL_SwapBuffers
	
		SDL_PumpEvents
	loop until( (SDL_PollEvent( @event ) <> 0) and ((event.type = SDL_KEYDOWN) or (event.type = SDL_MOUSEBUTTONDOWN)) )

	SDL_Quit


sub doRender
    static rtri as single
    static rqud as single
    
    glClear GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT
    glPushMatrix
    
    glLoadIdentity
    glTranslatef -1.5, 0.0, -6.0
    glRotatef rtri, 0.0, 1.0, 0.0
         
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
    
    rtri = rtri + 2.0
    rqud = rqud + 1.5
    
end sub

