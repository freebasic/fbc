#include "fbcu.bi"

namespace fbc_tests.functions.ignore_result

type UdtInRegs
	i as integer
end type

type UdtOnStack
	as integer a, b, c, d
end type

dim shared as integer cdtors
type DtorUdt
	i as integer
	declare destructor( )
end type
destructor DtorUdt( )
	cdtors += 1
end destructor

dim shared as integer cinteger
private function finteger( ) as integer
	cinteger += 1
	function = 1
end function

dim shared as integer csingle
private function fsingle( ) as single
	csingle += 1
	function = 0.0f
end function

dim shared as integer cdouble
private function fdouble( ) as double
	cdouble += 1
	function = 0.0
end function

dim shared as integer canyptr
private function fanyptr( ) as any ptr
	canyptr += 1
	function = 0
end function

dim shared as integer cstring
private function fstring( ) as string
	cstring += 1
	function = "a"
end function

dim shared as integer cudtinregs
private function fudtinregs( ) as UdtInRegs
	cudtinregs += 1
	function = type( 1 )
end function

dim shared as integer cudtonstack
private function fudtonstack( ) as UdtOnStack
	cudtonstack += 1
	function = type( 1, 2, 3, 4 )
end function

dim shared as integer cdtorudt
private function fdtorudt( ) as DtorUdt
	CU_ASSERT( cdtors = 0 )
	cdtorudt += 1
	function = type( 1 )
	CU_ASSERT( cdtors = 1 )
end function

dim shared as integer cbyrefinteger
private function fbyrefinteger( ) byref as integer
	cbyrefinteger += 1
	static i as integer
	function = i
end function

dim shared as integer cbyrefsingle
private function fbyrefsingle( ) byref as single
	cbyrefsingle += 1
	static f as single
	function = f
end function

dim shared as integer cbyrefdouble
private function fbyrefdouble( ) byref as double
	cbyrefdouble += 1
	static d as double
	function = d
end function

dim shared as integer cbyrefanyptr
private function fbyrefanyptr( ) byref as any ptr
	cbyrefanyptr += 1
	static p as any ptr
	function = p
end function

dim shared as integer cbyrefstring
private function fbyrefstring( ) byref as string
	cbyrefstring += 1
	static s as string
	'' Using a non-empty string, in the hopes of detecting any double-frees:
	'' The string will be freed via an atexit() handler, and the caller
	'' shouldn't free() the string when ignoring the result.
	s = "a"
	function = s
end function

dim shared as integer cbyrefudtinregs
private function fbyrefudtinregs( ) byref as UdtInRegs
	cbyrefudtinregs += 1
	static x as UdtInRegs
	function = x
end function

dim shared as integer cbyrefudtonstack
private function fbyrefudtonstack( ) byref as UdtOnStack
	cbyrefudtonstack += 1
	static x as UdtOnStack
	function = x
end function

dim shared as integer cbyrefdtorudt
private function fbyrefdtorudt( ) byref as DtorUdt
	CU_ASSERT( cdtors = 0 )
	cbyrefdtorudt += 1
	static x as DtorUdt
	function = x
	CU_ASSERT( cdtors = 0 )
end function

private sub test cdecl( )
	'' Testing calls ignoring results as statement alone in a line, and
	'' in between ':' statement separators

	dim i as integer
	hex( i )
	: hex( i ) :
	whex( i )
	: whex( i ) :

	CU_ASSERT( cinteger    = 0 ) : finteger( )    : CU_ASSERT( cinteger    = 1 )
	finteger( )
	CU_ASSERT( cinteger    = 2 )
	cuint( finteger( ) )
	CU_ASSERT( cinteger    = 3 )
	CU_ASSERT( csingle     = 0 ) : fsingle( )     : CU_ASSERT( csingle     = 1 )
	CU_ASSERT( cdouble     = 0 ) : fdouble( )     : CU_ASSERT( cdouble     = 1 )
	CU_ASSERT( canyptr     = 0 ) : fanyptr( )     : CU_ASSERT( canyptr     = 1 )
	CU_ASSERT( cstring     = 0 ) : fstring( )     : CU_ASSERT( cstring     = 1 )
	CU_ASSERT( cudtinregs  = 0 ) : fudtinregs( )  : CU_ASSERT( cudtinregs  = 1 )
	CU_ASSERT( cudtonstack = 0 ) : fudtonstack( ) : CU_ASSERT( cudtonstack = 1 )
	CU_ASSERT( cdtors = 0 )
	CU_ASSERT( cdtorudt    = 0 ) : fdtorudt( )    : CU_ASSERT( cdtorudt    = 1 )
	CU_ASSERT( cdtors = 2 )
	cinteger = 0
	csingle = 0
	cdouble = 0
	canyptr = 0
	cstring = 0
	cudtinregs = 0
	cudtonstack = 0
	cdtorudt = 0
	cdtors = 0

	'' Byref results
	CU_ASSERT( cbyrefinteger    = 0 ) : fbyrefinteger( )    : CU_ASSERT( cbyrefinteger    = 1 )
	fbyrefinteger( )
	CU_ASSERT( cbyrefinteger    = 2 )
	cuint( fbyrefinteger( ) )
	CU_ASSERT( cbyrefinteger    = 3 )
	CU_ASSERT( cbyrefsingle     = 0 ) : fbyrefsingle( )     : CU_ASSERT( cbyrefsingle     = 1 )
	CU_ASSERT( cbyrefdouble     = 0 ) : fbyrefdouble( )     : CU_ASSERT( cbyrefdouble     = 1 )
	CU_ASSERT( cbyrefanyptr     = 0 ) : fbyrefanyptr( )     : CU_ASSERT( cbyrefanyptr     = 1 )
	CU_ASSERT( cbyrefstring     = 0 ) : fbyrefstring( )     : CU_ASSERT( cbyrefstring     = 1 )
	CU_ASSERT( cbyrefudtinregs  = 0 ) : fbyrefudtinregs( )  : CU_ASSERT( cbyrefudtinregs  = 1 )
	CU_ASSERT( cbyrefudtonstack = 0 ) : fbyrefudtonstack( ) : CU_ASSERT( cbyrefudtonstack = 1 )
	CU_ASSERT( cdtors = 0 )
	CU_ASSERT( cbyrefdtorudt    = 0 ) : fbyrefdtorudt( )    : CU_ASSERT( cbyrefdtorudt    = 1 )
	CU_ASSERT( cdtors = 0 )
	cbyrefinteger = 0
	cbyrefsingle = 0
	cbyrefdouble = 0
	cbyrefanyptr = 0
	cbyrefstring = 0
	cbyrefudtinregs = 0
	cbyrefudtonstack = 0
	cbyrefdtorudt = 0
	cdtors = 0

	'' Same with function pointers
	dim pinteger         as function( ) as integer          = @finteger
	dim psingle          as function( ) as single           = @fsingle
	dim pdouble          as function( ) as double           = @fdouble
	dim panyptr          as function( ) as any ptr          = @fanyptr
	dim pstring          as function( ) as string           = @fstring
	dim pudtinregs       as function( ) as UdtInRegs        = @fudtinregs
	dim pudtonstack      as function( ) as UdtOnStack       = @fudtonstack
	dim pdtorudt         as function( ) as DtorUdt          = @fdtorudt

	CU_ASSERT( cinteger    = 0 ) : pinteger( )    : CU_ASSERT( cinteger    = 1 )
	pinteger( )
	CU_ASSERT( cinteger    = 2 )
	cuint( pinteger( ) )
	CU_ASSERT( cinteger    = 3 )
	CU_ASSERT( csingle     = 0 ) : psingle( )     : CU_ASSERT( csingle     = 1 )
	CU_ASSERT( cdouble     = 0 ) : pdouble( )     : CU_ASSERT( cdouble     = 1 )
	CU_ASSERT( canyptr     = 0 ) : panyptr( )     : CU_ASSERT( canyptr     = 1 )
	CU_ASSERT( cstring     = 0 ) : pstring( )     : CU_ASSERT( cstring     = 1 )
	CU_ASSERT( cudtinregs  = 0 ) : pudtinregs( )  : CU_ASSERT( cudtinregs  = 1 )
	CU_ASSERT( cudtonstack = 0 ) : pudtonstack( ) : CU_ASSERT( cudtonstack = 1 )
	CU_ASSERT( cdtors = 0 )
	CU_ASSERT( cdtorudt    = 0 ) : pdtorudt( )    : CU_ASSERT( cdtorudt    = 1 )
	CU_ASSERT( cdtors = 2 )
	cinteger = 0
	csingle = 0
	cdouble = 0
	canyptr = 0
	cstring = 0
	cudtinregs = 0
	cudtonstack = 0
	cdtorudt = 0
	cdtors = 0

	'' Byref result function pointers
	dim pbyrefinteger    as function( ) byref as integer    = @fbyrefinteger
	dim pbyrefsingle     as function( ) byref as single     = @fbyrefsingle
	dim pbyrefdouble     as function( ) byref as double     = @fbyrefdouble
	dim pbyrefanyptr     as function( ) byref as any ptr    = @fbyrefanyptr
	dim pbyrefstring     as function( ) byref as string     = @fbyrefstring
	dim pbyrefudtinregs  as function( ) byref as UdtInRegs  = @fbyrefudtinregs
	dim pbyrefudtonstack as function( ) byref as UdtOnStack = @fbyrefudtonstack
	dim pbyrefdtorudt    as function( ) byref as DtorUdt    = @fbyrefdtorudt

	CU_ASSERT( cbyrefinteger    = 0 ) : pbyrefinteger( )    : CU_ASSERT( cbyrefinteger    = 1 )
	pbyrefinteger( )
	CU_ASSERT( cbyrefinteger    = 2 )
	cuint( pbyrefinteger( ) )
	CU_ASSERT( cbyrefinteger    = 3 )
	CU_ASSERT( cbyrefsingle     = 0 ) : pbyrefsingle( )     : CU_ASSERT( cbyrefsingle     = 1 )
	CU_ASSERT( cbyrefdouble     = 0 ) : pbyrefdouble( )     : CU_ASSERT( cbyrefdouble     = 1 )
	CU_ASSERT( cbyrefanyptr     = 0 ) : pbyrefanyptr( )     : CU_ASSERT( cbyrefanyptr     = 1 )
	CU_ASSERT( cbyrefstring     = 0 ) : pbyrefstring( )     : CU_ASSERT( cbyrefstring     = 1 )
	CU_ASSERT( cbyrefudtinregs  = 0 ) : pbyrefudtinregs( )  : CU_ASSERT( cbyrefudtinregs  = 1 )
	CU_ASSERT( cbyrefudtonstack = 0 ) : pbyrefudtonstack( ) : CU_ASSERT( cbyrefudtonstack = 1 )
	CU_ASSERT( cdtors = 0 )
	CU_ASSERT( cbyrefdtorudt    = 0 ) : pbyrefdtorudt( )    : CU_ASSERT( cbyrefdtorudt    = 1 )
	CU_ASSERT( cdtors = 0 )
	cbyrefinteger = 0
	cbyrefsingle = 0
	cbyrefdouble = 0
	cbyrefanyptr = 0
	cbyrefstring = 0
	cbyrefudtinregs = 0
	cbyrefudtonstack = 0
	cbyrefdtorudt = 0
	cdtors = 0
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/functions/ignore-result" )
	fbcu.add_test( "test", @test )
end sub

end namespace
