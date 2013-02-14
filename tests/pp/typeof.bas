#include "fbcu.bi"

namespace fbc_tests.pp.typeof_

#macro clear_func(__type__)
	sub clear_thing overload ( byref t as __type__ )
		#if typeof(t) = "STRING"
			t = ""
		#else
			t = 0
		#endif
	end sub
#endmacro

clear_func(integer)
clear_func(string)

sub test cdecl( )
	dim as integer i = 69
	dim as string s = "R&E 2007"
	dim as integer ptr                             pi
	dim as integer ptr ptr                         ppi
	dim as integer ptr ptr ptr                     pppi
	dim as integer ptr ptr ptr ptr                 ppppi
	dim as integer ptr ptr ptr ptr ptr             pppppi
	dim as integer ptr ptr ptr ptr ptr ptr         ppppppi
	dim as integer ptr ptr ptr ptr ptr ptr ptr     pppppppi
	dim as integer ptr ptr ptr ptr ptr ptr ptr ptr ppppppppi
	dim as const integer ptr                       pci
	dim as integer const ptr                       cpi = 0
	dim as const integer const ptr                 cpci = 0

	clear_thing(i)
	clear_thing(s)

	CU_ASSERT( i = 0 )
	CU_ASSERT( strptr(s) = NULL )

	'' PP typeof()'s result is upper-cased
	#if typeof( s ) = "string"
		CU_FAIL( )
		i = 1
	#else
		CU_PASS( )
		i = 2
	#endif
	CU_ASSERT( i = 2 )

	i = 0
	#if typeof( s ) = "STRING"
		CU_PASS( )
		i = 1
	#else
		CU_FAIL( )
		i = 2
	#endif
	CU_ASSERT( i = 1 )

	#if typeof( i ) = "INTEGER"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pi ) = "INTEGER PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppi ) = "INTEGER PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pppi ) = "INTEGER PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppppi ) = "INTEGER PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pppppi ) = "INTEGER PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( ppppppppi ) = "INTEGER PTR PTR PTR PTR PTR PTR PTR PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( pci ) = "CONST INTEGER PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( cpi ) = "INTEGER CONST PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif

	#if typeof( cpci ) = "CONST INTEGER CONST PTR"
		CU_PASS( )
	#else
		CU_FAIL( )
	#endif
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/pp/typeof" )
	fbcu.add_test( "typeof() with PP", @test )
end sub

end namespace
