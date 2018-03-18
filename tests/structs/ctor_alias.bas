#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_alias )

	TEST_GROUP( testCdecl )
		dim shared as integer inits, cleanups

		type UDT
			i as integer

			declare sub init cdecl alias "init"( )
			declare constructor cdecl alias "init"( )

			declare sub cleanup cdecl alias "cleanup"( )
			declare destructor cdecl alias "cleanup"( )
		end type

		sub UDT.init cdecl alias "init"( )
			inits += 1
		end sub

		sub UDT.cleanup cdecl alias "cleanup"( )
			cleanups += 1
		end sub

		TEST( default )
			CU_ASSERT( inits = 0 )
			CU_ASSERT( cleanups = 0 )

			scope
				dim x as UDT

				CU_ASSERT( inits = 1 )
				CU_ASSERT( cleanups = 0 )
			end scope

			CU_ASSERT( inits = 1 )
			CU_ASSERT( cleanups = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( testStdcall )
		dim shared as integer inits, cleanups

		type UDT
			i as integer

			declare sub init stdcall alias "init"( )
			declare constructor stdcall alias "init"( )

			declare sub cleanup stdcall alias "cleanup"( )
			declare destructor stdcall alias "cleanup"( )
		end type

		sub UDT.init stdcall alias "init"( )
			inits += 1
		end sub

		sub UDT.cleanup stdcall alias "cleanup"( )
			cleanups += 1
		end sub

		TEST( default )
			CU_ASSERT( inits = 0 )
			CU_ASSERT( cleanups = 0 )

			scope
				dim x as UDT

				CU_ASSERT( inits = 1 )
				CU_ASSERT( cleanups = 0 )
			end scope

			CU_ASSERT( inits = 1 )
			CU_ASSERT( cleanups = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
