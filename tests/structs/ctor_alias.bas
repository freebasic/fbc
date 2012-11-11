# include "fbcu.bi"

namespace fbc_tests.structs.ctor_alias

namespace testCdecl
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

	private sub test cdecl( )
		CU_ASSERT( inits = 0 )
		CU_ASSERT( cleanups = 0 )

		scope
			dim x as UDT

			CU_ASSERT( inits = 1 )
			CU_ASSERT( cleanups = 0 )
		end scope

		CU_ASSERT( inits = 1 )
		CU_ASSERT( cleanups = 1 )
	end sub
end namespace

namespace testStdcall
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

	private sub test cdecl( )
		CU_ASSERT( inits = 0 )
		CU_ASSERT( cleanups = 0 )

		scope
			dim x as UDT

			CU_ASSERT( inits = 1 )
			CU_ASSERT( cleanups = 0 )
		end scope

		CU_ASSERT( inits = 1 )
		CU_ASSERT( cleanups = 1 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/ctor-alias" )
	fbcu.add_test( "cdecl", @testCdecl.test )
	fbcu.add_test( "stdcall", @testStdcall.test )
end sub

end namespace
