# include "fbcu.bi"

namespace fbc_tests.structs.bitfield_misc

type foo
	f0 as integer
	f1:5 as integer
	f2:20 as integer
	f3:2 as ubyte
end type

private sub test1 cdecl( )
	dim as foo f
	f.f2 = 72
	f.f1 = f.f2

	dim as integer fs = f.f1 = 8, fs2 = f.f2 = 72

	CU_ASSERT( fs )
	CU_ASSERT( fs2 )
end sub

private sub test2 cdecl( )
	dim as foo f
	f.f1 = 8
	f.f2 = 67

	swap f.f1, f.f2

	dim as integer fs = f.f1 = 3, fs2 = f.f2 = 8

	CU_ASSERT( fs )
	CU_ASSERT( fs2 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.structs.bitfield-misc" )
	fbcu.add_test( "1", @test1 )
	fbcu.add_test( "2", @test2 )
end sub

end namespace
