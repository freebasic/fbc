#ifndef __FBC_INT_ARRAY_BI__ 
#define __FBC_INT_ARRAY_BI__

# if __FB_LANG__ = "fb"
namespace FBC
# endif

	'' declarations must follow ./src/rtlib/fb_array.h

	const FB_MAXDIMENSIONS as integer = 8

	type FBARRAYDIM
		dim as uinteger elements     '' number of elements
		dim as integer lbound        '' dimension lower bound
		dim as integer ubound        '' dimension upper bound
	end type

	type FBARRAY
		dim as any ptr index_ptr     '' @array(0, 0, 0, ... )
		dim as any ptr base_ptr      '' start of memory at array lowest bounds
		dim as uinteger size         '' byte size of allocated contents
		dim as uinteger element_len  '' byte size of single element
		dim as uinteger dimensions   '' number of dimensions
		
		'' take care with number of dimensions; fbc may allocate
		'' a smaller descriptor with fewer than FB_MAXDIMENSIONS
		'' in dimTb() if it is known at compile time that they
		'' are never needed.  Always respsect number of 
		'' dimensions when accessing dimTb()

		dim as FBARRAYDIM dimTb(0 to FB_MAXDIMENSIONS-1)
	end type

# if __FB_LANG__ = "fb"
end namespace
# endif

declare function fb_ArrayGetDesc alias "fb_ArrayGetDesc" _
	  ( array() as any ) as FBC.FBARRAY ptr

#endif
