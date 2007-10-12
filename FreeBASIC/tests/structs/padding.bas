# include "fbcu.bi"

namespace fbc_tests.structs.padding

	type S8 field=8
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S4 field=4
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S2 field=2
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S1 field=1
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type
	
	type S
		as ubyte b0
		as ushort a0
		as ubyte b1
		as function( ) as uinteger a1
		as uinteger a2
		as uinteger b3
		as double a3
		as ubyte b4
	end type

sub test_size1 cdecl ()

	const UNPADLEN = sizeof(ubyte) + sizeof(ushort) + sizeof(ubyte) + sizeof(any ptr) + sizeof(uinteger) * 2 + sizeof(double) + sizeof(ubyte)	
	
	CU_ASSERT_EQUAL( sizeof(S1), UNPADLEN )
	CU_ASSERT_EQUAL( sizeof(S2), UNPADLEN + 3 )
	CU_ASSERT_EQUAL( sizeof(S4), UNPADLEN + 7 )
	#ifdef __FB_WIN32__
		CU_ASSERT_EQUAL( sizeof(S8), UNPADLEN + 15 )
		CU_ASSERT_EQUAL( sizeof(S) , UNPADLEN + 15 )
	#else
		CU_ASSERT_EQUAL( sizeof(S8), UNPADLEN + 7 )
		CU_ASSERT_EQUAL( sizeof(S) , UNPADLEN + 7 )
	#endif
end sub

sub test_size2 cdecl ()
	type _S1 field=1
		as ubyte b1
		as ushort s1
		as ushort s2
	end type

	type _S2 field=2
		as ubyte b1
		as ushort s1
		as ushort s2
	end type

	type _S
		as ubyte b1
		as ushort s1
		as ushort s2
	end type
	
	const UNPADLEN = sizeof(ubyte) + sizeof(ushort) * 2
	
	CU_ASSERT_EQUAL( sizeof(_S1), UNPADLEN )
	CU_ASSERT_EQUAL( sizeof(_S2), UNPADLEN + 1 )
	CU_ASSERT_EQUAL( sizeof(_S), UNPADLEN + 1 )

end sub

private sub ctor () constructor

	fbcu.add_suite("tests/structs/padding")
	fbcu.add_test("size1", @test_size1)
	fbcu.add_test("size2", @test_size2)

end sub

end namespace