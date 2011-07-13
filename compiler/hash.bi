#ifndef __HASH_BI__
#define __HASH_BI__

const HASH_INITENTRYNODES	= 1000
const HASH_INITITEMNODES	= HASH_INITENTRYNODES*8

type HASHITEM
	name		as zstring ptr			'' shared
	data		as any ptr				'' user data
	prev		as HASHITEM ptr
	next		as HASHITEM ptr
end type

type HASHLIST
	head		as HASHITEM ptr
	tail		as HASHITEM ptr
end type

type THASH
	list		as HASHLIST ptr
	nodes		as integer
	delstr		as integer
end type

declare sub hashInit _
	( _
		byval initnodes as integer = HASH_INITITEMNODES _
	)

declare sub hashEnd	 _
	( _
	)

declare sub hashNew _
	( _
		byval hash as THASH ptr, _
		byval nodes as integer, _
		byval delstr as integer = FALSE _
	)

declare sub hashFree _
	( _
		byval hash as THASH ptr _
	)

declare function hashHash _
	( _
		byval symbol as zstring ptr _
	) as uinteger

declare function hashLookup _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr _
	) as any ptr

declare function hashLookupEx _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr, _
		byval index as uinteger _
	) as any ptr

declare function hashAdd _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr, _
		byval userdata as any ptr, _
		byval index as uinteger _
	) as HASHITEM ptr

declare sub hashDel _
	( _
		byval hash as THASH ptr, _
		byval item as HASHITEM ptr, _
		byval index as uinteger _
	)

#endif '' __HASH_BI__
