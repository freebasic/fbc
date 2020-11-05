#ifndef __FBC_INT_ARRAY_BI__ 
#define __FBC_INT_ARRAY_BI__

# if __FB_LANG__ = "qb"
#     error "include not supported in qb dialect"
# endif

namespace FBC

'' declarations must follow ./src/rtlib/fb_array.h

const FB_MAXDIMENSIONS as integer = 8

type FBARRAYDIM
	dim as uinteger elements     '' number of elements
	dim as integer lbound        '' dimension lower bound
	dim as integer ubound        '' dimension upper bound
end type

const FBARRAY_FLAGS_DIMENSIONS = &h0000000f    '' number of entries allocated in dimTb()
const FBARRAY_FLAGS_FIXED_DIM  = &h00000010    '' array has fixed number of dimensions
const FBARRAY_FLAGS_FIXED_LEN  = &h00000020    '' array points to fixed-length memory
const FBARRAY_FLAGS_RESERVED   = &hffffffc0    '' reserved, do not use

type FBARRAY
	dim as any ptr index_ptr     '' @array(0, 0, 0, ... )
	dim as any ptr base_ptr      '' start of memory at array lowest bounds
	dim as uinteger size         '' byte size of allocated contents
	dim as uinteger element_len  '' byte size of single element
	dim as uinteger dimensions   '' number of dimensions
	dim as uinteger flags        '' FBARRAY_FLAGS_*

	'' take care with number of dimensions; fbc may allocate
	'' a smaller descriptor with fewer than FB_MAXDIMENSIONS
	'' in dimTb() if it is known at compile time that they
	'' are never needed.  Always respect number of 
	'' dimensions when accessing dimTb()

	dim as FBARRAYDIM dimTb(0 to FB_MAXDIMENSIONS-1)
end type

extern "rtlib"
	declare function ArrayDescriptorPtr alias "fb_ArrayGetDesc" _
		( array() as any ) as FBC.FBARRAY ptr
	declare function ArrayConstDescriptorPtr alias "fb_ArrayGetDesc" _
		( array() as const any ) as const FBC.FBARRAY ptr
end extern

end namespace

#endif
