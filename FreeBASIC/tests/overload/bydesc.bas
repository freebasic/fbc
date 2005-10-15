
enum RESULT
   RESULT_ARRAY_INT
   RESULT_ARRAY_UINT
   RESULT_ARRAY_SINGLE
   RESULT_ARRAY_INTPTR
   RESULT_SCALAR_INT
   RESULT_SCALAR_UINT
   RESULT_SCALAR_SINGLE
   RESULT_SCALAR_INTPTR
end enum


function proc overload ( array() as integer ) as RESULT
   function = RESULT_ARRAY_INT
end function

function proc ( array() as uinteger ) as RESULT
   function = RESULT_ARRAY_UINT
end function

function proc ( array() as single ) as RESULT
   function = RESULT_ARRAY_SINGLE
end function

function proc ( array() as integer ptr ) as RESULT
   function = RESULT_ARRAY_INTPTR
end function

function proc ( byval scalar as integer )  as RESULT
   function = RESULT_SCALAR_INT
end function 

function proc ( byval scalar as uinteger )  as RESULT
   function = RESULT_SCALAR_UINT
end function 

function proc ( byval scalar as single )  as RESULT
   function = RESULT_SCALAR_SINGLE
end function 

function proc ( byval scalar as integer ptr ) as RESULT
   function = RESULT_SCALAR_INTPTR
end function

	dim as integer array_int(0), scalar_int
	dim as uinteger array_uint(0), scalar_uint
	dim as single array_single(0), scalar_single
	dim as integer ptr array_intptr(0), scalar_intptr

	assert( proc( array_int() ) = RESULT_ARRAY_INT )
	assert( proc( array_uint() ) = RESULT_ARRAY_UINT )
	assert( proc( array_single() ) = RESULT_ARRAY_SINGLE )
	assert( proc( array_intptr() ) = RESULT_ARRAY_INTPTR )
	
	assert( proc( scalar_int ) = RESULT_SCALAR_INT )
	assert( proc( scalar_uint ) = RESULT_SCALAR_UINT )
	assert( proc( scalar_single ) = RESULT_SCALAR_SINGLE )
	assert( proc( scalar_intptr ) = RESULT_SCALAR_INTPTR )

	end 0