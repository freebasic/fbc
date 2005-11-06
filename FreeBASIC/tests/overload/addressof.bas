
enum RESULT
   RESULT_INT
   RESULT_UINT
   RESULT_SINGLE
   RESULT_INTPTR
end enum

type fnint as function ( byval scalar as integer )  as RESULT
type fnuint as function ( byval scalar as uinteger )  as RESULT
type fnsng as function ( byval scalar as single )  as RESULT
type fnintp as function ( byval scalar as integer ptr ) as RESULT

function proc overload ( byval scalar as integer )  as RESULT
   function = RESULT_INT
end function 

function proc ( byval scalar as uinteger )  as RESULT
   function = RESULT_UINT
end function 

function proc ( byval scalar as single )  as RESULT
   function = RESULT_SINGLE
end function 

function proc ( byval scalar as integer ptr ) as RESULT
   function = RESULT_INTPTR
end function

sub test1
	static as fnint fint = @proc
	static as fnuint fuint = @proc
	static as fnsng fsng = @proc
	static as fnintp fintp = @proc

	assert( fint( 0 ) = RESULT_INT )
	assert( fuint( 0 ) = RESULT_UINT )
	assert( fsng( 0 ) = RESULT_SINGLE )
	assert( fintp( 0 ) = RESULT_INTPTR )
end sub

sub test2	
	dim as fnint fint
	dim as fnuint fuint
	dim as fnsng fsng
	dim as fnintp fintp
	
	fint = @proc
	fuint = @proc
	fsng = @proc
	fintp = @proc

	assert( fint( 0 ) = RESULT_INT )
	assert( fuint( 0 ) = RESULT_UINT )
	assert( fsng( 0 ) = RESULT_SINGLE )
	assert( fintp( 0 ) = RESULT_INTPTR )
end sub

	test1
	test2
	
	end 0