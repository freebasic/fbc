type FBRTTI
	stdlibvtable	as any ptr
	id		as zstring ptr
	rttibase	as FBRTTI ptr
end type

type FBVTABLE
	nullptr	as any ptr
	rtti	as FBRTTI ptr
end type

type FBOBJECT
	vptr	as any ptr ptr
end type

#define getvptr( p ) (cptr( FBOBJECT ptr, cptr( any ptr, p ) )->vptr)
#define getvtable( p ) cptr( FBVTABLE ptr, getvptr( p ) - 2 )
#define getrttitable( p ) (getvtable( p )->rtti)
#define getrttiid( p ) (getrttitable( p )->id)
