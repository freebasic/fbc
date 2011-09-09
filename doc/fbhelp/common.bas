
#include once "common.bi"

public function FixPath( byval pathname as zstring ptr ) as string

	if( instr( "\/", right(*pathname, 1) ) = 0 ) then
#ifdef __FB_LINUX__
		return *pathname + "/"
#else
		return *pathname + "\"
#endif
	end if
	
end function