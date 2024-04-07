#ifndef __FLIST_BI__
#define __FLIST_BI__

#include once "list.bi"

type TFLISTITEM
	next        as TFLISTITEM ptr
end type

type TFLIST
	totitems    as integer
	items       as integer
	itemtb      as TFLISTITEM ptr
	index       as integer
	lastitem    as TFLISTITEM ptr
	list        as TLIST
	listtb      as TLISTTB ptr
end type

declare sub flistInit _
	( _
		byval flist as TFLIST ptr, _
		byval items as integer, _
		byval itemlen as integer _
	)

declare sub flistEnd(byval flist as TFLIST ptr)

declare function flistNewItem _
	( _
		byval flist as TFLIST ptr _
	) as any ptr

declare sub flistReset _
	( _
		byval flist as TFLIST ptr _
	)

declare function flistGetHead _
	( _
		byval flist as TFLIST ptr _
	) as any ptr

declare function flistGetNext _
	( _
		byval node as any ptr _
	) as any ptr

#endif '' __FLIST_BI__
