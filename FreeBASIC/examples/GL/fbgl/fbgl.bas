'' 
'' fbgl - a 2d library for FreeBASIC built on top of OpenGL 
'' by Angelo Mottola, EC++ 2005 
''
'' to build: fbc fbgl.bas -lib
'' 

#define FBGL_PRESERVEKWD
#include once "fbgl.bi" 

namespace fbgl

	enum FBGL_STATS
		FBGL_STATS_BLEND	= &h00000001
	end enum
	
	type context
		init_cnt 	as integer
		stats 		as FBGL_STATS
		cur_color 	as uinteger
	end type
	
	dim shared ctx as context = ( 0, 0, 0 )

	''::::: 
	function init _
		( _
			byval w as integer, _
			byval h as integer, _ 
			byval depth as integer,  _
			byval flags as FBGL_INIT _
		) as integer 
	   
		dim mode as integer 
  
		ctx.init_cnt += 1
   
		if (depth < 15) then 
			depth = 15 
		end if 
   
		mode = GFX_OPENGL 
		if (flags and FBGL_FULLSCREEN) then 
			mode or= GFX_FULLSCREEN 
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
        		return 0
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
		color( &hffffff )
  
		return 1
	end function 
	
	''::::: 
	sub shutdown
	   
		ctx.init_cnt -= 1
		if( ctx.init_cnt < 0 ) then
			return
	   	end if
	   
		screen 0 
	end sub 
	
	
	''::::: 
	sub flip( ) 
		.flip
	end sub 
	
	''::::: 
	sub cls( ) 
		glClear GL_COLOR_BUFFER_BIT 
	end sub 
	
	''::::: 
	sub color _
		( _
			byval col as uinteger _
		) 
	
		if( col <> ctx.cur_color ) then
			ctx.cur_color = col
			glColor4ub (col shr 16) and &hFF, (col shr 8) and &hFF, col and &hFF, col shr 24
		end if
	
	end sub 
	
	''::::: 
	private sub hEnableBlend
		if( (ctx.stats and FBGL_STATS_BLEND) = 0 ) then
			ctx.stats or= FBGL_STATS_BLEND
			glEnable GL_BLEND
		end if
	end sub

	''::::: 
	private sub hDisableBlend
		if( (ctx.stats and FBGL_STATS_BLEND) <> 0 ) then
			ctx.stats and= not FBGL_STATS_BLEND
			glDisable GL_BLEND
		end if
	end sub

	''::::: 
	sub setBlend _
		( _
			byval mode as FBGL_BLENDER _
		) 

		select case mode
		case BLEND_NONE
			glBlendFunc GL_ONE, GL_ZERO
			hDisableBlend( )

		case BLEND_ALPHA
			glBlendFunc GL_SRC_ALPHA, GL_ZERO
			hEnableBlend( )

		case BLEND_ANTIALISED
			glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
			hEnableBlend( )
		end select
	
	end sub

	''::::: 
	sub setLineSmooth _
		( _
			byval enable as integer _
		)
			
		if( enable ) then
			glEnable GL_LINE_SMOOTH
		else
			glDisable GL_LINE_SMOOTH
		end if
		
	end sub
	
	''::::: 
	sub setAlpha _
		( _
			byval alpha as single = 1.0 _
		) 
	   
		dim a as uinteger 
	    
		ctx.cur_color and= &hFFFFFF 
		a = cint(alpha * 255.0) shl 24 
		ctx.cur_color or= a 
		
	end sub 
	
	''::::: 
	sub setScale _
		( _
	        byval xScale as single, _
	        byval yScale as single _
		)
		
	    glScalef xScale, yScale, 1.0
		
	end sub

	''::::: 
	sub setRotation _
		( _
			byval angle as single _ 
		)
		
	    glRotatef angle, 0, 0, 1.0
		
	end sub

	sub setHandle _
		( _
	        byval x as single, _
	        byval y as single _
		)
		
		glTranslatef x, y, 1.0
		
	end sub
	
	''::::: 
	sub pset _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval col as uinteger _
		) 
	     
	    if (col = FBGL_DEFAULT_COLOR) then 
			col = ctx.cur_color 
	    end if 
	
		color( col )
	      
		glBegin GL_POINTS 
			glVertex2f x, y 
		glEnd 
		
	end sub 
	
	''::::: 
	sub line _
		( _
			byval x1 as single, _ 
	        byval y1 as single, _ 
	        byval x2 as single, _ 
	        byval y2 as single, _ 
	        byval col as uinteger, _ 
	        byval flags as FBGL_LINE _
		) 
	    
	    if (col = FBGL_DEFAULT_COLOR) then 
			col = ctx.cur_color 
	    end if 
	   
		color( col )
	
	    x1 += 0.1625 
	    y1 += 0.1625 
	    x2 += 0.1625 
	    y2 += 0.1625 
	    
		select case flags 
		case FBGL_BOX 
			glBegin GL_LINE_STRIP 
				glVertex2f x1, y1 
				glVertex2f x1, y2 
				glVertex2f x2, y2 
				glVertex2f x2, y1 
				glVertex2f x1, y1 
			glEnd 
	       
		case FBGL_BOXFULL 
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
	sub circle _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval r as integer, _ 
	        byval col as uinteger, _ 
	        byval flags as FBGL_CIRCLE _
		) 
	   
		ellipse x, y, r, r, col, flags 
	
	end sub 
	
	
	''::::: 
	sub ellipse _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval a as integer, _ 
			byval b as integer, _ 
	        byval col as uinteger, _ 
	        byval flags as FBGL_CIRCLE _
		) 
	   
		dim points as integer = any, i as integer = any
		dim increment as single = any, angle as single = any
	    
		if (col = FBGL_DEFAULT_COLOR) then 
			col = ctx.cur_color 
		end if 
	
		color( col )   
	
		x += 0.1625 
		y += 0.1625 
	    
		if (flags = FBGL_FILLED) then 
			glBegin GL_TRIANGLE_FAN 
			glVertex2f x, y 
		else 
			glBegin GL_LINE_STRIP 
		end if 
	    
		points = sqr(a) * sqr(b) / PI 
		increment = (2.0 * PI) / csng(points) 
	    
		for i = 0 to points 
			glVertex2f x + (cos(angle) * a), y + (sin(angle) * b) 
			angle += increment 
		next
	    
		glEnd 
	    
	end sub 
	
end namespace