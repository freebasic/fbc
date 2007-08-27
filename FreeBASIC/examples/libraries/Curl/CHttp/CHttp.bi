#ifndef __CHTTP_BI__
#define __CHTTP_BI__

#ifndef NULL
#define NULL 0
#endif

#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif

#inclib "CHttp"
#inclib "curl"

type CHttp as CHttp_

#include once "CHttpStream.bi"
#include once "CHttpForm.bi"

type CHttpCtx as CHttpCtx_

type CHttp_
	declare constructor	_
		( _
		) 
	
	declare destructor _
		( _
		)
	
	declare function post _
		( _
			byval url as zstring ptr, _
			byval form as CHttpForm ptr, _
			byval is_binary as integer = FALSE _
		) as string
	
	declare function getHandle _
		( _
		) as any ptr

private:
	dim as CHttpCtx ptr ctx = any
end type

#endif