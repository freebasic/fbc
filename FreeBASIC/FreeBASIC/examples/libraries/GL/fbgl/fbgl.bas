'' 
'' fbgl - a 2d library for FreeBASIC built on top of OpenGL 
'' by Angelo Mottola, EC++ 2005 
''
'' to build: fbc fbgl.bas -lib
'' 

#include once "fbgl.bi" 
#include once "fbgfx.bi" 
#include once "GL/gl.bi"
#include once "GL/glu.bi" 

	
''::::: 
constructor fbgl _
	( _
		byval w as integer, _
		byval h as integer, _ 
		byval depth as integer,  _
		byval flags as INIT_FLAGS _
	) 
   
	init_cnt += 1
  
	if (depth < 15) then 
		depth = 15 
	end if 
  
	var mode = fb.GFX_OPENGL 
	if (flags and FULLSCREEN) then 
		mode or= fb.GFX_FULLSCREEN 
	end if 
 
	screenres w, h, depth, , mode 
	if (screenptr = 0) then 
		if ((depth = 15) or (depth = 16)) then 
       		depth = 32 
    	else 
       		depth = 16 
    	end if 
    		
    	screenres w, h, depth, , mode 
    	if (screenptr = 0) then 
       		return
    	end if 
	end if 
 
 	glViewport 0, 0, w, h 
	glMatrixMode GL_PROJECTION 
	glLoadIdentity 
	gluOrtho2D -0.325, csng(w) - 0.325, csng(h) - 0.325, -0.325 
	glMatrixMode GL_MODELVIEW 
	glLoadIdentity 

	glShadeModel GL_SMOOTH 
	glDisable GL_DEPTH_TEST 
	glDepthMask GL_FALSE 
	'glHint GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST 
	glClearColor 0.0, 0.0, 0.0, 1.0 
	glClear GL_COLOR_BUFFER_BIT 
	
	glColor4f 1.0, 1.0, 1.0, 1.0 
	color = &hffffff
 
end constructor

''::::: 
destructor fbgl
   
	init_cnt -= 1
	if( init_cnt < 0 ) then
		return
   	end if
   
	screen 0 
	
end destructor


''::::: 
sub fbgl.flip( ) 
	.flip
end sub 

''::::: 
sub fbgl.cls( ) 
	glClear GL_COLOR_BUFFER_BIT 
end sub 

''::::: 
property fbgl.color _
	( _
		byval col as uinteger _
	) 

	if( col <> cur_color ) then
		cur_color = col
		glColor4ub (col shr 16) and &hFF, (col shr 8) and &hFF, col and &hFF, col shr 24
	end if

end property

''::::: 
sub fbgl.hEnableBlend
	if( (stats and STATS_BLEND) = 0 ) then
		stats or= STATS_BLEND
		glEnable GL_BLEND
	end if
end sub

''::::: 
sub fbgl.hDisableBlend
	if( (stats and STATS_BLEND) <> 0 ) then
		stats and= not STATS_BLEND
		glDisable GL_BLEND
	end if
end sub

''::::: 
property fbgl.blendMode _
	( _
		byval mode as BLEND_MODES _
	) 

	select case mode
	case NONE
		glBlendFunc GL_ONE, GL_ZERO
		hDisableBlend( )

	case BLEND_MODES.ALPHA
		glBlendFunc GL_SRC_ALPHA, GL_ZERO
		hEnableBlend( )

	case ANTIALISED
		glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
		hEnableBlend( )
	end select

end property

''::::: 
property fbgl.lineSmooth _
	( _
		byval enable as integer _
	)
		
	if( enable ) then
		glEnable GL_LINE_SMOOTH
	else
		glDisable GL_LINE_SMOOTH
	end if
	
end property

''::::: 
property fbgl.alpha _
	( _
		byval v as single _
	) 
   
	cur_color = (cur_color and &hFFFFFF) or (cuint(v * 255.0) shl 24)
	
end property

''::::: 
sub fbgl.setScale _
	( _
        byval xScale as single, _
        byval yScale as single _
	)
	
    glScalef xScale, yScale, 1.0
	
end sub

''::::: 
property fbgl.rotation _
	( _
		byval angle as single _ 
	)
	
    glRotatef angle, 0, 0, 1.0
	
end property

''::::: 
sub fbgl.setHandle _
	( _
        byval x as single, _
        byval y as single _
	)
	
	glTranslatef x, y, 1.0
	
end sub

''::::: 
sub fbgl.pset _
	( _
		byval x as single, _ 
        byval y as single, _ 
        byval col as uinteger _
	) 
     
    if (col = DEFAULT_COLOR) then 
		col = cur_color 
    end if 

	color = col
      
	glBegin GL_POINTS 
		glVertex2f x, y 
	glEnd 
	
end sub 

''::::: 
sub fbgl.line _
	( _
		byval x1 as single, _ 
        byval y1 as single, _ 
        byval x2 as single, _ 
        byval y2 as single, _ 
        byval col as uinteger, _ 
        byval flags as LINE_FLAGS _
	) 
    
    if (col = DEFAULT_COLOR) then 
		col = cur_color 
    end if 
   
	color = col

    x1 += 0.1625 
    y1 += 0.1625 
    x2 += 0.1625 
    y2 += 0.1625 
    
	select case flags 
	case BOX 
		glBegin GL_LINE_STRIP 
			glVertex2f x1, y1 
			glVertex2f x1, y2 
			glVertex2f x2, y2 
			glVertex2f x2, y1 
			glVertex2f x1, y1 
		glEnd 
       
	case BOXFULL 
		glBegin GL_QUADS 
			glVertex2f x1, y1 
			glVertex2f x1, y2 
			glVertex2f x2, y2 
			glVertex2f x2, y1 
		glEnd 
       
	case else 
		glBegin GL_LINES 
			glVertex2f x1, y1 
			glVertex2f x2, y2 
		glEnd 
      
		glBegin GL_POINTS 
			glVertex2f x2, y2 
		glEnd 
    
	end select 
end sub 

''::::: 
sub fbgl.circle _
	( _
		byval x as single, _ 
        byval y as single, _ 
        byval r as integer, _ 
        byval col as uinteger, _ 
        byval flags as CIRCLE_FLAGS _
	) 
   
	if (col = DEFAULT_COLOR) then 
		col = cur_color 
	end if 

	color = col

	x += 0.1625 
	y += 0.1625 
	
	glPushMatrix
	
	glTranslatef x, y, 0
    
	var quad = gluNewQuadric( )
       
    gluDisk quad, iif( flags and FILLED, 0, r-1 ), r, 60, 1
       
    gluDeleteQuadric quad
       
    glPopMatrix

end sub 


''::::: 
sub fbgl.ellipse _
	( _
		byval x as single, _ 
        byval y as single, _ 
        byval a as integer, _ 
		byval b as integer, _ 
        byval col as uinteger, _ 
        byval flags as CIRCLE_FLAGS _
	) 
   
	if (col = DEFAULT_COLOR) then 
		col = cur_color 
	end if 

	color = col

	x += 0.1625 
	y += 0.1625 
    
	if (flags = FILLED) then 
		glBegin GL_TRIANGLE_FAN 
		glVertex2f x, y 
	else 
		glBegin GL_LINE_STRIP 
	end if 
    
	var points = sqr(a) * sqr(b) / PI 
	var increment = (2.0 * PI) / csng(points) 
	var angle = 0
    
	for i as integer = 0 to points 
		glVertex2f x + (cos(angle) * a), y + (sin(angle) * b) 
		angle += increment 
	next
    
	glEnd 
    
end sub 