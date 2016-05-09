' TEST_MODE : MULTI_MODULE_TEST

' Test correct implemention of the C/native ABI stack alignment requirements.
' Using asm to check whether the stack is aligned wouldn't check the actual ABI
' without making assumptions, so external C code is used instead.
' All ASSERTS in this file are rather superfluous.

' On x86 and x86_64, GNU/Linux and Darwin require 16 byte alignment, while on
' x86 Windows has 4 byte alignment. x86_64 Windows has 16 byte alignment plus a
' 32 byte "shadow space". ARM has 8 byte alignment.  Also, C runtime calls on
' Darwin aggressively check alignment, while on GNU/Linux bad alignment only
' crashes when instructions like SSE are used.


extern "c"
	declare function alignrequired( byval a as long ) as long
end extern

function check3( arg1 as long ) as long
	dim as integer local1, local2, local3
	alignrequired( 0 )
	return arg1 + 1
end function

function check2( arg1 as long ) as long
	dim as integer local1, local2
	alignrequired( 0 )
	return check3( arg1 ) + 1
end function

function check1( arg1 as long ) as long
	dim as integer local1
	alignrequired( 0 )
	return check2( arg1 ) + 1
end function

function check0( arg1 as long ) as long
	alignrequired( 0 )
	return check1( arg1 ) + 1
end function

function poly( arg1 as long, arg2 as long, arg3 as long, arg4 as long, arg5 as long ) as long
	ASSERT( check0( 0 ) = 4 )
	return arg1 + arg2 + arg3 + arg4 + arg5
end function

type struct
	as integer a, b, c
end type

'' Functions returning structs have a extra hidden parameter, check that is accounted
function ret_struct( arg as struct, recurse as long ) as struct
	ASSERT( check0( 1 ) = 5 )
	if recurse then
		return ret_struct( arg, recurse - 1 )
	end if
	return arg
end function

'' Functions returning strings are also special
function ret_string( arg1 as string ) as string
	ASSERT( check0( 2 ) = 6 )
	return arg1 + "a"
end function



alignrequired( 0 )
alignrequired( alignrequired( 0 ) )
alignrequired( alignrequired( alignrequired( 0 ) ) )

ASSERT( check0( 0 ) = 4 )

ASSERT( poly( check0( 1 ), check0( 2 ), check0( 3 ), check0( 4 ), check0( 5 ) ) = (1+2+3+4+5+5*4) )

dim dummy as struct

dummy = ret_struct( type<struct>( 0 ), 4 )

dummy = ret_struct( ret_struct( ret_struct( type<struct>( 10 ), 0 ), 0 ), 0 )

ASSERT( ret_string( ret_string( ret_string( "A" ) ) ) = "Aaaa" )
