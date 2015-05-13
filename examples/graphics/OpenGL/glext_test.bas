'gl_ext_test.bas - FreeBASIC OpenGL example by Bryan Stoeberl
'demonstrating function pointers for using OpenGL extensions


#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "GL/glext.bi"
#include once "GL/glfw.bi"

#ifndef FALSE
#define FALSE 0
#define TRUE (-1)
#endif

type MOUSECTX
	xpos		as integer
	ypos		as integer
end type

type CONTEXT
	width		as integer
	height		as integer
	updviewport	as integer
	mouse		as MOUSECTX
	redraw		as integer
end type

const WIN_WIDTH 	= 400
const WIN_HEIGHT	= 300
const WIN_BPP		= 16

declare sub main ()
declare sub shutdown ()

''
'' globals	
''
	dim shared ctx as CONTEXT = ( WIN_WIDTH, WIN_HEIGHT, TRUE, (WIN_WIDTH\2, WIN_HEIGHT\2), TRUE )
	
	dim shared TexID(1) as uinteger		'our Texture Objects

	dim shared glActiveTextureARB_ as PFNGLACTIVETEXTUREARBPROC
	dim shared glMultiTexCoord2iARB_ as PFNGLMULTITEXCOORD2IARBPROC

	main( )

'':::::
sub windowSizeCB GLFWCALL( byval w as integer, byval h as integer )
    
    ctx.width  = w
    ctx.height = h
    ctx.updviewport = TRUE
    ctx.mouse.xpos = w \ 2
    ctx.mouse.ypos = h \ 2
    ctx.redraw = TRUE
    
end sub

'':::::
sub mousePosCB GLFWCALL ( byval x as integer, byval y as integer )

	ctx.mouse.xpos = x
	ctx.mouse.ypos = y
	ctx.redraw = TRUE

end sub

'':::::
sub initGL
	dim TexUnits as integer

    glGetIntegerv GL_MAX_TEXTURE_UNITS, @TexUnits
	print "Your GL implementation supports"; TexUnits; " texture unit(s)."

	'could also use glutExtensionSupported()
	if glfwExtensionSupported( "GL_ARB_multitexture" ) = 0 then
		print "You do not have the ARB multitexture extension."
		sleep
		shutdown		
	end if

	glActiveTextureARB_ = cast(PFNGLACTIVETEXTUREARBPROC, glfwGetProcAddress( "glActiveTextureARB" ))
	glMultiTexCoord2iARB_ = cast(PFNGLMULTITEXCOORD2IARBPROC, glfwGetProcAddress( "glMultiTexCoord2iARB" ))

	'shouldn't be necessary, but can't be too careful
	if (glActiveTextureARB_ = NULL) or (glMultiTexCoord2iARB_ = NULL) then 
		shutdown
	end if
			
	''
	dim x as integer, y as integer, i as integer
	dim Img(16383) as ubyte
	dim DistSq as single, Falloff as single

    glGenTextures 2, @TexID(0)

	glActiveTextureARB_(GL_TEXTURE0_ARB)
	glBindTexture GL_TEXTURE_2D, TexID(0)
	'make a simple checked pattern
	i=0
	for y = 0 to 127
		for x = 0 to 127
			if (y AND 8) then
				if (x AND 8) then Img(i) = 255 else Img(i) = 128
			else
				if (x AND 8) then Img(i) = 128 else Img(i) = 0
			end if
			i=i+1
		next x
	next y

	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR
	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR
	glTexEnvi GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE
    glTexImage2D GL_TEXTURE_2D, 0, 1, 128, 128, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, @Img(0)
	glEnable GL_TEXTURE_2D

	glActiveTextureARB_(GL_TEXTURE1_ARB)
	glBindTexture GL_TEXTURE_2D, TexID(1)
	'build a 2D attenuation map
	i=0
	for y = -64 to 63
		for x = -64 to 63
			DistSq = x*x + y*y
			if DistSq < 4096 then
				FallOff = (4096 - DistSq) / 4096
				Img(i) = (FallOff^2) * 255
			else
				Img(i) = 0
			end if
			i=i+1
		next x
	next y
	
	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR
	glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR
	glTexEnvi GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE
    glTexImage2D GL_TEXTURE_2D, 0, 1, 128, 128, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, @Img(0)
	glEnable GL_TEXTURE_2D

	glClearColor 0.0, 0.0, 0.0, 0.0	

end sub

'':::::
sub initGLFW

    '' init
    glfwInit( )
    
    '' create window
    if( glfwOpenWindow( WIN_WIDTH, WIN_HEIGHT, 0,0,0,0, WIN_BPP,0, GLFW_WINDOW ) = 0 ) then
        shutdown
    end if
    
    '' set title
    glfwSetWindowTitle( "FreeBASIC OpenGL Extension example" )
    
    '' set callbacks
    glfwSetWindowSizeCallback( @windowSizeCB )
    glfwSetMousePosCallback( @mousePosCB )
    
end sub

'':::::
sub init
    
	initGLFW
	
	initGL
	
end sub

'':::::
sub shutdownGLFW

	glfwTerminate( )

end sub

'':::::
sub shutdownGL

	glDeleteTextures( 2, @TexID(0) )

end sub

'':::::
sub shutdown
    
    shutdownGL
	
	shutdownGLFW

	end 0
	
end sub

'':::::
sub renderScene
    
	''
	if( ctx.updviewport ) then
    	ctx.updviewport = FALSE
    	
    	glViewport 0, 0, ctx.width, ctx.height
    	glMatrixMode GL_PROJECTION
    	glLoadIdentity
    
    	if ( ctx.height = 0 ) then
        	gluPerspective 60, ctx.width, 1.0, 100.0 
    	else
        	gluPerspective 60, ctx.width / ctx.height, 1.0, 100.0
    	end if
    
    	glMatrixMode GL_MODELVIEW
    	glLoadIdentity
    
    end if

	''
	glClear GL_COLOR_BUFFER_BIT
	glPushMatrix
		glTranslatef 1.0 - (ctx.mouse.xpos*2) / ctx.width, _
					 (ctx.mouse.ypos*2) / ctx.height, _
					 -5.0	'set the quad back 5 units
         
		glBegin GL_QUADS
			'first texture unit may use standard TexCoord call
			glTexCoord2i 0, 0	
			glMultiTexCoord2iARB_(GL_TEXTURE1_ARB, 0, 0)
			glVertex2i -3, -3
			
			glTexCoord2i 1, 0
			glMultiTexCoord2iARB_(GL_TEXTURE1_ARB, 1, 0)
			glVertex2i  3, -3
			
			glTexCoord2i 1, 1
			glMultiTexCoord2iARB_(GL_TEXTURE1_ARB, 1, 1)
			glVertex2i  3, 3
			
			glTexCoord2i 0, 1
			glMultiTexCoord2iARB_(GL_TEXTURE1_ARB, 0, 1)
			glVertex2i -3, 3
		glEnd    
	glPopMatrix            
	
end sub

'':::::
sub main
	dim running as integer
    
    ''
    init( )
    
    ''
    do
    
    	if( ctx.redraw ) then
    		ctx.redraw = FALSE
    		
    		'' render the scene
    		renderScene( )
    	
        else
        
        	'' Idle process
        	glfwSleep( 0.05 )
        	
        end if

        '' Swap buffers
        glfwSwapBuffers( )
        	
        '' Check if the ESC key was pressed or the window was closed
        running = (glfwGetKey( GLFW_KEY_ESC ) = 0) and _
                  (glfwGetWindowParam( GLFW_OPENED ) = 1)
    loop while( running )

    ''
	shutdown( )

    
end sub


