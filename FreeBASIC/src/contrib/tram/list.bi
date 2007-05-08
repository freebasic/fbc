#ifndef __CLIST_BI__
#define __CLIST_BI__

namespace fb

	type CListCtx as CListCtx_

	type CList

		enum flags
			flags_NONE				= &h00000000
			flags_CLEARNODES		= &h00000001
			flags_LINKFREENODES		= &h00000002
			flags_LINKUSEDNODES		= &h00000004
			flags_NOCLEAR			= flags_LINKFREENODES or flags_LINKUSEDNODES
			flags_ALL 				= &hFFFFFFFF
		end enum
		
		declare constructor _
			( _
				byval nodes as integer, _
				byval nodelen as integer, _
				byval flags as flags = flags_ALL _
			)
		
		declare destructor _
			( _
			) 
		
		declare function insert _
			( _
			) as any ptr
		
		declare sub remove	_
			( _
				byval node as any ptr _
			)
		
		declare function getHead _
			( _
			) as any ptr
		
		declare function getTail _
			( _
			) as any ptr
		
		declare function getPrev _	
			( _
				byval node as any ptr _
			) as any ptr
		
		declare function getNext _
			( _
				byval node as any ptr _
			) as any ptr
	
		
		dim ctx as CListCtx ptr
	end type

end namespace

#endif '' __CLIST_BI__
