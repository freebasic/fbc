''   version 1.0, by Angelo Mottola, EC++ 2005 
'' 

#ifndef __fbgl_bi__ 
#define __fbgl_bi__ 

#inclib "fbgl"

#ifndef TRUE
 #define TRUE -1
 #define FALSE 0
#endif

type fbgl

	const PI = 3.1415923 
	
	const DEFAULT_COLOR = &hFEFF00FF 
	
	enum INIT_FLAGS
		FULLSCREEN     	= 1 
	end enum
	
	enum LINE_FLAGS
		BOX        		= 1 
		BOXFULL      	= 2 
	end enum
	
	enum CIRCLE_FLAGS
		FILLED         	= 1 
	end enum
	
	enum BLEND_MODES
		NONE         	= 0 
		ALPHA         	= 1 
		ANTIALISED    	= 2 
	end enum
	
	declare constructor _
		( _
			byval w as integer, _ 
	    	byval h as integer, _ 
	        byval depth as integer = 32, _ 
	        byval flags as INIT_FLAGS = 0 _
		)
	
	declare destructor( ) 
	
	declare sub flip( ) 
	
	declare sub cls( ) 
	
	declare property color _
		( _
			byval col as uinteger _
		) 
	
	declare sub pset _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval col as uinteger = DEFAULT_COLOR _
		) 
	
	declare sub line _
		( _
			byval x1 as single, _ 
	        byval y1 as single, _ 
	        byval x2 as single, _ 
	        byval y2 as single, _ 
	        byval col as uinteger = DEFAULT_COLOR, _ 
	        byval flags as LINE_FLAGS = 0 _
		) 
	
	declare sub circle _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval r as integer, _ 
	        byval col as uinteger = DEFAULT_COLOR, _ 
	        byval flags as CIRCLE_FLAGS = 0 _
		) 
	
	declare sub ellipse _
		( _
			byval x as single, _ 
	        byval y as single, _ 
	        byval a as integer, _ 
	        byval b as integer, _ 
	        byval col as uinteger = DEFAULT_COLOR, _ 
	        byval flags as CIRCLE_FLAGS = 0 _
		) 
	
	declare sub setScale _
		( _
	        byval x as single, _
	        byval y as single _
		)

	declare property rotation _
		( _
			byval angle as single _ 
		)

	declare sub setHandle _
		( _
	        byval x as single, _
	        byval y as single _
		)

	declare property blendMode _
		( _
			byval mode as BLEND_MODES _
		) 

	declare property alpha _
		( _
			byval v as single _
		) 

	declare property lineSmooth _
		( _
			byval enable as integer _
		)
	
private:
	enum STATS_FLAGS
		STATS_BLEND	= &h00000001
	end enum

	declare sub hEnableBlend _
		( _
		)

	declare sub hDisableBlend _
		( _
		)

	init_cnt 	as integer
	stats 		as STATS_FLAGS
	cur_color 	as uinteger
end type

#endif