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

sub test64bitCaseValues cdecl( )
	scope
		dim i as ulongint = &h100000000ull
		select case as const i
		case &h100000000ull
		case &h100000010ull
			CU_FAIL( )
		case else
			CU_FAIL( )
		end select
	end scope

	scope
		dim i as ulongint = 0
		select case as const i
		case &h100000000ull
			CU_FAIL( )
		case &h100000010ull
			CU_FAIL( )
		end select
	end scope

	scope
		dim i as ulongint = 5
		select case as const i
		case &h100000000ull to &h100000010ull
			CU_FAIL( )
		end select
	end scope

	scope
		dim i as ulongint = &hFFFFFFFFull
		select case as const i
		case &h100000000ull to &h100000010ull
			CU_FAIL( )
		end select
	end scope

	scope
		dim i as ulongint = &h100000011ull
		select case as const i
		case &h100000000ull to &h100000010ull
			CU_FAIL( )
		end select
	end scope

	#macro testCaseOk( value, casevalue )
		scope
			var ok = false
			dim l as ulongint = value
			select case as const l
			case casevalue
				ok = true
			case else
				CU_FAIL( )
			end select
			CU_ASSERT( ok )
		end scope
	#endmacro

	#macro testCaseNok( value, casevalue )
		scope
			var ok = false
			dim l as ulongint = value
			select case as const l
			case casevalue
				CU_FAIL( )
			case else
				ok = true
			end select
			CU_ASSERT( ok )
		end scope
	#endmacro

	 testCaseOk(                  0ull,                  0ull )
	testCaseNok(                  0ull,         &hFFFFFFFFull )
	testCaseNok(                  0ull, &hFFFFFFFF00000000ull )
	testCaseNok(                  0ull, &hFFFFFFFFFFFFFFFFull )
	testCaseNok(         &hFFFFFFFFull,                  0ull )
	 testCaseOk(         &hFFFFFFFFull,         &hFFFFFFFFull )
	testCaseNok(         &hFFFFFFFFull, &hFFFFFFFF00000000ull )
	testCaseNok(         &hFFFFFFFFull, &hFFFFFFFFFFFFFFFFull )
	testCaseNok( &hFFFFFFFF00000000ull,                  0ull )
	testCaseNok( &hFFFFFFFF00000000ull,         &hFFFFFFFFull )
	 testCaseOk( &hFFFFFFFF00000000ull, &hFFFFFFFF00000000ull )
	testCaseNok( &hFFFFFFFF00000000ull, &hFFFFFFFFFFFFFFFFull )
	testCaseNok( &hFFFFFFFFFFFFFFFFull,                  0ull )
	testCaseNok( &hFFFFFFFFFFFFFFFFull,         &hFFFFFFFFull )
	testCaseNok( &hFFFFFFFFFFFFFFFFull, &hFFFFFFFF00000000ull )
	 testCaseOk( &hFFFFFFFFFFFFFFFFull, &hFFFFFFFFFFFFFFFFull )

	testCaseNok(                  0ull, &hFFFFFFFEull to &h100000001ull )
	testCaseNok(                  1ull, &hFFFFFFFEull to &h100000001ull )
	 testCaseOk(         &hFFFFFFFEull, &hFFFFFFFEull to &h100000001ull )
	 testCaseOk(         &hFFFFFFFFull, &hFFFFFFFEull to &h100000001ull )
	 testCaseOk(        &h100000000ull, &hFFFFFFFEull to &h100000001ull )
	 testCaseOk(        &h100000001ull, &hFFFFFFFEull to &h100000001ull )
	testCaseNok( &hFFFFFFFF00000000ull, &hFFFFFFFEull to &h100000001ull )
	testCaseNok( &hFFFFFFFFFFFFFFFFull, &hFFFFFFFEull to &h100000001ull )

	#macro testExactSelect1( testvalue, ok1, ok2, ok3, ok4, okelse )
		scope
			var ok = false
			dim l as ulongint = testvalue
			select case as const l
			case  &hFFFFFFFEull : ok = ok1
			case  &hFFFFFFFFull : ok = ok2
			case &h100000000ull : ok = ok3
			case &h100000001ull : ok = ok4
			case else           : ok = okelse
			end select
			CU_ASSERT( ok )
		end scope
	#endmacro

	testExactSelect1(                  0ull, false, false, false, false,  true )
	testExactSelect1(                  1ull, false, false, false, false,  true )
	testExactSelect1(         &hFFFFFFFDull, false, false, false, false,  true )
	testExactSelect1(         &hFFFFFFFEull,  true, false, false, false, false )
	testExactSelect1(         &hFFFFFFFFull, false,  true, false, false, false )
	testExactSelect1(        &h100000000ull, false, false,  true, false, false )
	testExactSelect1(        &h100000001ull, false, false, false,  true, false )
	testExactSelect1(        &h100000002ull, false, false, false, false,  true )
	testExactSelect1( &hFFFFFFFF00000000ull, false, false, false, false,  true )
	testExactSelect1( &hFFFFFFFFFFFFFFFEull, false, false, false, false,  true )
	testExactSelect1( &hFFFFFFFFFFFFFFFFull, false, false, false, false,  true )

	#macro testExactSelect2( testvalue, ok1, ok2, okelse )
		scope
			var ok = false
			dim l as ulongint = testvalue
			select case as const l
			case &hFFFFFFFFFFFFFFFEull : ok = ok1
			case &hFFFFFFFFFFFFFFFFull : ok = ok2
			case else                  : ok = okelse
			end select
			CU_ASSERT( ok )
		end scope
	#endmacro

	testExactSelect2(                  0ull, false, false,  true )
	testExactSelect2(                  1ull, false, false,  true )
	testExactSelect2(         &hFFFFFFFDull, false, false,  true )
	testExactSelect2(         &hFFFFFFFEull, false, false,  true )
	testExactSelect2(         &hFFFFFFFFull, false, false,  true )
	testExactSelect2(        &h100000000ull, false, false,  true )
	testExactSelect2(        &h100000001ull, false, false,  true )
	testExactSelect2(        &h100000002ull, false, false,  true )
	testExactSelect2( &hFFFFFFFF00000000ull, false, false,  true )
	testExactSelect2( &hFFFFFFFFFFFFFFFEull,  true, false, false )
	testExactSelect2( &hFFFFFFFFFFFFFFFFull, false,  true, false )

end sub

sub testMaxRange cdecl( )
	dim i as uinteger

	i = 0
	select case as const i
	case 0 to 8191
	case else
		CU_FAIL( )
	end select

	i = 8191
	select case as const i
	case 0 to 8191
	case else
		CU_FAIL( )
	end select

	i = 8192
	select case as const i
	case 0 to 8191
		CU_FAIL( )
	end select

	#ifdef __FB_64BIT__
		i = &hFFFFFFFFFFFFFFFFu
	#else
		i = &hFFFFFFFFu
	#endif
	select case as const i
	case 0 to 8191
		CU_FAIL( )
	end select
end sub

sub testMaxValue cdecl( )
	scope
		#ifdef __FB_64BIT__
			var ok = false
			dim i as uinteger = &hFFFFFFFFFFFFFFFFu
			select case as const i
			case &hFFFFFFFFFFFFFFFFu
				ok = true
			case else
				CU_FAIL( )
			end select
			CU_ASSERT( ok )
		#else
			var ok = false
			dim i as uinteger = &hFFFFFFFFu
			select case as const i
			case &hFFFFFFFFu
				ok = true
			case else
				CU_FAIL( )
			end select
			CU_ASSERT( ok )
		#endif
	end scope

	scope
		var ok = false
		dim i as uinteger = -1
		select case as const i
		case -1
			ok = true
		case else
			CU_FAIL( )
		end select
		CU_ASSERT( ok )
	end scope

	scope
		var ok = false
		dim i as ulongint = &hFFFFFFFFFFFFFFFFull
		select case as const i
		case &hFFFFFFFFFFFFFFFFu
			ok = true
		case else
			CU_FAIL( )
		end select
		CU_ASSERT( ok )
	end scope
end sub

private sub ctor( ) constructor
	fbcu.add_suite("fbc_tests.compound.select_const")
	fbcu.add_test("test single1", @test_single_1)
	fbcu.add_test("test single2", @test_single_2)
	fbcu.add_test("test range1", @test_range_1)
	fbcu.add_test("test range2", @test_range_2)
	fbcu.add_test( "empty jmptb", @testEmptyJumpTable )
	fbcu.add_test( "integer types", @testTypes )
	fbcu.add_test( "test64bitCaseValues", @test64bitCaseValues )
	fbcu.add_test( "testMaxRange", @testMaxRange )
	fbcu.add_test( "testMaxValue", @testMaxValue )
end sub

end namespace
