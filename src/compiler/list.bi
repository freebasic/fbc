#ifndef __LIST_BI__
#define __LIST_BI__

#include once "common.bi"

enum LIST_FLAGS
	LIST_FLAGS_NONE             = &h00000000

	LIST_FLAGS_CLEARNODES       = &h00000001
	LIST_FLAGS_LINKFREENODES    = &h00000002
	LIST_FLAGS_LINKUSEDNODES    = &h00000004

	LIST_FLAGS_CLEAR            = LIST_FLAGS_CLEARNODES or LIST_FLAGS_LINKFREENODES or LIST_FLAGS_LINKUSEDNODES
	LIST_FLAGS_NOCLEAR          = LIST_FLAGS_LINKFREENODES or LIST_FLAGS_LINKUSEDNODES
	LIST_FLAGS_ALL              = &hFFFFFFFF
end enum

type TLISTNODE
	prev    as TLISTNODE ptr
	next    as TLISTNODE ptr
end type

type TLISTTB
	next    as TLISTTB ptr
	nodetb  as any ptr
	nodes   as integer
end type

type TLIST
	tbhead  as TLISTTB ptr
	tbtail  as TLISTTB ptr
	nodes   as integer
	nodelen as integer
	fhead   as TLISTNODE ptr                    '' free list
	head    as any ptr                          '' used list
	tail    as any ptr                          '' /
	flags   as LIST_FLAGS
end type

declare sub listInit _
	( _
		byval list as TLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS = LIST_FLAGS_ALL _
	)

declare sub listEnd(byval list as TLIST ptr)

declare function listNewNode _
	( _
		byval list as TLIST ptr _
	) as any ptr

declare sub listDelNode _
	( _
		byval list as TLIST ptr, _
		byval node as any ptr _
	)

declare sub listAllocTB _
	( _
		byval list as TLIST ptr, _
		byval nodes as integer _
	)

declare function listGetHead _
	( _
		byval list as TLIST ptr _
	) as any ptr

declare function listGetTail _
	( _
		byval list as TLIST ptr _
	) as any ptr

declare function listGetPrev _
	( _
		byval node as any ptr _
	) as any ptr

declare function listGetNext _
	( _
		byval node as any ptr _
	) as any ptr

declare sub strlistAppend(byval list as TLIST ptr, byref s as string)
declare sub strlistInit(byval list as TLIST ptr, byval nodes as integer)

#endif '' __LIST_BI__
