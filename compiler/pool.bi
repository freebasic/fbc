#ifndef __POOL_BI__
#define __POOL_BI__

#include once "list.bi"

type TPOOLITEM
	idx			as integer
end type

type TPOOL
	chunks		as integer
	chunksize   as integer
	chunkTb		as TLIST ptr
end type

declare function poolNew _
	( _
		byval pool as TPOOL ptr, _
		byval items as integer, _
		byval minlen as integer, _
		byval maxlen as integer _
	) as integer


declare sub poolFree _
	( _
		byval pool as TPOOL ptr _
	)

declare function poolNewItem _
	( _
		byval pool as TPOOL ptr, _
		byval len_ as integer _
	) as any ptr

declare sub poolDelItem _
	( _
		byval pool as TPOOL ptr, _
		byval node as any ptr _
	)


#endif '' __POOL_BI__
