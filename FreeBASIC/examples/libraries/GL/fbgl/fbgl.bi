''   version 1.0, by Angelo Mottola, EC++ 2005 
'' 

#ifndef __fbgl_bi__ 
#define __fbgl_bi__ 

#inclib "fbgl"

#include once "fbgfx.bi" 
#include once "GL/gl.bi"
#include once "GL/glu.bi" 

#ifndef TRUE
 #define TRUE -1
 #define FALSE 0
#endif

'' to allow fbgl to be imported (Using fbgl) directly
#ifndef FBGL_PRESERVEKWD
 #undef flip
 #undef cls
 #undef color
 #undef pset
 #undef line
 #undef circle
#endif

namespace fbgl

	const PI = 3.1415923 
	
	const FBGL_DEFAULT_COLOR = &hFEFF00FF 
	
	enum FBGL_INIT
		FBGL_FULLSCREEN     = 1 
	end enum
	
	enum FBGL_LINE
		FBGL_BOX        	= 1 
		FBGL_BOXFULL      	= 2 
	end enum
	
	enum FBGL_CIRCLE
		FBGL_FILLED         = 1 
	end enum
	
	enum FBGL_BLENDER
		BLEND_NONE         	= 0 
		BLEND_ALPHA         = 1 
		BLEND_ANTIALISED    = 2 
	end enum
	
	declare function init _
		( _
			byval w as integer, _ 
	    	byval h as integer, _ 
	        byval depth as integer = 32, _ 
	        byval flags as FBGL_INIT = 0 _
		) as integer 
	
	declare sub shutdown( ) 
	
	declare sub flip( ) 
	
	declare sub cls( ) 
	
	declare sub color _
		( _
			byval col as uinteger _
		) 
	
	declare sub pset _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval col as uinteger = FBGL_DEFAULT_COLOR _
		) 
	
	declare sub line _
		( _
			byval x1 as single, _ 
	        byval y1 as single, _ 
	        byval x2 as single, _ 
	        byval y2 as single, _ 
	        byval col as uinteger = FBGL_DEFAULT_COLOR, _ 
	        byval flags as FBGL_LINE = 0 _
		) 
	
	declare sub circle _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval r as integer, _ 
	        byval col as uinteger = FBGL_DEFAULT_COLOR, _ 
	        byval flags as FBGL_CIRCLE = 0 _
		) 
	
	declare sub ellipse _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval a as integer, _ 
	        byval b as integer, _ 
	        byval col as uinteger = FBGL_DEFAULT_COLOR, _ 
	        byval flags as FBGL_CIRCLE = 0 _
		) 
	
	declare sub setScale _
		( _
	        byval xScale as single, _
	        byval yScale as single _
		)
	
	declare sub setRotation _
		( _
			byval angle as single _ 
		)

	declare sub setHandle _
		( _
	        byval x as single, _
	        byval y as single _
		)

	declare sub setBlend _
		( _
			byval mode as FBGL_BLENDER _
		) 

	declare sub setAlpha _
		( _
			byval alpha as single _
		) 

	declare sub setLineSmooth _
		( _
			byval enable as integer _
		)
	
end namespace

#endif