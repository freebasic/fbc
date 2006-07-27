#ifndef __LIST_BI__
#define __LIST_BI__

namespace fb.list

	enum flags
		flags_NONE				= &h00000000
		flags_CLEARNODES		= &h00000001
		flags_LINKFREENODES		= &h00000002
		flags_LINKUSEDNODES		= &h00000004
		flags_NOCLEAR			= flags_LINKFREENODES or flags_LINKUSEDNODES
		flags_ALL 				= &hFFFFFFFF
	end enum
	
	type CList as CList_
	
	declare function new _
		( _
			byval nodes as integer, _
			byval nodelen as integer, _
			byval flags as flags = flags_ALL _
		) as CList ptr
	
	declare function delete _
		( _
			byval _this as CList ptr _
		) as integer
	
	declare function insert _
		( _
			byval _this as CList ptr _
		) as any ptr
	
	declare sub remove	_
		( _
			byval _this as CList ptr, _
			byval node as any ptr _
		)
	
	declare function getHead _
		( _
			byval _this as CList ptr _
		) as any ptr
	
	declare function getTail _
		( _
			byval _this as CList ptr _
		) as any ptr
	
	declare function getPrev _	
		( _
			byval node as any ptr _
		) as any ptr
	
	declare function getNext _
		( _
			byval node as any ptr _
		) as any ptr

end namespace

#endif '' __LIST_BI__
