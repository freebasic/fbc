#ifndef __STACK_BI__
#define __STACK_BI__

#include once "common.bi"

type TSTACKNODE
	prev    as TSTACKNODE ptr
	next    as TSTACKNODE ptr
end type

type TSTACKTB
	next    as TSTACKTB ptr
	nodetb  as TSTACKNODE ptr
	nodes   as integer
end type

type TSTACK
	tbhead  as TSTACKTB ptr
	tbtail  as TSTACKTB ptr
	nodes   as integer
	nodelen as integer
	tos     as TSTACKNODE ptr                   '' top-of-stack
	clear   as integer                          '' clear nodes?
end type

declare function stackNew _
	( _
		byval stk as TSTACK ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval doclear as integer = TRUE _
	) as integer

declare function stackFree _
	( _
		byval stk as TSTACK ptr _
	) as integer

declare function stackPush _
	( _
		byval stk as TSTACK ptr _
	) as any ptr

declare sub stackPop _
	( _
		byval stk as TSTACK ptr _
	)

declare function stackGetTOS _
	( _
		byval stk as TSTACK ptr _
	) as any ptr

#endif '' _STACK_BI__
