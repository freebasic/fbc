'Glu Quadric Test
'This would be better if you use lists instead of callling each quadric
'Example modified from the GL redbook examples(downloadable from OpenGL.org)
'Texture generation also is not really good. A better way would be to use SDL_LoadBMP,
    'then bind the surface to GL_TEXTURE_2D
'Relsoft 2004
'Richard Eric M. Lope BSN RN
'Rel.Betterwebber.com


const PI = 3.141593
const SCR_WIDTH = 640
const SCR_HEIGHT = 480
const BPP = 16
const FALSE = 0
const TRUE = 1



#include  "SDL/SDL.bi"
#include  "GL/gl.bi"
#include  "GL/glu.bi"


declare sub drawscene ()

	dim result as unsigned integer
	dim vpage as SDL_Surface ptr
	dim i as integer, j as integer
	dim FOVy as double
	dim Aspect as double
	dim znear as double
	dim zfar as double

    randomize timer


	result = SDL_Init(SDL_INIT_EVERYTHING)
	if result <> 0 then
  		end 1
	end if

	vpage = SDL_SetVideoMode(SCR_WIDTH, SCR_HEIGHT, BPP, SDL_OPENGL or SDL_OPENGLBLIT)
	if vpage = 0 then
		SDL_Quit
		end 1
	end if

	SDL_WM_SetCaption "Glu Quadric Test", ""

	glViewport 0, 0, SCR_WIDTH, SCR_HEIGHT
	glMatrixMode GL_PROJECTION
	glLoadIdentity

    FOVy = 80/4
    Aspect = SCR_WIDTH / SCR_HEIGHT
    znear = 5
    zfar = 1000
	gluPerspective FOVy, aspect, znear, zfar

	glMatrixMode GL_MODELVIEW
	glLoadIdentity

	glShadeModel GL_SMOOTH
	glClearColor 0.0, 0.0, 0.0, 0.5
	glClearDepth 1.0
	glEnable GL_DEPTH_TEST
	glDepthFunc GL_LEQUAL
	glEnable GL_COLOR_MATERIAL
	glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST

    'lighting
    'Materials (objects)
    dim Mat_Ambient(3) as single = {0.5, 0.5, 0.5, 1.0}
    dim Mat_Specular(3) as single = {1.0, 1.0, 1.0, 1.0}
    dim Mat_Shininess as single = 50.0

    glMaterialfv GL_FRONT, GL_AMBIENT, @Mat_Ambient(0)
    glMaterialfv GL_FRONT, GL_SPECULAR, @Mat_Specular(0)
    glMaterialfv GL_FRONT, GL_SHININESS, @Mat_Shininess


    'Light
    dim Light_Ambient(3) as single = {0.0, 0.5, 0.2, 0.0}
    dim Light_Diffuse(3) as single = {1.0, 0.5, 1.0, 1.0}
    dim Light_Specular(3) as single = {1.0, 1.0, 1.0, 1.0}
    dim Light_Position(3) as single = {1.0, 1.0, 1.0, 0.0}
    dim Model_Ambient(3) as single = {0.5, 0.5, 0.5, 1.0}

    'Load light parameters to GL states
    glLightfv GL_LIGHT0, GL_AMBIENT, @Light_Ambient(0)
    glLightfv GL_LIGHT0, GL_DIFFUSE, @Light_Diffuse(0)
    glLightfv GL_LIGHT0, GL_SPECULAR, @Light_Specular(0)
    glLightfv GL_LIGHT0, GL_POSITION, @Light_position(0)
    glLightModelfv GL_LIGHT_MODEL_AMBIENT, @Model_Ambient(0)

    'Enable light
    glEnable GL_LIGHTING
    glEnable GL_LIGHT0
    glDepthFunc GL_LEQUAL
    glEnable GL_DEPTH_TEST

    'Texture
    'glBindTexture GL_TEXTURE_2D, texture(0,0,0)
    dim imagew as integer, imageh as integer
    dim k as integer
    ImageW = 64
    ImageH = 64
    redim shared Texture(ImageW - 1, ImageH - 1, 2) as ubyte
    for i = 0  to ImageW - 1
        for j = 0 to ImageH - 1
            for k = 0 to 2
                texture(i, j, k) = (i xor j * k) * 2
            next k
        next j
    next i
    glTexImage2D GL_TEXTURE_2D, 0, 3, Imagew,_
                 Imageh, 0, GL_RGB, GL_UNSIGNED_BYTE,_
                 @texture(0,0,0)
    glTexParameterf GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP
    glTexParameterf GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP
    glTexParameterf GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST
    glTexParameterf GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST
    glTexEnvf GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL



    'Quadric stuff
    'Intialize quadric pointers
    'Share through modules
    dim shared qobj_sphere as GLUquadricObj ptr
    dim shared qobj_Cylinder as GLUquadricObj ptr
    dim shared qobj_Disk as GLUquadricObj ptr
    dim shared qobj_Pdisk as GLUquadricObj ptr
    dim shared qobj_sphere2 as GLUquadricObj ptr


    'Load quadric pointers
    qobj_sphere = gluNewQuadric
    qobj_Cylinder = gluNewQuadric
    qobj_Disk = gluNewQuadric
    qobj_Pdisk = gluNewQuadric
    qobj_sphere2 = gluNewQuadric

    'Sphere
    gluQuadricDrawStyle qobj_sphere, GLU_FILL  ' smooth shaded
    gluQuadricNormals qobj_sphere, GLU_SMOOTH
    gluQuadricTexture qobj_sphere, TRUE         'Texture on


    'Cylinder
    gluQuadricDrawStyle qobj_Cylinder, GLU_FILL  ' flat shaded
    gluQuadricNormals qobj_Cylinder, GLU_FLAT


    'Disk
    gluQuadricDrawStyle qobj_Disk, GLU_LINE  ' all polygons wireframe
    gluQuadricNormals qobj_Disk, GLU_NONE


    'Partial disk
    gluQuadricDrawStyle qobj_Pdisk, GLU_SILHOUETTE  ' boundary only
    gluQuadricNormals qobj_Pdisk, GLU_NONE

    'Sphere2
    gluQuadricDrawStyle qobj_sphere, GLU_FILL  ' smooth shaded
    gluQuadricNormals qobj_sphere, GLU_SMOOTH

	dim event as SDL_Event
	do

  		drawscene
		SDL_GL_SwapBuffers

		SDL_PumpEvents
	loop until( (SDL_PollEvent( @event ) <> 0) and ((event.type = SDL_KEYDOWN) or (event.type = SDL_MOUSEBUTTONDOWN)) )

    'delete quadrics
    gluDeleteQuadric qObj_sphere
    gluDeleteQuadric qObj_cylinder
    gluDeleteQuadric qObj_disk
    gluDeleteQuadric qObj_pdisk
    gluDeleteQuadric qObj_sphere2

	SDL_Quit

    end


private sub DrawScene

    static theta as single
    static z as single, zdir as single

    glClear  GL_COLOR_BUFFER_BIT OR GL_DEPTH_BUFFER_BIT


    glPushMatrix                    'word matrix
    
    if( z = 0 ) then
    	z = -10.0
    	zdir = 0.5
    elseif( z > -5.0 ) then
    	zdir = -0.5
    elseif( z < -10.0 ) then
    	zdir = 0.5
    end if
    
    z = z + zdir

    'sphere
    glEnable GL_TEXTURE_2D          'Texture ON
    glEnable GL_LIGHTING            'light on
    glShadeModel GL_SMOOTH
    glTranslatef -1.4, -1.0, -10.0  'move
    glPushMatrix                    'sphere matrix
      glRotatef 110.0 + Theta,  1.0, 0.0, 0.0       'rotate x
      glRotatef 10    + Theta,  0.0, 1.0, 0.0       'rotate y
      glRotatef 120.0 + Theta,  0.0, 0.0, 1.0       'rotate z
      gluSphere qobj_sphere, 0.75, 25, 20           'draw sphere
    glPopMatrix                     'pop sphere matrix
                                    'word matrix still in effect
    glDisable GL_TEXTURE_2D         'Texture OFF

    'cylinder
    glShadeModel GL_SMOOTH
    glTranslatef 0.0, 2.0, 0.0
    glPushMatrix
      glRotatef 210.0 + Theta,  1.0, 0.0, 0.0
      glRotatef 10    + Theta,  0.0, 1.0, 0.0
      glRotatef 120.0 + Theta,  0.0, 0.0, 1.0
      gluCylinder qobj_Cylinder, 0.5, 0.5, 1.0, 25, 15
    glPopMatrix

    'disk
    glDisable GL_LIGHTING
    glColor3f 0.0, 1.0, 1.0
    glTranslatef 2.0, -2.0, 0.0
    glPushMatrix
      glRotatef 10.0 + Theta,  1.0, 0.0, 0.0
      glRotatef 100  + Theta,  0.0, 1.0, 0.0
      glRotatef 20.0 + Theta,  0.0, 0.0, 1.0
      gluDisk qobj_Disk, 0.25, 1.0, 20, 4
    glPopMatrix


    'pacman
    glColor3f 1.0, 1.0, 0.0
    glTranslatef 0.0, 2.0, 0.0
    glPushMatrix
      glRotatef 20.0 + Theta,  1.0, 0.0, 0.0
      glRotatef Theta,         0.0, 1.0, 0.0
      glRotatef 120.0 + Theta, 0.0, 0.0, 1.0
      gluPartialDisk qobj_Pdisk, 0.0, 1.0, 20, 4, 0.0, 225.0
    glPopMatrix


    'Non-textured sphere
    glEnable GL_LIGHTING            'light on
    glShadeModel GL_SMOOTH
    glTranslatef 1.5, -0.7, 0.0
    glPushMatrix
      glTranslatef 0, 0, z  'move
      glRotatef 10.0  + Theta,  1.0, 0.0, 0.0
      glRotatef 10    + Theta,  0.0, 1.0, 0.0
      glRotatef 120.0 + Theta,  0.0, 0.0, 1.0
      gluSphere qobj_sphere2, 1.25, 35, 25           'draw sphere
    glPopMatrix

    glPopMatrix
    glFlush



    theta = theta + 1       'increase rotval

end sub


