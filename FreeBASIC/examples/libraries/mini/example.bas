

#include "GL/glut.bi"
#include "mini.bi"

#define NULL 0

dim shared as integer winwidth, winheight, winid

sub displayfunc cdecl()
	dim res as single = 1.0
	dim as single ex = 0.0, ey = 10.0, ez = 30.0
	dim as single fx = 0.0, fy = 10.0, fz = 30.0
	dim as single dx = 0.0, dy = -0.25, dz = -1.0
	dim as single ux = 0.0, uy = 1.0, uz = 0.0
	dim as single fovy = 60.0
	dim as single aspect = 1.0
	dim as single nearp = 1.0
	dim as single farp = 100.0

	aspect = csng(winwidth/winheight)

	glClear(GL_COLOR_BUFFER_BIT Or GL_DEPTH_BUFFER_BIT)
	
	glMatrixMode(GL_PROJECTION)
	glLoadIdentity()
	gluPerspective(fovy,aspect,nearp,farp)
	
	glMatrixMode(GL_MODELVIEW)
	glLoadIdentity()
	gluLookAt(ex,ey,ez,ex+dx,ey+dy,ez+dz,ux,uy,uz)
	
	mini_drawlandscape(res, _
                       ex,ey,ez, _
                       fx,fy,fz, _
                       dx,dy,dz, _
                       ux,uy,uz, _
                       fovy,aspect, _
                       nearp,farp)

   glutSwapBuffers()
end sub

sub reshapefunc cdecl(byval _width as integer, byval height as integer)
   winwidth=_width
   winheight=height

   glViewport(0,0,_width,height)

   displayfunc()
end sub

sub keyboardfunc cdecl(byval key as ubyte, byval x as integer, byval y as integer)
	if key = asc("q") or key = 27 then
		mini_deletemaps()
		glutDestroyWindow(winid)
		end 0
	end if
end sub


dim hfield(8) as short = {0,0,0,_
                          0,5,0,_
                          0,0,0}
                          
dim size as integer = 3

dim _dim as single = 10.0
dim scale as single = 1.0
dim as any ptr map, d2map

dim texture(16*3-1) as ubyte = {255,63,63, 255,63,63, 255,63,63, 255,63,63,_
                                255,63,63, 63,63,255, 63,63,255, 255,63,63,_
                                255,63,63, 63,63,255, 63,63,255, 255,63,63,_
                                255,63,63, 255,63,63, 255,63,63, 255,63,63}
dim _width as integer = 4, height as integer = 4
dim texid as integer

dim as ubyte ffield(8) = {2,3,2,_
                          3,1,3,_
                          2,3,2}

dim fogsize as integer = 3

dim lambda as single = 1.0
dim displace as single = 5.0E-3
dim emission as single = 0.05
dim attenuation as single = 1.0

dim fogmap as any ptr

	winwidth=512
	winheight=512
	
	glutInit 1, strptr(" ") ''(@argc,argv)
	glutInitWindowSize(winwidth,winheight)
	glutInitDisplayMode(GLUT_RGB Or GLUT_ALPHA Or GLUT_DEPTH Or GLUT_DOUBLE)
	winid=glutCreateWindow("example")
	
	glutDisplayFunc(@displayfunc)
	glutReshapeFunc(@reshapefunc)
	glutMouseFunc(NULL)
	glutMotionFunc(NULL)
	glutKeyboardFunc(@keyboardfunc)
	glutSpecialFunc(NULL)
	glutIdleFunc(NULL)
	
	map=mini_initmap(@hfield(0),@d2map,@size,@_dim,scale)
	
	texid=mini_inittexmap(@texture(0),@_width,@height)
	
	fogmap=mini_initfogmap(@ffield(0),fogsize,lambda,displace,emission,attenuation)
	
	mini_setmaps(map,d2map,size,_dim,scale,texid,_width,height, _
	             1.0,0.0,0.0,0.0,NULL,NULL, _
	             fogmap,lambda,displace, _
	             emission)
	
	glutMainLoop()

