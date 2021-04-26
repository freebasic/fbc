# include "fbcunit.bi"

SUITE( fbc_tests.compound.select_const )

	const FALSE = 0
	const TRUE = not FALSE

	''::::
	TEST( case_single_value )

	const TEST_VAL = 100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case as const v
		case TEST_VAL - 5
			ok = FALSE
		case TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 3
			ok = FALSE
		case TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 1
			ok = FALSE
		case TEST_VAL + 1
			ok = FALSE
		case TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3
			ok = FALSE
		case TEST_VAL + 4
			ok = FALSE
		case TEST_VAL + 5
			ok = FALSE
		case TEST_VAL
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_mutiple_value )

	const TEST_VAL = 1000
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case as const v
		case TEST_VAL - 8, TEST_VAL - 9, TEST_VAL - 10, TEST_VAL - 11
			ok = FALSE
		case TEST_VAL - 5, TEST_VAL - 6, TEST_VAL - 7
			ok = FALSE
		case TEST_VAL - 3, TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 1
			ok = FALSE
		case TEST_VAL + 1
			ok = FALSE
		case TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3, TEST_VAL + 4
			ok = FALSE
		case TEST_VAL + 5, TEST_VAL + 6, TEST_VAL + 7
			ok = FALSE
		case TEST_VAL + 8, TEST_VAL + 9, TEST_VAL + 10, TEST_VAL + 11
			ok = FALSE
		case TEST_VAL
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_single_range )

	const TEST_VAL = 100
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case as const v
		case TEST_VAL - 8 to TEST_VAL - 6
			ok = FALSE
		case TEST_VAL - 5 to TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 3 to TEST_VAL - 3
			ok = FALSE
		case TEST_VAL - 2 to TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 10
			ok = FALSE
		case TEST_VAL + 10
			ok = FALSE
		case TEST_VAL + 2 to TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3 to TEST_VAL + 4
			ok = FALSE
		case TEST_VAL + 5 to TEST_VAL + 6
			ok = FALSE
		case TEST_VAL + 7 to TEST_VAL + 8
			ok = FALSE
		case TEST_VAL - 1 to TEST_VAL + 1
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	''::::
	TEST( case_multiple_range )

	const TEST_VAL = 1000
		
		dim as integer v = TEST_VAL
		dim as integer ok
		
		select case as const v
		case TEST_VAL - 15 to TEST_VAL - 14, TEST_VAL - 13 to TEST_VAL - 12
			ok = FALSE
		case TEST_VAL - 11 to TEST_VAL - 10, TEST_VAL - 9 to TEST_VAL - 8
			ok = FALSE
		case TEST_VAL - 7 to TEST_VAL - 6, TEST_VAL - 5 to TEST_VAL - 4
			ok = FALSE
		case TEST_VAL - 2 to TEST_VAL - 2
			ok = FALSE
		case TEST_VAL - 100 
			ok = FALSE
		case TEST_VAL + 100
			ok = FALSE
		case TEST_VAL + 2 to TEST_VAL + 2
			ok = FALSE
		case TEST_VAL + 3 to TEST_VAL + 4, TEST_VAL + 5 to TEST_VAL + 6
			ok = FALSE
		case TEST_VAL + 7 to TEST_VAL + 8, TEST_VAL + 9 to TEST_VAL + 10
			ok = FALSE
		case TEST_VAL + 11 to TEST_VAL + 12, TEST_VAL + 13 to TEST_VAL + 14
			ok = FALSE
		case TEST_VAL - 1 to TEST_VAL + 1
			ok = TRUE
		case else
			ok = FALSE
		end select
		
		CU_ASSERT_EQUAL( ok, TRUE )

	END_TEST

	TEST( emptyJumpTable )
		dim as integer i = 456

		select case as const( i )
		case else
			i = 123
		end select

		CU_ASSERT( i = 123 )
	END_TEST

	TEST( types )

		#macro TEST_TYPE(T, T_MAX_)
		scope
			#define MIN(a, b) iif((a) <= (b), (a), (b))
			#define MAX(a, b) iif((a) >= (b), (a), (b))

			const as T T_MAX = (T_MAX_), T_MIN = not (T_MAX)

			dim v as T
			dim as integer ok

			v = MAX( T_MIN, 0 )

			while v <= MIN( T_MAX - 1, 4097 )

				'' byte or ubyte?
				#if( sizeof(T) = 1 )
					select case as const v
					case 0 to 64
						ok = (v >= 0 and v <= 64)
					case else
						ok = (v < 0 or v > 64)
					end select
				#else
					select case as const v
					case 0 to 4096
						ok = (v >= 0 and v <= 4096)
					case else
						ok = (v < 0 or v > 4096)
					end select
				#endif

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

	END_TEST

	TEST( test64bitCaseValues )
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

	END_TEST

	TEST( maxRange )
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
	END_TEST

	TEST( maxValue )
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

		/' warning will follow, though still works '/
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
	END_TEST

	TEST( boolean_ )
		scope
			var ok = false
			dim i as boolean = false
			select case as const i
			case false
				ok = true
			case true
				CU_FAIL( )
			case else
				CU_FAIL( )
			end select 
			CU_ASSERT( ok )
		end scope

		scope
			var ok = false
			dim i as boolean = true
			select case as const i
			case false
				CU_FAIL( )
			case true
				ok = true
			case else
				CU_FAIL( )
			end select 
			CU_ASSERT( ok )
		end scope
	END_TEST

	TEST( zstringDeref )
		
		dim s as string = "1234567890abcdefghijABCDEFGHIJ" + chr(250)
		dim p as zstring ptr = strptr( s )

		while *p
			select case as const *p
			case asc("A") to asc("Z")
				CU_ASSERT( (*p >= asc("A")) and (*p <= ASC("Z")) )
			case asc("0") to asc("9")
				CU_ASSERT( (*p >= asc("0")) and (*p <= ASC("9")) )
			case 250
				CU_ASSERT( (*p = 250) )
			case else
				CU_ASSERT( not (((*p >= asc("A")) and (*p <= ASC("Z"))) or ((*p >= asc("0")) and (*p <= ASC("9")))) )
			end select
			p += 1
		wend

	END_TEST

END_SUITE
