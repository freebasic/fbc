'' one-way list, w/o deallocations
''
'' chng: apr/2005 written [v1ctor]
''


#include once "flist.bi"

sub flistInit _
	( _
		byval flist as TFLIST ptr, _
		byval items as integer, _
		byval itemlen as integer _
	)

	flist->totitems = items
	flist->items    = items

	listInit( @flist->list, items, itemlen + len( TFLISTITEM ), LIST_FLAGS_NONE )

	flist->listtb   = flist->list.tbtail
	flist->index    = 0
	flist->itemtb   = flist->listtb->nodetb
	flist->lastitem = NULL

end sub

sub flistEnd(byval flist as TFLIST ptr)
	flist->totitems = 0
	flist->items    = 0
	flist->index    = 0
	flist->lastitem = NULL
	listEnd( @flist->list )
end sub

'':::::
function flistNewItem _
	( _
		byval flist as TFLIST ptr _
	) as any ptr static

	dim as TFLISTITEM ptr item

	'' alloc new item flist if there are no free items
	if( flist->items <= 0 ) Then

		flist->listtb = flist->listtb->next

		if( flist->listtb = NULL ) then
			flist->items = cunsg(flist->totitems) \ 2
			flist->totitems += flist->items
			listAllocTB( @flist->list, flist->items )
			flist->listtb = flist->list.tbtail
		else
			flist->items = flist->listtb->nodes
		end if

		flist->itemtb = flist->listtb->nodetb
		flist->index = 0
	end if

	''
	item = cast( TFLISTITEM ptr, _
				 cast( byte ptr, flist->itemtb ) + (flist->index * flist->list.nodelen) )
	flist->index += 1
	flist->items -= 1

	''
	if( flist->lastitem <> NULL ) then
		flist->lastitem->next = item
	end if

	flist->lastitem = item
	item->next = NULL

	''
	function = cast( byte ptr, item ) + len( TFLISTITEM )

end function

'':::::
sub flistReset _
	( _
		byval flist as TFLIST ptr _
	) static

	flist->listtb   = flist->list.tbhead
	flist->items    = flist->listtb->nodes
	flist->itemtb   = flist->listtb->nodetb
	flist->index    = 0
	flist->lastitem = NULL

end sub

'':::::
function flistGetHead _
	( _
		byval flist as TFLIST ptr _
	) as any ptr static

	dim as TFLISTITEM ptr item

	item = flist->list.tbhead->nodetb
	if( item = NULL ) then
		function = NULL
	else
		function = cast( byte ptr, item ) + len( TFLISTITEM )
	end if

end function

'':::::
function flistGetNext _
	( _
		byval node as any ptr _
	) as any ptr static

	dim as TFLISTITEM ptr nxt

#ifdef DEBUG
	if( node = NULL ) then
		return NULL
	end if
#endif

	nxt = cast( TFLISTITEM ptr, _
				cast( byte ptr, node ) - len( TFLISTITEM ) )->next

	if( nxt = NULL ) then
		function = NULL
	else
		function = cast( byte ptr, nxt ) + len( TFLISTITEM )
	end if

end function


