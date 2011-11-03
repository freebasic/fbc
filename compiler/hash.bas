'' generic hash tables
''
'' chng: sep/2004 written [v1ctor]
''       jan/2005 updated to use real linked-lists [v1ctor]

#include once "hash.bi"
#include once "hlp.bi"

type HASHITEMPOOL
	as integer refcount
	as TLIST list
end type


declare function 	hashNewItem	( byval list as HASHLIST ptr ) as HASHITEM ptr
declare sub 		hashDelItem	( byval list as HASHLIST ptr, _
								  byval item as HASHITEM ptr )

dim shared as HASHITEMPOOL itempool


private sub lazyInit()
	itempool.refcount += 1
	if (itempool.refcount > 1) then
		exit sub
	end if

	const INITIAL_ITEMS = 8096

	'' allocate the initial item list pool
	listInit(@itempool.list, INITIAL_ITEMS, sizeof(HASHITEM), LIST_FLAGS_NOCLEAR)
end sub

private sub lazyEnd()
	itempool.refcount -= 1
	if (itempool.refcount > 0) then
		exit sub
	end if

	listEnd(@itempool.list)
end sub

sub hashInit _
	( _
		byval hash as THASH ptr, _
		byval nodes as integer, _
		byval delstr as integer _
	)

	lazyInit()

	'' allocate a fixed list of internal linked-lists
	hash->list = xcallocate( nodes * len( HASHLIST ) )
	hash->nodes = nodes
	hash->delstr = delstr

end sub

sub hashEnd(byval hash as THASH ptr)

    dim as integer i = any
    dim as HASHITEM ptr item = any, nxt = any
    dim as HASHLIST ptr list = any

    '' for each item on each list, deallocate it and the name string
    list = hash->list

	if( hash->delstr ) then
    	for i = 0 to hash->nodes-1
			item = list->head
			do while( item <> NULL )
				nxt = item->next

				deallocate( item->name )
				item->name = NULL
				hashDelItem( list, item )

				item = nxt
			loop

			list += 1
		next

	else
    	for i = 0 to hash->nodes-1
			item = list->head
			do while( item <> NULL )
				nxt = item->next

				item->name = NULL
				hashDelItem( list, item )

				item = nxt
			loop

			list += 1
		next

	end if

	deallocate( hash->list )
	hash->list = NULL

	lazyEnd()

end sub

'':::::
function hashHash _
	( _
		byval symbol as zstring ptr _
	) as uinteger

	dim as uinteger index = any
	dim as integer i = any

	index = 0

	for i = 0 to len( *symbol )-1
		index = symbol[i] + (index shl 5) - index
	next

	function = index

end function

''::::::
function hashLookupEx _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr, _
		byval index as uinteger _
	) as any ptr

    dim as HASHITEM ptr item = any
    dim as HASHLIST ptr list = any

    function = NULL

    index mod= hash->nodes

	'' get the start of list
	list = @hash->list[index]
	item = list->head
	if( item = NULL ) then
		exit function
	end if

	'' loop until end of list or if item was found
	do while( item <> NULL )
		if( *item->name = *symbol ) then
			return item->data
		end if
		item = item->next
	loop

end function

''::::::
function hashLookup _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr _
	) as any ptr

    function = hashLookupEx( hash, symbol, hashHash( symbol ) )

end function

''::::::
private function hashNewItem _
	( _
		byval list as HASHLIST ptr _
	) as HASHITEM ptr

	dim as HASHITEM ptr item = any

	'' add a new node
	item = listNewNode( @itempool.list )

	'' add it to the internal linked-list
	if( list->tail <> NULL ) then
		list->tail->next = item
	else
		list->head = item
	end if

	item->prev = list->tail
	item->next = NULL

	list->tail = item

	function = item

end function

''::::::
private sub hashDelItem _
	( _
		byval list as HASHLIST ptr, _
		byval item as HASHITEM ptr _
	)

	dim as HASHITEM ptr prv = any, nxt = any

	''
	if( item = NULL ) Then
		exit sub
	end If

	'' remove from internal linked-list
	prv  = item->prev
	nxt  = item->next
	if( prv <> NULL ) then
		prv->next = nxt
	else
		list->head = nxt
	end If

	if( nxt <> NULL ) then
		nxt->prev = prv
	else
		list->tail = prv
	end if

	'' remove node
	listDelNode( @itempool.list, item )

end sub

''::::::
function hashAdd _
	( _
		byval hash as THASH ptr, _
		byval symbol as zstring ptr, _
		byval userdata as any ptr, _
		byval index as uinteger _
	) as HASHITEM ptr

    dim as HASHITEM ptr item = any

    '' calc hash?
    if( index = INVALID ) then
    	index = hashHash( symbol )
    end if

    index mod= hash->nodes

    '' allocate a new node
    item = hashNewItem( @hash->list[index] )

    function = item
    if( item = NULL ) then
    	exit function
	end if

    '' fill node
    item->name = symbol
    item->data = userdata

end function

''::::::
sub hashDel _
	( _
		byval hash as THASH ptr, _
		byval item as HASHITEM ptr, _
		byval index as uinteger _
	)

    dim as HASHLIST ptr list = any

	if( item = NULL ) then
		exit sub
	end if

	index mod= hash->nodes

	'' get start of list
	list = @hash->list[index]

	''
	if( hash->delstr ) then
		deallocate( item->name )
	end if
	item->name = NULL

	item->data = NULL

	hashDelItem( list, item )

end sub

sub strsetAdd _
	( _
		byval set as TSTRSET ptr, _
		byref s as string, _
		byval userdata as integer _
	)

	dim as TSTRSETITEM ptr i = hashLookup(@set->hash, s)

	'' Already exists?
	if (i) then
		exit sub
	end if

	'' Add new
	i = listNewNode(@set->list)
	i->s = s
	i->userdata = userdata

	'' No need to pass in a NULL pointer or an empty string
	if (len(i->s) = 0) then
		exit sub
	end if

	hashAdd(@set->hash, strptr(i->s), i, hashHash(strptr(i->s)))
end sub

sub strsetCopy(byval target as TSTRSET ptr, byval source as TSTRSET ptr)
	dim as TSTRSETITEM ptr i = listGetHead(@source->list)
	while (i)
		strsetAdd(target, i->s, i->userdata)
		i = listGetNext(i)
	wend
end sub

sub strsetInit(byval set as TSTRSET ptr, byval nodes as integer)
	listInit(@set->list, nodes, sizeof(TSTRSETITEM))
	hashInit(@set->hash, nodes)
end sub

sub strsetEnd(byval set as TSTRSET ptr)
	hashEnd(@set->hash)
	dim as TSTRSETITEM ptr i = listGetHead(@set->list)
	while (i)
		i->s = ""
		i = listGetNext(i)
	wend
	listEnd(@set->list)
end sub
