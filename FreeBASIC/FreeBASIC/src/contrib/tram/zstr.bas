#include once "zstr.bi"

namespace fb.zstr

	'':::::
	sub del _
		( _		
			byval s as zstring ptr _
		) 
		
		if( s <> 0 ) then
			deallocate( s )
		end if
		
	end sub
	
	'':::::
	function dup _
		( _		
			byval s as zstring ptr _
		) as zstring ptr
		
		dim as zstring ptr dst
		
		dst = allocate( len( *s ) + 1 )
		*dst = *s
		
		function = dst
	
	end function
	
end namespace
	
