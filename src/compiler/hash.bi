#ifndef __HASH_BI__
#define __HASH_BI__

#include once "list.bi"

type HASHITEM
	name        as const zstring ptr      '' shared
	data        as any ptr                '' user data
	prev        as HASHITEM ptr
	next        as HASHITEM ptr
end type

type HASHLIST
	head        as HASHITEM ptr
	tail        as HASHITEM ptr
end type

type THASH
	list        as HASHLIST ptr
	nodes       as integer
	delstr      as integer
end type

declare sub hashInit _
	( _
		byval hash as THASH ptr, _
		byval nodes as integer, _
		byval delstr as integer = FALSE _
	)

declare sub hashEnd(byval hash as THASH ptr)

declare function hashHash _
	( _
		byval symbol as const zstring ptr _
	) as uinteger

declare function hashLookup _
	( _
		byval hash as THASH ptr, _
		byval symbol as const zstring ptr _
	) as any ptr

declare function hashLookupEx _
	( _
		byval hash as THASH ptr, _
		byval symbol as const zstring ptr, _
		byval index as uinteger _
	) as any ptr

declare function hashAdd _
	( _
		byval hash as THASH ptr, _
		byval symbol as const zstring ptr, _
		byval userdata as any ptr, _
		byval index as uinteger _
	) as HASHITEM ptr

declare sub hashDel _
	( _
		byval hash as THASH ptr, _
		byval item as HASHITEM ptr, _
		byval index as uinteger _
	)

type TSTRSETITEM
	as string s
	as integer userdata
	as HASHITEM ptr hashitem
end type

type TSTRSET
	as TLIST list
	as THASH hash
end type

declare sub strsetAdd _
	( _
		byval set as TSTRSET ptr, _
		byref s as string, _
		byval userdata as integer _
	)
declare sub strsetDel(byval set as TSTRSET ptr, byref s as const string)
declare sub strsetCopy(byval target as TSTRSET ptr, byval source as TSTRSET ptr)
declare sub strsetInit(byval set as TSTRSET ptr, byval nodes as integer)
declare sub strsetEnd(byval set as TSTRSET ptr)

#endif '' __HASH_BI__
