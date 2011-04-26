'' symbol table module for libraries and library paths - reset on every compilation
''
'' chng: sep/2004 written [v1ctor]
''		 jan/2005 updated to use real linked-lists [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "hash.bi"
#include once "list.bi"

'':::::
sub symbLibInit( ) static

	listNew( @symb.liblist, FB_INITLIBNODES, len( FBS_LIB ), LIST_FLAGS_NOCLEAR )
    hashNew( @symb.libhash, FB_INITLIBNODES )

	listNew( @symb.libpathlist, FB_INITLIBNODES\4, len( FBS_LIB ), LIST_FLAGS_NOCLEAR )
	hashNew( @symb.libpathhash, FB_INITLIBNODES\4 )

end sub

'':::::
sub symbLibEnd( ) static

	hashFree( @symb.libpathhash )
	listFree( @symb.libpathlist )

	hashFree( @symb.libhash )
	listFree( @symb.liblist )

end sub

'':::::
function symbAddLibEx _
	( _
		byval liblist as TLIST ptr, _
		byval libhash as THASH ptr, _
		byval libname as zstring ptr, _
		byval isdefault as integer _
	) as FBS_LIB ptr

    '' check if not already declared
    dim as FBS_LIB ptr l = hashLookup( libhash, libname )
    if( l <> NULL ) then
    	return l
    end if

    l = listNewNode( liblist )
	if( l = NULL ) then
		return NULL
	end if

	''
	l->name	= ZstrAllocate( len( *libname ) )
	*l->name = *libname
	l->isdefault = isdefault

	l->hashindex = hashHash( l->name )
	l->hashitem = hashAdd( libhash, l->name, l, l->hashindex )

	function = l

end function

'':::::
sub symbDelLibEx _
	( _
		byval liblist as TLIST ptr, _
		byval libhash as THASH ptr, _
		byval l as FBS_LIB ptr _
	) static

	if( l = NULL ) then
		exit sub
	end if

	hashDel( libhash, l->hashitem, l->hashindex )

	ZstrFree( l->name )

    listDelNode( liblist, l )

end sub

'':::::
sub symbListLibsEx _
	( _
		byval srclist as TLIST ptr, _
		byval srchash as THASH ptr, _
		byval dstlist as TLIST ptr, _
		byval dsthash as THASH ptr, _
		byval delnodes as integer _
	)

    dim as FBS_LIB ptr node = any, nxt = any

	node = listGetHead( srclist )
	do while( node <> NULL )
        nxt = listGetNext( node )

		symbAddLibEx( dstlist, dsthash, node->name, node->isdefault )

		if( delnodes ) then
			symbDelLibEx( srclist, srchash, node )
		end if

		node = nxt
	loop

end sub


