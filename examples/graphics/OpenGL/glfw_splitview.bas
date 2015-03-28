''========================================================================
'' This is a small test application for GLFW.
'' The program uses a "split window" view, rendering four views of the
'' same scene in one window (e.g. uesful for 3D modelling software). This
'' demo uses scissors to separete the four different rendering areas from
'' each other.
''
'' (If the code seems a little bit strange here and there, it may be
''  because I am not a friend of orthogonal projections)
''========================================================================

#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "GL/glfw.bi"

#define FALSE 0
#define TRUE (-1)

#ifndef PI
#define PI 3.14159265358979323846
#endif

''========================================================================
'' Global variables
''========================================================================

''
dim shared as integer doredraw

'' Mouse position
dim shared as integer xpos, ypos

'' Window size
dim shared as integer width_, height

'' Active view: 0 = none, 1 = upper left, 2 = upper right, 3 = lower left,
'' 4 = lower right
dim shared as integer active_view = 0

'' Rotation around each axis
dim shared as integer rot_x, rot_y, rot_z


''========================================================================
'' DrawTorus() - Draw a solid torus (use a display list for the model)
''========================================================================

#define TORUS_MAJOR     1.5
#define TORUS_MINOR     0.5
#define TORUS_MAJOR_RES 32
#define TORUS_MINOR_RES 32

sub DrawTorus( )
    static as GLuint torus_list = 0
    dim as integer i, j, k
    dim as double s, t, x, y, z, nx, ny, nz, scale, twopi

    if( torus_list = 0 ) then
        '' Start recording displaylist
        torus_list = glGenLists( 1 )
        glNewList( torus_list, GL_COMPILE_AND_EXECUTE )

        '' Draw torus
        twopi = 2.0 * PI
        for i = 0 to TORUS_MINOR_RES-1
            glBegin( GL_QUAD_STRIP )
            for j = 0 to TORUS_MAJOR_RES
                for k = 1 to 0 step -1
                    s = (i + k) mod TORUS_MINOR_RES + 0.5
                    t = j mod TORUS_MAJOR_RES

                    '' Calculate point on surface
                    x = (TORUS_MAJOR+TORUS_MINOR*cos(s*twopi/TORUS_MINOR_RES))*cos(t*twopi/TORUS_MAJOR_RES)
                    y = TORUS_MINOR * sin(s * twopi / TORUS_MINOR_RES)
                    z = (TORUS_MAJOR+TORUS_MINOR*cos(s*twopi/TORUS_MINOR_RES))*sin(t*twopi/TORUS_MAJOR_RES)

                    '' Calculate surface normal
                    nx = x - TORUS_MAJOR*cos(t*twopi/TORUS_MAJOR_RES)
                    ny = y
                    nz = z - TORUS_MAJOR*sin(t*twopi/TORUS_MAJOR_RES)
                    scale = 1.0 / sqr( nx*nx + ny*ny + nz*nz )
                    nx *= scale
                    ny *= scale
                    nz *= scale

                    glNormal3f( nx, ny, nz )
                    glVertex3f( x, y, z )
                next
            next
            glEnd()
        next

        '' Stop recording displaylist
        glEndList()
    else
        '' Playback displaylist
        glCallList( torus_list )
    end if
end sub


''========================================================================
'' DrawScene() - Draw the scene (a rotating torus)
''========================================================================

sub DrawScene(  )
	static as GLfloat model_diffuse(0 to 3) = { 1.0, 0.8, 0.8, 1.0 }
	static as GLfloat model_specular(0 to 3) = { 0.6, 0.6, 0.6, 1.0 }
	static as GLfloat model_shininess = 20.0

    glPushMatrix( )
    
    '' Rotate the object
    glRotatef( rot_x*0.5, 1.0, 0.0, 0.0 )
    glRotatef( rot_y*0.5, 0.0, 1.0, 0.0 )
    glRotatef( rot_z*0.5, 0.0, 0.0, 1.0 )

    '' Set model color (used for orthogonal views, lighting disabled)
    glColor4fv( @model_diffuse(0) )

    '' Set model material (used for perspective view, lighting enabled)
    glMaterialfv( GL_FRONT, GL_DIFFUSE, @model_diffuse(0) )
    glMaterialfv( GL_FRONT, GL_SPECULAR, @model_specular(0) )
    glMaterialf(  GL_FRONT, GL_SHININESS, model_shininess )

    '' Draw torus
    DrawTorus()

    glPopMatrix()
end sub


''========================================================================
'' DrawGrid() - Draw a 2D grid (used for orthogonal views)
''========================================================================

sub DrawGrid( byval scale as single, byval steps as integer )
    dim as integer i
    dim as single x, y

    glPushMatrix( )

    '' Set background to some dark bluish grey
    glClearColor( 0.05, 0.05, 0.2, 0.0)
    glClear( GL_COLOR_BUFFER_BIT )

    '' Setup modelview matrix (flat XY view)
    glLoadIdentity( )
    gluLookAt( 0.0, 0.0, 1.0, _
               0.0, 0.0, 0.0, _
               0.0, 1.0, 0.0 )

    '' We don't want to update the Z-buffer
    glDepthMask( GL_FALSE )

    '' Set grid color
    glColor3f( 0.0, 0.5, 0.5 )

    glBegin( GL_LINES )

    '' Horizontal lines
    x = scale * 0.5 * (steps-1)
    y = -scale * 0.5 * (steps-1)
    for i = 0 to steps-1
        glVertex3f( -x, y, 0.0 )
        glVertex3f( x, y, 0.0 )
        y += scale
    next

    '' Vertical lines
    x = -scale * 0.5 * (steps-1)
    y = scale * 0.5 * (steps-1)
    for i = 0 to steps-1
        glVertex3f( x, -y, 0.0 )
        glVertex3f( x, y, 0.0 )
        x += scale
    next

    glEnd()

    '' Enable Z-buffer writing again
    glDepthMask( GL_TRUE )

    glPopMatrix()
end sub


''========================================================================
'' DrawAllViews()
''========================================================================

sub DrawAllViews( )
	static as GLfloat light_position(0 to 3) = { 0.0, 8.0, 8.0, 1.0 }
	static as GLfloat light_diffuse(0 to 3) = { 1.0, 1.0, 1.0, 1.0 }
	static as GLfloat light_specular(0 to 3) = { 1.0, 1.0, 1.0, 1.0 }
	static as GLfloat light_ambient(0 to 3) = { 0.2, 0.2, 0.3, 1.0 }
    dim as double aspect

    '' Calculate aspect of window
    if( height > 0 ) then
        aspect = width_ / height
    else
        aspect = 1.0
    end if

    '' Clear screen
    glClearColor( 0.0, 0.0, 0.0, 0.0 )
    glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT )

    '' Enable scissor test
    glEnable( GL_SCISSOR_TEST )

    '' Enable depth test
    glEnable( GL_DEPTH_TEST )
    glDepthFunc( GL_LEQUAL )


    '' ** ORTHOGONAL VIEWS **

    '' For orthogonal views, use wireframe rendering
    glPolygonMode( GL_FRONT_AND_BACK, GL_LINE )

    '' Enable line anti-aliasing
    glEnable( GL_LINE_SMOOTH )
    glEnable( GL_BLEND )
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA )

    '' Setup orthogonal projection matrix
    glMatrixMode( GL_PROJECTION )
    glLoadIdentity( )
    glOrtho( -3.0*aspect, 3.0*aspect, -3.0, 3.0, 1.0, 50.0 )

    '' Upper left view (TOP VIEW)
    glViewport( 0, height\2, width_\2, height\2 )
    glScissor( 0, height\2, width_\2, height\2 )
    glMatrixMode( GL_MODELVIEW )
    glLoadIdentity()
    gluLookAt( 0.0, 10.0, 1e-3, _  '' Eye-position (above)
               0.0, 0.0, 0.0,   _  '' View-point
               0.0, 1.0, 0.0 )     '' Up-vector
    DrawGrid( 0.5, 12 )
    DrawScene( )

    '' Lower left view (FRONT VIEW)
    glViewport( 0, 0, width_\2, height\2 )
    glScissor( 0, 0, width_\2, height\2 )
    glMatrixMode( GL_MODELVIEW )
    glLoadIdentity( )
    gluLookAt( 0.0, 0.0, 10.0, _   '' Eye-position (in front of)
               0.0, 0.0, 0.0,  _   '' View-point
               0.0, 1.0, 0.0 )     '' Up-vector
    DrawGrid( 0.5, 12 )
    DrawScene()

    '' Lower right view (SIDE VIEW)
    glViewport( width_\2, 0, width_\2, height\2 )
    glScissor( width_\2, 0, width_\2, height\2 )
    glMatrixMode( GL_MODELVIEW )
    glLoadIdentity()
    gluLookAt( 10.0, 0.0, 0.0, _   '' Eye-position (to the right)
               0.0, 0.0, 0.0,  _   '' View-point
               0.0, 1.0, 0.0 )     '' Up-vector
    DrawGrid( 0.5, 12 )
    DrawScene( )

    '' Disable line anti-aliasing
    glDisable( GL_LINE_SMOOTH )
    glDisable( GL_BLEND )


    '' ** PERSPECTIVE VIEW **

    '' For perspective view, use solid rendering
    glPolygonMode( GL_FRONT_AND_BACK, GL_FILL )

    '' Enable face culling (faster rendering)
    glEnable( GL_CULL_FACE )
    glCullFace( GL_BACK )
    glFrontFace( GL_CW )

    '' Setup perspective projection matrix
    glMatrixMode( GL_PROJECTION )
    glLoadIdentity( )
    gluPerspective( 65.0, aspect, 1.0, 50.0 )

    '' Upper right view (PERSPECTIVE VIEW)
    glViewport( width_\2, height\2, width_\2, height\2 )
    glScissor( width_\2, height\2, width_\2, height\2 )
    glMatrixMode( GL_MODELVIEW )
    glLoadIdentity()
    gluLookAt( 3.0, 1.5, 3.0, _    '' Eye-position
               0.0, 0.0, 0.0, _    '' View-point
               0.0, 1.0, 0.0 )     '' Up-vector

    '' Configure and enable light source 1
    glLightfv( GL_LIGHT1, GL_POSITION, @light_position(0) )
    glLightfv( GL_LIGHT1, GL_AMBIENT, @light_ambient(0) )
    glLightfv( GL_LIGHT1, GL_DIFFUSE, @light_diffuse(0) )
    glLightfv( GL_LIGHT1, GL_SPECULAR, @light_specular(0) )
    glEnable( GL_LIGHT1 )
    glEnable( GL_LIGHTING )

    '' Draw scene
    DrawScene( )

    '' Disable lighting
    glDisable( GL_LIGHTING )

    '' Disable face culling
    glDisable( GL_CULL_FACE )

    '' Disable depth test
    glDisable( GL_DEPTH_TEST )

    '' Disable scissor test
    glDisable( GL_SCISSOR_TEST )


    '' Draw a border around the active view
    if( active_view > 0 and active_view <> 2 ) then
        glViewport( 0, 0, width_, height )
        glMatrixMode( GL_PROJECTION )
        glLoadIdentity()
        glOrtho( 0.0, 2.0, 0.0, 2.0, 0.0, 1.0 )
        glMatrixMode( GL_MODELVIEW )
        glLoadIdentity()
        glColor3f( 1.0, 1.0, 0.6 )
        glTranslatef( (active_view-1) and 1, 1-(active_view-1)\2, 0.0 )
        glBegin( GL_LINE_STRIP )
          glVertex2i( 0, 0 )
          glVertex2i( 1, 0 )
          glVertex2i( 1, 1 )
          glVertex2i( 0, 1 )
          glVertex2i( 0, 0 )
        glEnd()
    end if
end sub


''========================================================================
'' WindowSizeFun() - Window size callback function
''========================================================================

sub WindowSizeFun GLFWCALL( byval w as integer, byval h as integer )
    width_  = w
    height = iif( h > 0, h, 1 )
    
    doredraw = TRUE
end sub

''========================================================================
'' MousePosFun() - Mouse position callback function
''========================================================================

sub MousePosFun GLFWCALL ( byval x as integer, byval y as integer )
    '' Depending on which view was selected, rotate around different axes
    select case active_view
        case 1
            rot_x += y - ypos
            rot_z += x - xpos
        case 3
            rot_x += y - ypos
            rot_y += x - xpos
        case 4
            rot_y += x - xpos
            rot_z += y - ypos
        case else
            '' Do nothing for perspective view, or if no view is selected
    end select

    '' Remember mouse position
    xpos = x
    ypos = y
    
    if( active_view <> 0 ) then
    	doredraw = TRUE
    end if 
end sub


''========================================================================
'' MouseButtonFun() - Mouse button callback function
''========================================================================

sub MouseButtonFun GLFWCALL ( byval button as integer, byval action as integer )
    
    '' Button clicked?
    select case button
    case GLFW_MOUSE_BUTTON_LEFT
    	
    	if( action = GLFW_PRESS ) then
        	'' Detect which of the four views was clicked
        	active_view = 1
        	if( xpos >= width_\2 ) then
	            active_view += 1
			end if            
        	if( ypos >= height\2 ) then
            	active_view += 2
        	end if
        	
    	'' Button released?
    	else
        	'' Deselect any previously selected view
        	active_view = 0
        end if
        
        doredraw = TRUE
    
    end select
    
end sub


''========================================================================
'' main()
''========================================================================

    dim as integer running

    '' Initialise GLFW
    glfwInit( )

    '' Open OpenGL window
    if( glfwOpenWindow( 500, 500, 0,0,0,0, 16,0, GLFW_WINDOW ) = 0 ) then
        glfwTerminate()
    	end 0
    end if

    '' Set window title
    glfwSetWindowTitle( "Split view demo" )

    '' Enable sticky keys
    glfwEnable( GLFW_STICKY_KEYS )

    '' Enable mouse cursor (only needed for fullscreen mode)
    glfwEnable( GLFW_MOUSE_CURSOR )

    '' Set callback functions
    glfwSetWindowSizeCallback( @WindowSizeFun )
    glfwSetMousePosCallback( @MousePosFun )
    glfwSetMouseButtonCallback( @MouseButtonFun )

    '' Main loop
    doredraw = TRUE

    do
        if( doredraw ) then
        	doredraw = FALSE
        	
        	'' Draw all views
        	DrawAllViews( )
        	
        else
        
        	'' Idle process
        	glfwSleep( 0.025 )
        	
        end if

        '' Swap buffers
        glfwSwapBuffers( )
        	
        '' Check if the ESC key was pressed or the window was closed
        running = (glfwGetKey( GLFW_KEY_ESC ) = 0) and _
                  (glfwGetWindowParam( GLFW_OPENED ) = 1)
    loop while( running )

    '' Close OpenGL window and terminate GLFW
    glfwTerminate( )

	end 0
