#include once "fbcunit.bi"

SUITE( fbc_tests.pointers.procptr_virtual )

	dim shared id as string

	type T
		__ as integer
		declare sub proc1()
		declare sub proc2()
	end type

	sub T.proc1()
		id = "T.proc1"
	end sub

	sub T.proc2()
		id = "T.proc2"
	end sub

	type B extends object
		declare abstract sub proc1()
		declare virtual  sub proc2()
		declare          sub proc3()
	end type

	sub B.proc2()
		id = "B.proc2"
	end sub

	sub B.proc3()
		id = "B.proc3"
	end sub

	type D1 extends B
		declare abstract sub proc1()
		declare abstract sub proc2()
		declare abstract sub proc3()
	end type

	type D2 extends B
		declare virtual  sub proc1()
		declare virtual  sub proc2()
		declare virtual  sub proc3()
	end type

	sub D2.proc1()
		id = "D2.proc1"
	end sub

	sub D2.proc2()
		id = "D2.proc2"
	end sub

	sub D2.proc3()
		id = "D2.proc3"
	end sub

	type D3 extends B
		declare          sub proc1()
		declare          sub proc2()
		declare          sub proc3()
	end type

	sub D3.proc1()
		id = "D3.proc1"
	end sub

	sub D3.proc2()
		id = "D3.proc2"
	end sub

	sub D3.proc3()
		id = "D3.proc3"
	end sub

	#macro check_null_abstract( typename, member, isnull )
		scope
			var fp = procptr( typename.member )
			CU_ASSERT( iif(isnull, cint(fp)=0, cint(fp)<>0 ) )
		end scope
	#endmacro

	TEST( abstracts )
		'' PROCPTR( UDT.<abstract member> ) needs to return NULL pointer
		check_null_abstract( T, proc1, false )
		check_null_abstract( T, proc2, false )
		check_null_abstract( B, proc1, true )
		check_null_abstract( B, proc2, false )
		check_null_abstract( B, proc3, false )
		check_null_abstract( D1, proc1, true )
		check_null_abstract( D1, proc2, true )
		check_null_abstract( D1, proc3, true )
		check_null_abstract( D2, proc1, false )
		check_null_abstract( D2, proc2, false )
		check_null_abstract( D2, proc3, false )
		check_null_abstract( D3, proc1, false )
		check_null_abstract( D3, proc2, false )
		check_null_abstract( D3, proc3, false )
	END_TEST

	#macro check_virtual_offset( typename, member, value )
		scope
			var fp = procptr( typename.member, virtual )
			CU_ASSERT_EQUAL( value, cint(fp) )
		end scope
	#endmacro

	TEST( offsets )
		const INDEX0     = 0
		const INDEX1     = 1
		const INDEX2     = 2
		const INDEX_NONE = -1

		check_virtual_offset( T, proc1, INDEX_NONE )   '' non-virtual
		check_virtual_offset( T, proc2, INDEX_NONE )   '' non-virtual
		check_virtual_offset( B, proc1, INDEX0 )       '' abstract
		check_virtual_offset( B, proc2, INDEX1 )       '' virtual
		check_virtual_offset( B, proc3, INDEX_NONE )   '' non-virtual
		check_virtual_offset( D1, proc1, INDEX0 )      '' abstract
		check_virtual_offset( D1, proc2, INDEX1 )      '' abstract
		check_virtual_offset( D1, proc3, INDEX2 )      '' abstract
		check_virtual_offset( D2, proc1, INDEX0 )      '' virtual
		check_virtual_offset( D2, proc2, INDEX1 )      '' virtual
		check_virtual_offset( D2, proc3, INDEX2 )      '' virtual
		check_virtual_offset( D3, proc1, INDEX_NONE )  '' non-virtual
		check_virtual_offset( D3, proc2, INDEX_NONE )  '' non-virtual
		check_virtual_offset( D3, proc3, INDEX_NONE )  '' non-virtual
	END_TEST


END_SUITE
