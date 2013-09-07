# include "fbcu.bi"




namespace fbc_tests.compound.select_const

const FALSE = 0
const TRUE = not FALSE

''::::
sub test_single_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
	case TEST - 5
		ok = FALSE
	case TEST - 4
		ok = FALSE
	case TEST - 3
		ok = FALSE
	case TEST - 2
		ok = FALSE
	case TEST - 1
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2
		ok = FALSE
	case TEST + 3
		ok = FALSE
	case TEST + 4
		ok = FALSE
	case TEST + 5
		ok = FALSE
	case TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_single_2 cdecl ( )

const TEST = 1000
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
	case TEST - 8, TEST - 9, TEST - 10, TEST - 11
		ok = FALSE
	case TEST - 5, TEST - 6, TEST - 7
		ok = FALSE
	case TEST - 3, TEST - 4
		ok = FALSE
	case TEST - 2
		ok = FALSE
	case TEST - 1
		ok = FALSE
	case TEST + 1
		ok = FALSE
	case TEST + 2
		ok = FALSE
	case TEST + 3, TEST + 4
		ok = FALSE
	case TEST + 5, TEST + 6, TEST + 7
		ok = FALSE
	case TEST + 8, TEST + 9, TEST + 10, TEST + 11
		ok = FALSE
	case TEST
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_range_1 cdecl ( )

const TEST = 100
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
	case TEST - 8 to TEST - 6
		ok = FALSE
	case TEST - 5 to TEST - 4
		ok = FALSE
	case TEST - 3 to TEST - 3
		ok = FALSE
	case TEST - 2 to TEST - 2
		ok = FALSE
	case TEST - 10
		ok = FALSE
	case TEST + 10
		ok = FALSE
	case TEST + 2 to TEST + 2
		ok = FALSE
	case TEST + 3 to TEST + 4
		ok = FALSE
	case TEST + 5 to TEST + 6
		ok = FALSE
	case TEST + 7 to TEST + 8
		ok = FALSE
	case TEST - 1 to TEST + 1
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

''::::
sub test_range_2 cdecl ( )

const TEST = 1000
	
	dim as integer v = TEST
	dim as integer ok
	
	select case as const v
	case TEST - 15 to TEST - 14, TEST - 13 to TEST - 12
		ok = FALSE
	case TEST - 11 to TEST - 10, TEST - 9 to TEST - 8
		ok = FALSE
	case TEST - 7 to TEST - 6, TEST - 5 to TEST - 4
		ok = FALSE
	case TEST - 2 to TEST - 2
		ok = FALSE
	case TEST - 100 
		ok = FALSE
	case TEST + 100
		ok = FALSE
	case TEST + 2 to TEST + 2
		ok = FALSE
	case TEST + 3 to TEST + 4, TEST + 5 to TEST + 6
		ok = FALSE
	case TEST + 7 to TEST + 8, TEST + 9 to TEST + 10
		ok = FALSE
	case TEST + 11 to TEST + 12, TEST + 13 to TEST + 14
		ok = FALSE
	case TEST - 1 to TEST + 1
		ok = TRUE
	case else
		ok = FALSE
	end select
	
	CU_ASSERT_EQUAL( ok, TRUE )

end sub

sub testEmptyJumpTable cdecl( )
	dim as integer i = 456

	select case as const( i )
	case else
		i = 123
	end select

	CU_ASSERT( i = 123 )
end sub

sub testTypes cdecl()

	#macro TEST_TYPE(T, T_MAX_)
	scope
		#define MIN(a, b) iif((a) <= (b), (a), (b))
		#define MAX(a, b) iif((a) >= (b), (a), (b))

		const as T T_MAX = (T_MAX_), T_MIN = not (T_MAX)

		dim v as T
		dim as integer ok

		v = MAX( T_MIN, 0 )

		while v <= MIN( T_MAX - 1, 4097 )

			select case as const v
			case 0 to 4096
				ok = (v >= 0 and v <= 4096)
			case else
				ok = (v < 0 or v > 4096)
			end select
			CU_ASSERT_EQUAL( ok, TRUE )

			v += 1
		wend

		v = T_MIN
		select case as const v
		case 1
			ok = FALSE
		case else
			ok = TRUE
		end select
		CU_ASSERT_EQUAL( ok, TRUE )

		v = T_MAX
		select case as const v
		case 1
			ok = FALSE
		case else
			ok = TRUE
		end select
		CU_ASSERT_EQUAL( ok, TRUE )

		if T_MIN <= 1 - 1ll shl 32 then
			v = 1 - 1ll shl 32
			select case as const v
			case 1
				ok = FALSE
			case else
				ok = TRUE
			end select
		end if
		CU_ASSERT_EQUAL( ok, TRUE )

		if T_MAX > 1 + 1ll shl 32 then
			v = 1 + 1ll shl 32
			select case as const v
			case 1
				ok = FALSE
			case else
				ok = TRUE
			end select
		end if
		CU_ASSERT_EQUAL( ok, TRUE )

	end scope
	#endmacro

	TEST_TYPE( byte, 127 )
	TEST_TYPE( short, 32767 )
	TEST_TYPE( long, 1 shl 31 - 1 )
	TEST_TYPE( longint, 1ll shl 63 - 1 )
	TEST_TYPE( integer, 1 shl (sizeof(integer) * 8 - 1) - 1 )

	TEST_TYPE( ubyte, 255 )
	TEST_TYPE( ushort, 65535 )
	TEST_TYPE( ulong, 1ull shl 32 - 1 )
	TEST_TYPE( ulongint, (not 0ull) )

	if( sizeof( integer ) = sizeof( longint ) ) then
		TEST_TYPE( integer, 1ll shl 63 - 1 )
		TEST_TYPE( uinteger, (not 0ull) )
	else
		TEST_TYPE( integer, 1 shl 31 - 1 )
		TEST_TYPE( uinteger, (not 0u) )
	end if

end sub

private sub ctor( ) constructor
	fbcu.add_suite("fbc_tests-compound:select_const")
	fbcu.add_test("test single1", @test_single_1)
	fbcu.add_test("test single2", @test_single_2)
	fbcu.add_test("test range1", @test_range_1)
	fbcu.add_test("test range2", @test_range_2)
	fbcu.add_test( "empty jmptb", @testEmptyJumpTable )
	fbcu.add_test( "integer types", @testTypes )
end sub

end namespace
