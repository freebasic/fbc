'' circular list
''
'' chng: jan/2007 written [v1ctor]
''


#include once "clist.bi"

'':::::
function clistNew _
	( _
		byval clist as TCLIST ptr, _
		byval nodes as integer, _
		byval nodelen as integer, _
		byval flags as LIST_FLAGS = LIST_FLAGS_ALL _
	) as integer

	function = listNew( @clist->list, _
						nodes, _
						nodelen, _
						flags or LIST_FLAGS_LINKFREENODES )

	clist->head = clist->list.fhead

end function

'':::::
function clistFree _
	( _
		byval clist as TCLIST ptr _
	) as integer

	clist->head = NULL

	function = listFree( @clist->list )

end function

'':::::
function clistNextNode _
	( _
		byval clist as TCLIST ptr _
	) as any ptr

	dim as TLISTNODE ptr node = any

	if( clist->head = NULL ) then
		node = clist->list.tbhead->nodetb
	else
		node = clist->head
	end if

	function = cast( byte ptr, node ) + len( TLISTNODE )

	clist->head = node->next

end function
