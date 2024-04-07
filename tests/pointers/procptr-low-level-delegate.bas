#include "fbcunit.bi"

SUITE( fbc_tests.pointers.procptr_low_level_delegate )

	dim shared id as string

	#macro decl_delegate( delegateName, typeName, procName, signature... )
		type delegateName
			proc as typeof( procptr( typeName.procName, signature ) )
			indx as integer
			inst as typeName ptr
		end type
	#endmacro

	#macro init_delegate( delegate, instance, typeName, procName, signature... )
		delegate.proc = procptr( typeName.procName )
		delegate.indx = procptr( typeName.procName, virtual )
		delegate.inst = instance
	#endmacro

	#macro call_delegate( delegate, args... )
		__FB_IIF__( _
			__FB_ARG_COUNT__( args ) = 0, _
			iif( _
				delegate.indx >= 0, _
				cptr( typeof(delegate.proc), (*cast( any ptr ptr ptr, delegate.inst ))[delegate.indx] ), _
				delegate.proc _
			)( *(delegate.inst) ), _
			iif( _
				delegate.indx >= 0, _
				cptr( typeof(delegate.proc), (*cast( any ptr ptr ptr, delegate.inst ))[delegate.indx] ), _
				delegate.proc _
			)( *(delegate.inst), args ) _
		)
	#endmacro

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

	'' call member proc of non-virtual
	TEST( non_virtual_1 )
		decl_delegate( Delegate_T_proc1, T, proc1 )
		dim d as Delegate_T_proc1 = any

		dim x as T
		init_delegate( d, @x, T, proc1 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "T.proc1" )
	END_TEST

	'' call member proc of non-virtual
	TEST( non_virtual_2 )
		decl_delegate( Delegate_T_proc2, T, proc2 )
		dim d as Delegate_T_proc2 = any

		dim x as T
		init_delegate( d, @x, T, proc2 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "T.proc2" )
	END_TEST

	/' not allowed
	'' call member proc of base.abstract / derived.abstract
	scope
		decl_delegate( Delegate_B_proc1, B, proc1 )
		dim d as Delegate_B_proc1 = any

		dim x as D1
		init_delegate( d, @x, D1, proc1 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D1.proc1" )
	end scope
	'/

	/' not allowed
	'' call member proc of base.virtual / derived.abstract
	scope
		decl_delegate( Delegate_B_proc2, B, proc2 )
		dim d as Delegate_B_proc2 = any

		dim x as D1
		init_delegate( d, @x, D1, proc2 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D1.proc2" )
	end scope
	'/

	/' not allowed
	'' call member proc of base.non-virtual / derived.abstract
	scope
		decl_delegate( Delegate_B_proc3, B, proc3 )
		dim d as Delegate_B_proc3 = any

		dim x as D1
		init_delegate( d, @x, B, proc3 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D1.proc3" )
	end scope
	'/

	'' call member proc of base.abstract / derived.virtual
	TEST( abstract_virtual_1 )
		decl_delegate( Delegate_B_proc1, B, proc1 )
		dim d as Delegate_B_proc1 = any

		dim x as D2
		init_delegate( d, @x, B, proc1 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D2.proc1" )
	END_TEST

	'' call member proc of base.virtual / derived.virtual
	TEST( virtual_virtual )
		decl_delegate( Delegate_B_proc2, B, proc2 )
		dim d as Delegate_B_proc2 = any

		dim x as D2
		init_delegate( d, @x, B, proc2 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D2.proc2" )
	END_TEST

	'' call member proc of base.non-virtual / derived.virtual
	TEST( non_virtual_virtual )
		decl_delegate( Delegate_D2_proc3, D2, proc3 )
		dim d as Delegate_D2_proc3 = any

		dim x as D2
		init_delegate( d, @x, D2, proc3 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D2.proc3" )
	END_TEST

	'' call member proc of base.abstract / derived.virtual
	TEST( abstract_virtual )
		decl_delegate( Delegate_B_proc1, B, proc1 )
		dim d as Delegate_B_proc1 = any

		dim x as D3
		init_delegate( d, @x, B, proc1 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D3.proc1" )
	END_TEST

	'' call member proc of base.virtual / derived.non-virtual
	TEST( virtual_non_virtual )
		decl_delegate( Delegate_B_proc2, B, proc2 )
		dim d as Delegate_B_proc2 = any

		dim x as D3
		init_delegate( d, @x, B, proc2 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D3.proc2" )
	END_TEST

	'' call member proc of base.non-virtual / derived.non-virtual
	TEST( non_virtual_non_virtual1 )
		decl_delegate( Delegate_B_proc3, B, proc3 )
		dim d as Delegate_B_proc3 = any

		dim x as D3
		init_delegate( d, @x, B, proc3 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "B.proc3" )
	END_TEST

	'' call member proc of base.non-virtual / derived.non-virtual
	TEST( non_virtual_non_virtual2 )
		decl_delegate( Delegate_D3_proc3, D3, proc3 )
		dim d as Delegate_D3_proc3 = any

		dim x as D3
		init_delegate( d, @x, D3, proc3 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D3.proc3" )
	END_TEST

	'' call member proc of base.non-virtual / derived.non-virtual
	TEST( non_virtual_non_virtual3 )
		decl_delegate( Delegate_D3_proc3, D3, proc3 )
		dim d as Delegate_D3_proc3 = any

		dim x as D3
		init_delegate( d, @x, D3, proc3 )

		call_delegate( d )
		CU_ASSERT_EQUAL( id, "D3.proc3" )
	END_TEST

END_SUITE
