#ifndef __CHTTPSTREAM_BI__
#define __CHTTPSTREAM_BI__

type CHttpStreamCtx as CHttpStreamCtx_

type CHttpStream
	declare constructor	_
		( _
			byval http as CHttp ptr = NULL _
		) 
	
	declare destructor _
		( _
			_
		)
											  
	declare function receive _
		( _
			byval url as zstring ptr, _
			byval referer as zstring ptr = NULL, _
			byval doreset as integer = TRUE _
		) as integer
	
	
	declare function read _
		( _
			byval is_binary as integer = FALSE _
		) as string
	
	declare function send _
		( _
			byval url as zstring ptr, _
			byval data_ as any ptr, _
			byval bytes as integer, _
			byval referer as zstring ptr = NULL, _
			byval doreset as integer = TRUE _
		) as integer

private:
	dim as CHttpStreamCtx ptr ctx = any
end type

#endif