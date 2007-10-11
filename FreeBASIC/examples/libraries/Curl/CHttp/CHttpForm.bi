#ifndef __CHTTPFORM_BI__
#define __CHTTPFORM_BI__

type CHttpFormCtx as CHttpFormCtx_

type CHttpForm
	declare constructor	_
		( _
		)
	
	declare destructor _
		( _
		)
												  	  
	declare function add _
		( _
			byval name_ as zstring ptr, _
			byval value as zstring ptr, _
			byval _type as zstring ptr = NULL _
		) as integer
	
	declare function add _
		( _
			byval name_ as zstring ptr, _
			byval value as integer _
		) as integer
	
	declare function getHandle _
		( _
		_
		) as any ptr

private:
	dim as CHttpFormCtx ptr ctx = any
end type

#endif