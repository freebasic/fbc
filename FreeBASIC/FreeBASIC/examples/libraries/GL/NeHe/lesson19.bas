''
'' This code was created by Jeff Molofee '99 
''
'' If you've found this code useful, please let me know.
''
'' Visit Jeff at http://nehe.gamedev.net/
'' 
'' or for port-specific comments, questions, bugreports etc. 
'' email to leggett@eecs.tulane.edu
''


 
#include once "GL/gl.bi"
#include once "GL/glu.bi"
#include once "SDL/SDL.bi"

'' screen width, height, and bit depth
const SCREEN_WIDTH  = 640
const SCREEN_HEIGHT = 480
const SCREEN_BPP    =  16

'' Setup our booleans
const FALSE = 0
const TRUE  = not FALSE

'' Max number of particles
const MAX_PARTICLES = 1000

'' This is our SDL surface
dim shared as SDL_Surface ptr surface

dim shared as integer rainbow = TRUE    '' Toggle rainbow effect                             

dim shared as single slowdown = 1.0f '' Slow Down Particles                               
dim shared as single xspeed          '' Base X Speed (To Allow Keyboard Direction Of Tail)
dim shared as single yspeed          '' Base Y Speed (To Allow Keyboard Direction Of Tail)
dim shared as single zoom = -20.0f   '' Used To Zoom Out                                  

dim shared as GLuint col = 0        '' Current Color Selection                           
dim shared as GLuint delay          '' Rainbow Effect Delay                              
dim shared as GLuint texture(0)     '' Storage For Our Particle Texture                  

'' Create our particle structure
type particle
    as integer active '' Active (Yes/No)
    as single  life   '' Particle Life  
    as single  fade   '' Fade Speed     

    as single  r      '' Red Value      
    as single  g      '' Green Value    
    as single  b      '' Blue Value     

    as single  x      '' X Position     
    as single  y      '' Y Position     
    as single  z      '' Z Position     

    as single  xi     '' X Direction    
    as single  yi     '' Y Direction    
    as single  zi     '' Z Direction    

    as single  xg     '' X Gravity      
    as single  yg     '' Y Gravity      
    as single  zg     '' Z Gravity      
end type

'' Rainbow of colors
dim shared as GLfloat colors(0 to 11, 0 to 2) = { _
    { 1.0f,  0.5f,  0.5f}, _
	{ 1.0f,  0.75f, 0.5f}, _
	{ 1.0f,  1.0f,  0.5f}, _
	{ 0.75f, 1.0f,  0.5f}, _
    { 0.5f,  1.0f,  0.5f}, _
	{ 0.5f,  1.0f,  0.75f}, _
	{ 0.5f,  1.0f,  1.0f}, _
	{ 0.5f,  0.75f, 1.0f}, _
    { 0.5f,  0.5f,  1.0f}, _
	{ 0.75f, 0.5f,  1.0f}, _
	{ 1.0f,  0.5f,  1.0f}, _
	{ 1.0f,  0.5f,  0.75f} }

'' Our beloved array of particles
dim shared as particle particles(0 to MAX_PARTICLES-1)


'' function to release/destroy our resources and restoring the old desktop
sub Quit( byval returnCode as integer )
    '' Clean up our textures
    glDeleteTextures( 1, @texture(0) )

    '' clean up the window
    SDL_Quit( )

    '' and exit appropriately
	end returnCode
end sub

'' function to load in bitmap as a GL texture
function LoadGLTextures( ) as integer
    '' Status indicator
    dim as integer Status = FALSE

    '' Create storage space for the texture
    dim as SDL_Surface ptr TextureImage(0)

    '' Load The Bitmap, Check For Errors, If Bitmap's Not Found Quit
    TextureImage(0) = SDL_LoadBMP( exepath + "/data/particle.bmp" )
    if( TextureImage(0) <> 0 ) then
	    '' Set the status to true
	    Status = TRUE

	    '' Create The Texture
	    glGenTextures( 1, @texture(0) )

	    '' Typical Texture Generation Using Data From The Bitmap
	    glBindTexture( GL_TEXTURE_2D, texture(0) )

	    '' Generate The Texture
	    glTexImage2D( GL_TEXTURE_2D, 0, 3, TextureImage(0)->w, _
			  		  TextureImage(0)->h, 0, GL_BGR, _
			  		  GL_UNSIGNED_BYTE, TextureImage(0)->pixels )

	    '' Linear Filtering
	    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR )
	    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR )
	end if

    '' Free up any memory we may have used
    if ( TextureImage(0) <> 0 ) then
	    SDL_FreeSurface( TextureImage(0) )
	end if

    return Status
end function


'' function to reset our viewport after a window resize
function resizeWindow( byval wdt as integer, byval hgt as integer ) as integer
    '' Height / width ration
    dim as GLfloat ratio

    '' Protect against a divide by zero
    if ( hgt = 0 ) then _
		hgt = 1

    ratio = wdt / hgt

    '' Setup our viewport.
    glViewport( 0, 0, wdt, hgt )

    '' change to the projection matrix and set our viewing volume.
    glMatrixMode( GL_PROJECTION )
    glLoadIdentity( )

    '' Set our perspective
    gluPerspective( 45.0f, ratio, 0.1f, 200.0f )

    '' Make sure we're chaning the model view and not the projection
    glMatrixMode( GL_MODELVIEW )

    '' Reset The View
    glLoadIdentity( )

    return( TRUE )
end function

'' function to reset one particle to initial state
'' NOTE: I added this function to replace doing the same thing in several
'' places and to also make it easy to move the pressing of numpad keys
'' 2, 4, 6, and 8 into handleKeyPress function.
sub ResetParticle( byval num as integer, byval clr as integer, byval xDir as single, byval yDir as single, byval zDir as single )
    if clr > 11 then clr = 11
    '' Make the particels active
    particles(num).active = TRUE
    '' Give the particles life
    particles(num).life = 1.0f
    '' Random Fade Speed
    particles(num).fade = ( rnd * 100 ) / 1000.0f + 0.003f
    '' Select Red Rainbow Color
    particles(num).r = colors(clr, 0)
    '' Select Green Rainbow Color
    particles(num).g = colors(clr, 1)
    '' Select Blue Rainbow Color
    particles(num).b = colors(clr, 2)
    '' Set the position on the X axis
    particles(num).x = 0.0f
    '' Set the position on the Y axis
    particles(num).y = 0.0f
    '' Set the position on the Z axis
    particles(num).z = 0.0f
    '' Random Speed On X Axis
    particles(num).xi = xDir
    '' Random Speed On Y Axi
    particles(num).yi = yDir
    '' Random Speed On Z Axis
    particles(num).zi = zDir
    '' Set Horizontal Pull To Zero
    particles(num).xg = 0.0f
    '' Set Vertical Pull Downward
    particles(num).yg = -0.8f
    '' Set Pull On Z Axis To Zero
    particles(num).zg = 0.0f

end sub

'' function to handle key press events
sub handleKeyPress( byval keysym as SDL_keysym ptr )
    dim as integer i
    
    select case keysym->sym
	case SDLK_ESCAPE
	    '' ESC key was pressed
	    Quit( 0 )
	
	case SDLK_F1
	    '' F1 key was pressed
	    '' this toggles fullscreen mode
	    
	    SDL_WM_ToggleFullScreen( surface )
	
	case SDLK_KP_PLUS
	    '' '+' key was pressed
	    '' this speeds up the particles
	    
	    if ( slowdown > 1.0f ) then _
			slowdown -= 0.1f
	    
	case SDLK_KP_MINUS
	    '' '-' key was pressed
	    '' this slows down the particles
	    
	    if ( slowdown < 4.0f ) then _
			slowdown += 0.1f
	
	case SDLK_PAGEUP
	    '' PageUp key was pressed
	    '' this zooms into the scene
	    
	    zoom += 0.5f
	
	case SDLK_PAGEDOWN
	    '' PageDown key was pressed
	    '' this zooms out of the scene
	    
	    zoom -= 0.5f
	    
	case SDLK_UP
	    '' Up arrow key was pressed
	    '' this increases the particles' y movement
	    
	    if ( yspeed < 200.0f ) then _
			yspeed += 4
	
	case SDLK_DOWN
	    '' Down arrow key was pressed
	    '' this decreases the particles' y movement
	    
	    if ( yspeed > -200.0f ) then _
			yspeed -= 4
	
	case SDLK_RIGHT
	    '' Right arrow key was pressed
	    '' this increases the particles' x movement
	    
	    if ( xspeed < 200.0f ) then _
			xspeed += 4
	
	case SDLK_LEFT
	    '' Left arrow key was pressed
	    '' this decreases the particles' x movement
	    
	    if ( xspeed > -200.0f ) then _
			xspeed -= 4
	
	case SDLK_KP8
	    '' NumPad 8 key was pressed
	    '' increase particles' y gravity
	    
	    for i = 0 to MAX_PARTICLES-1
			if ( particles(i).yg < 1.5f ) then _
		    	particles(i).yg += 0.5f
		next
	
	case SDLK_KP2
	    '' NumPad 2 key was pressed
	    '' decrease particles' y gravity
	    
	    for i = 0 to MAX_PARTICLES-1
			if ( particles(i).yg > -1.5f ) then _
		    	particles(i).yg -= 0.5f
	    next
	
	case SDLK_KP6
	    '' NumPad 6 key was pressed
	    '' this increases the particles' x gravity
	    
	    for i = 0 to MAX_PARTICLES-1
			if ( particles(i).xg < 1.5f ) then _
		    	particles(i).xg += 0.5f
	    next
	
	case SDLK_KP4
	    '' NumPad 4 key was pressed
	    '' this decreases the particles' y gravity
	    
	    for i = 0 to MAX_PARTICLES-1
			if ( particles(i).xg > -1.5f ) then _
		    	particles(i).xg -= 0.5f
	    next
	
	case SDLK_TAB
	    '' Tab key was pressed
	    '' this resets the particles and makes them re-explode
	    
	    for i = 0 to MAX_PARTICLES-1
		   dim as integer clr = ( i + 1 ) \ ( MAX_PARTICLES \ 12 )
		   dim as single xi, yi, zi
		   xi = ( ( rnd * 50 ) - 26.0f ) * 10.0f
		   yi = ( ( rnd * 50 ) - 25.0f ) * 10.0f
		   zi = yi

		   ResetParticle( i, clr, xi, yi, zi )
		next
	
	case SDLK_RETURN
	    '' Return key was pressed
	    '' this toggles the rainbow color effect
	    
	    rainbow = not rainbow
	    delay = 25
	
	case SDLK_SPACE
	    '' Spacebar was pressed
	    '' this turns off rainbow-ing and manually cycles through colors
	    
	    rainbow = FALSE
	    delay = 0
	    col = ( col + 1 ) mod 12
	end select

end sub

'' general OpenGL initialization function
function initGL( ) as integer
	dim as integer i
    
    '' Load in the texture
    if ( not LoadGLTextures( ) ) then _
		return FALSE

    '' Enable smooth shading
    glShadeModel( GL_SMOOTH )

    '' Set the background black
    glClearColor( 0.0f, 0.0f, 0.0f, 0.0f )

    '' Depth buffer setup
    glClearDepth( 1.0f )

    '' Enables Depth Testing
    glDisable( GL_DEPTH_TEST )

    '' Enable Blending
    glEnable( GL_BLEND )
    '' Type Of Blending To Perform
    glBlendFunc( GL_SRC_ALPHA, GL_ONE )

    '' Really Nice Perspective Calculations
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )
    '' Really Nice Point Smoothing
    glHint( GL_POINT_SMOOTH_HINT, GL_NICEST )

    '' Enable Texture Mapping
    glEnable( GL_TEXTURE_2D )
    '' Select Our Texture
    glBindTexture( GL_TEXTURE_2D, texture(0) )

    '' Reset all the particles
    for i = 0 to MAX_PARTICLES-1
	    dim as integer clr = ( i + 1 ) \ ( MAX_PARTICLES \ 12 )
	    dim as single xi, yi, zi
	    xi = ( ( rnd * 50 ) - 26.0f ) * 10.0f
	    yi = ( ( rnd * 50 ) - 25.0f ) * 10.0f
	    zi =  yi

	    ResetParticle( i, clr, xi, yi, zi )
    next 

    return TRUE 
end function

'' Here goes our drawing code
function drawGLScene( ) as integer
    dim as integer i
    
    '' These are to calculate our fps
    static as GLint T0     = 0
    static as GLint Frames = 0

    '' Clear The Screen And The Depth Buffer
    glClear( GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT )

    glLoadIdentity( )

    '' Modify each of the particles
    for i = 0 to MAX_PARTICLES-1
	    if ( particles(i).active ) then
		    '' Grab Our Particle X Position
		    dim as single x = particles(i).x
		    '' Grab Our Particle Y Position
		    dim as single y = particles(i).y
		    '' Particle Z Position + Zoom
		    dim as single z = particles(i).z + zoom

		    '' Draw The Particle Using Our RGB Values,
		    '' Fade The Particle Based On It's Life
		    
		    glColor4f( particles(i).r, _
			       particles(i).g, _
			       particles(i).b, _
			       particles(i).life )

		    '' Build Quad From A Triangle Strip
		    glBegin( GL_TRIANGLE_STRIP )
		      '' Top Right
		      glTexCoord2d( 1, 1 )
		      glVertex3f( x + 0.5f, y + 0.5f, z )
		      '' Top Left
		      glTexCoord2d( 0, 1 )
		      glVertex3f( x - 0.5f, y + 0.5f, z )
		      '' Bottom Right
		      glTexCoord2d( 1, 0 )
		      glVertex3f( x + 0.5f, y - 0.5f, z )
		      '' Bottom Left
		      glTexCoord2d( 0, 0 )
		      glVertex3f( x - 0.5f, y - 0.5f, z )
		    glEnd( )

		    '' Move On The X Axis By X Speed
		    particles(i).x += particles(i).xi / ( slowdown * 1000 )
		    '' Move On The Y Axis By Y Speed
		    particles(i).y += particles(i).yi / ( slowdown * 1000 )
		    '' Move On The Z Axis By Z Speed
		    particles(i).z += particles(i).zi / ( slowdown * 1000 )

		    '' Take Pull On X Axis Into Account
		    particles(i).xi += particles(i).xg
		    '' Take Pull On Y Axis Into Account
		    particles(i).yi += particles(i).yg
		    '' Take Pull On Z Axis Into Account
		    particles(i).zi += particles(i).zg

		    '' Reduce Particles Life By 'Fade'
		    particles(i).life -= particles(i).fade

		    '' If the particle dies, revive it
		    if ( particles(i).life < 0.0f ) then
			    dim as single xi, yi, zi
			    xi = xspeed + ( ( rnd * 60 ) - 32.0f )
			    yi = yspeed + ( ( rnd * 60 ) - 30.0f )
			    zi = ( ( rnd * 60 ) - 30.0f )
			    ResetParticle( i, col, xi, yi, zi )
            end if
		end if
	next

    '' Draw it to the screen
    SDL_GL_SwapBuffers( )

    '' Gather our frames per second
    Frames += 1
	dim as GLint t = SDL_GetTicks()
	if (t - T0 >= 2500) then
	    dim as GLfloat seconds = (t - T0) / 1000.0
	    dim as GLfloat fps = Frames / seconds
	    SDL_WM_SetCaption( "FPS: " + str( fps ), 0 )
	    T0 = t
	    Frames = 0
	end if

    return TRUE
end function

'' main
    
    '' Flags to pass to SDL_SetVideoMode
    dim as integer videoFlags
    '' main i variable
    dim as integer done = FALSE
    '' used to collect events
    dim as SDL_Event event
    '' this holds some info about our display
    dim as SDL_VideoInfo ptr videoInfo
    '' whether or not the window is active
    dim as integer isActive = TRUE

    '' initialize SDL
    if ( SDL_Init( SDL_INIT_VIDEO ) < 0 ) then
	    print "Video initialization failed: "; *SDL_GetError( )
	    Quit( 1 )
	end if

    '' Fetch the video info
    videoInfo = SDL_GetVideoInfo( )

    if ( videoInfo = 0 ) then
	    print "Video query failed: "; *SDL_GetError( )
	    Quit( 1 )
	end if

    '' the flags to pass to SDL_SetVideoMode                           
    videoFlags   = SDL_OPENGL          '' Enable OpenGL in SDL         
    videoFlags or= SDL_GL_DOUBLEBUFFER '' Enable double buffering      
    videoFlags or= SDL_HWPALETTE       '' Store the palette in hardware
    videoFlags or= SDL_RESIZABLE       '' Enable window resizing       

    '' This checks to see if surfaces can be stored in memory
    if ( videoInfo->hw_available ) then
		videoFlags or= SDL_HWSURFACE
    else
		videoFlags or= SDL_SWSURFACE
	end if

    '' This checks if hardware blits can be done
    if ( videoInfo->blit_hw ) then _
		videoFlags or= SDL_HWACCEL
		
    '' Sets up OpenGL double buffering
    SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 )

    '' get a SDL surface
    surface = SDL_SetVideoMode( SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BPP, videoFlags )

    '' Verify there is a surface
    if ( surface = 0 ) then
	    print "Video mode set failed: "; *SDL_GetError( )
	    Quit( 1 )
	end if

    '' Enable key repeat
    if ( SDL_EnableKeyRepeat( 100, SDL_DEFAULT_REPEAT_INTERVAL ) ) then
	    print "Setting keyboard repeat failed: "; *SDL_GetError( )
	    Quit( 1 )
	end if

    '' initialize OpenGL
    if ( initGL( ) = FALSE ) then
	    print "Could not initialize OpenGL."
	    Quit( 1 )
	end if

    '' Resize the initial window
    resizeWindow( SCREEN_WIDTH, SCREEN_HEIGHT )
    
    drawGLScene( )

    '' wait for events
    do while ( not done )
	    
	    '' handle the events in the queue
	    do while ( SDL_PollEvent( @event ) )
		    
		    select case event.type
			case SDL_ACTIVEEVENT
			    '' Something's happend with our focus
			    '' If we lost focus or we are iconified, we
			    '' shouldn't draw the screen
			    
			    if ( event.active.gain = 0 ) then
					isActive = FALSE
			    else
					isActive = TRUE					
			    end if
		
			case SDL_VIDEORESIZE
			    '' handle resize event
			    'surface = SDL_SetVideoMode( event.resize.w, event.resize.h, 16, videoFlags )
			    'if ( surface = 0 ) then
				 '   print "Could not get a surface after resize: "; *SDL_GetError( )
				  '  Quit( 1 )
				'end if
			    resizeWindow( event.resize.w, event.resize.h )
			    
			case SDL_KEYDOWN
			    '' handle key presses
			    handleKeyPress( @event.key.keysym )
			    			
			case SDL_QUIT_
			    '' handle quit requests
			    done = TRUE
			    
			end select
			    
		loop

	    '' If rainbow coloring is turned on, cycle the colors
	    if ( rainbow and ( delay > 25 ) ) then _
			col = ( col + 1 ) mod 12

	    '' draw the scene
	    if ( isActive ) then
			drawGLScene( )
		else
			SDL_Delay( 25 )
		end if

	    delay += 1
	loop

    '' clean ourselves up and exit
    Quit( 0 )

    '' Should never get here
	end 0
