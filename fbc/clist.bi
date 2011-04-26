#ifndef __CLIST_BI__
#define __CLIST_BI__

#include once "list.bi"

type TCLIST
	list	as TLIST
	head	as TLISTNODE ptr
	tail	as TLISTNODE ptr
end type

declare function clistNew _
	( _
		byval clist as TCLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS = LIST_FLAGS_ALL _
	) as integer

declare function clistFree _
	( _
		byval clist as TCLIST ptr _
	) as integer

declare function clistNextNode _
	( _
		byval clist as TCLIST ptr, _
		byval do_circ as integer = TRUE _
	) as any ptr

#endif '' __LIST_BI__
