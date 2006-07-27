#ifndef __fb_file_bi__
#define __fb_file_bi__

namespace fb.file.search

	type entry
		path	as zstring ptr
		name	as zstring ptr
		serial	as double
	end type

	type CSearch as CSearch_

	enum searchBy
		searchBy_SerialNewer
		searchBy_SerialOlder
		searchBy_SerialSame
	end enum
	
	declare function new _
		( _
			byval root as zstring ptr _
		) as CSearch ptr
		
	declare function delete _
		( _
			byval _this as CSearch ptr _
		) as integer

	declare function byDate _
		( _
			byval _this as CSearch ptr, _
			byval mask as zstring ptr, _
			byval serial as double, _
			byval mode as searchBy = searchBy_SerialNewer _
		) as integer

	declare function getFirst _
		( _
			byval _this as CSearch ptr _
		) as entry ptr
		
	declare function getNext _
		( _
			byval _this as CSearch ptr _
		) as entry ptr

end namespace

#endif '' __fb_file_bi__