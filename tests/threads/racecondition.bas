#include "fbcunit.bi"

'' !!! TODO !!! does dos port support threads or no?

#ifndef __FB_DOS__

SUITE( fbc_tests.threads.racecondition )

	TEST_GROUP( multiplethreads )
		const NUM_THREADS = 100

		declare sub cb( byval i as any ptr )

		TEST( test_proc )
			dim htb(0 to NUM_THREADS-1) as any ptr
			dim i as integer

			randomize timer

			for i = 0 to NUM_THREADS-1
				htb(i) = threadcreate( @cb, cast(any ptr, i) )
				if( htb(i) = 0 ) then
					CU_FAIL_FATAL( "error:" & i )
					end
				end if
			next i

			for i = 0 to NUM_THREADS-1
				CU_PRINT( "waiting:" & i )
				threadwait( htb(i) )
			next

			CU_PRINT( "Exiting.." )
			sleep 1000
		END_TEST

		sub cb( byval i as any ptr )
			sleep rnd * 100
			CU_PRINT( "ending:" & i )
		end sub

	END_TEST_GROUP

	'' SELECT AS CONST temp var
	TEST_GROUP( tempvarSelectConst )
		'' The temp var used by SELECT CASE AS CONST was made STATIC due to
		'' the parent proc having STATICLOCALS. This could cause race conditions
		'' with multiple threads running the same SELECT...

		sub f1( byval userdata as any ptr ) static

			#macro check( N )
				case N
					if( (i mod 100) <> N ) then
						CU_FAIL( "bad, i = " + str( i ) + ", i mod 100 = " + str( i mod 100 ) )
					end if
			#endmacro

			for i as integer = 0 to 999999
				select case as const( i mod 100 )
				check( 0 )
				check( 1 )
				check( 2 )
				check( 3 )
				check( 4 )
				check( 5 )
				check( 6 )
				check( 7 )
				check( 8 )
				check( 9 )
				check( 10 )
				check( 11 )
				check( 12 )
				check( 13 )
				check( 14 )
				check( 15 )
				check( 16 )
				check( 17 )
				check( 18 )
				check( 19 )
				check( 20 )
				check( 21 )
				check( 22 )
				check( 23 )
				check( 24 )
				check( 25 )
				check( 26 )
				check( 27 )
				check( 28 )
				check( 29 )
				check( 30 )
				check( 31 )
				check( 32 )
				check( 33 )
				check( 34 )
				check( 35 )
				check( 36 )
				check( 37 )
				check( 38 )
				check( 39 )
				check( 40 )
				check( 41 )
				check( 42 )
				check( 43 )
				check( 44 )
				check( 45 )
				check( 46 )
				check( 47 )
				check( 48 )
				check( 49 )
				check( 50 )
				check( 51 )
				check( 52 )
				check( 53 )
				check( 54 )
				check( 55 )
				check( 56 )
				check( 57 )
				check( 58 )
				check( 59 )
				check( 60 )
				check( 61 )
				check( 62 )
				check( 63 )
				check( 64 )
				check( 65 )
				check( 66 )
				check( 67 )
				check( 68 )
				check( 69 )
				check( 70 )
				check( 71 )
				check( 72 )
				check( 73 )
				check( 74 )
				check( 75 )
				check( 76 )
				check( 77 )
				check( 78 )
				check( 79 )
				check( 80 )
				check( 81 )
				check( 82 )
				check( 83 )
				check( 84 )
				check( 85 )
				check( 86 )
				check( 87 )
				check( 88 )
				check( 89 )
				check( 90 )
				check( 91 )
				check( 92 )
				check( 93 )
				check( 94 )
				check( 95 )
				check( 96 )
				check( 97 )
				check( 98 )
				check( 99 )

				case else
					CU_FAIL( )
				end select
			next
		end sub

		TEST( default )
			dim id(0 to 3) as any ptr

			for i as integer = lbound( id ) to ubound( id )
				id(i) = threadcreate( @f1 )
			next

			for i as integer = lbound( id ) to ubound( id )
				threadwait( id(i) )
			next
		END_TEST
	END_TEST_GROUP

END_SUITE

#endif '' !defined(__FB_DOS__)
