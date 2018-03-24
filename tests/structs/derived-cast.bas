#include "fbcunit.bi"

SUITE( fbc_tests.structs.derived_cast )

	type T1
		as integer a
		as string s
		declare constructor()
	end type

	type T2 extends T1
		as integer b
		as string s
		declare constructor()
	end type

	type T3 extends T2
		as integer c
		as string s
		declare constructor()
	end type

	constructor T1()
		this.a = 111
		this.s = "one"
	end constructor

	constructor T2()
		this.b = 222
		this.s = "two"
	end constructor

	constructor T3()
		this.c = 333
		this.s = "three"
	end constructor

	#macro checkVarT1(x1)
		CU_ASSERT(x1.a = 111)
		CU_ASSERT(x1.s = "one")
	#endmacro

	#macro checkVarT2(x2)
		CU_ASSERT(x2.a = 111)
		CU_ASSERT(x2.b = 222)
		CU_ASSERT(x2.s = "two")

		'' Up-casting
		CU_ASSERT(cast(T1, x2).a = 111)
		CU_ASSERT(cast(T1, x2).s = "one")

		CU_ASSERT(cast(T1, *@x2).a = 111)
		CU_ASSERT(cast(T1, *@x2).s = "one")

		CU_ASSERT(cptr(T1 ptr, @x2)->a = 111)
		CU_ASSERT(cptr(T1 ptr, @x2)->s = "one")

		'' Repeated up-casting
		checkVarT1(cast(T1, x2))
	#endmacro

	#macro checkVarT3(x3)
		CU_ASSERT(x3.a = 111)
		CU_ASSERT(x3.b = 222)
		CU_ASSERT(x3.c = 333)
		CU_ASSERT(x3.s = "three")

		'' Up-casting
		CU_ASSERT(cast(T2, x3).a = 111)
		CU_ASSERT(cast(T2, x3).b = 222)
		CU_ASSERT(cast(T2, x3).s = "two")
		CU_ASSERT(cast(T1, x3).a = 111)
		CU_ASSERT(cast(T1, x3).s = "one")

		CU_ASSERT(cast(T2, *@x3).a = 111)
		CU_ASSERT(cast(T2, *@x3).b = 222)
		CU_ASSERT(cast(T2, *@x3).s = "two")
		CU_ASSERT(cast(T1, *@x3).a = 111)
		CU_ASSERT(cast(T1, *@x3).s = "one")

		CU_ASSERT(cptr(T2 ptr, @x3)->a = 111)
		CU_ASSERT(cptr(T2 ptr, @x3)->b = 222)
		CU_ASSERT(cptr(T2 ptr, @x3)->s = "two")
		CU_ASSERT(cptr(T1 ptr, @x3)->a = 111)
		CU_ASSERT(cptr(T1 ptr, @x3)->s = "one")

		'' Repeated up-casting
		checkVarT2(cast(T2, x3))
	#endmacro

	#macro makeCheckParam(N)
		private sub checkByvalT##N(byval x##N as T##N)
			checkVarT##N(x##N)
		end sub

		private sub checkByrefT##N(byref x##N as T##N)
			checkVarT##N(x##N)
		end sub

		private sub checkPtrT##N(byval x##N as T##N ptr)
			checkVarT##N((*x##N))
		end sub
	#endmacro

	makeCheckParam(1)
	makeCheckParam(2)
	makeCheckParam(3)

	dim shared as T1 x1_global
	dim shared as T2 x2_global
	dim shared as T3 x3_global

	function returnByvalT1( ) as T1 : function = type( ) : end function
	function returnByvalT2( ) as T2 : function = type( ) : end function
	function returnByvalT3( ) as T3 : function = type( ) : end function

	function returnByrefT1( ) byref as T1 : function = x1_global : end function
	function returnByrefT2( ) byref as T2 : function = x2_global : end function
	function returnByrefT3( ) byref as T3 : function = x3_global : end function

	'' upcasting derived UDT vars
	TEST( upcastDerivedUDT )
		static as T3 x3_static
		dim as T3 x3_local

		''
		'' Explicit up-casting
		''

		checkVarT3(x3_local)
		checkVarT3(x3_static)
		checkVarT3(x3_global)

		''
		'' Implicit argument-to-parameter casting
		''

		checkByvalT1(x3_local)
		checkByvalT2(x3_local)
		checkByvalT3(x3_local)

		checkByrefT1(x3_local)
		checkByrefT2(x3_local)
		checkByrefT3(x3_local)

		checkByvalT1( x1_global )
		checkByvalT1( x2_global )
		checkByvalT1( x3_global )
		checkByvalT2( x2_global )
		checkByvalT2( x3_global )
		checkByvalT3( x3_global )

		checkByrefT1( x1_global )
		checkByrefT1( x2_global )
		checkByrefT1( x3_global )
		checkByrefT2( x2_global )
		checkByrefT2( x3_global )
		checkByrefT3( x3_global )

		checkByvalT1( returnByvalT1( ) )
		checkByvalT1( returnByvalT2( ) )
		checkByvalT1( returnByvalT3( ) )
		checkByvalT2( returnByvalT2( ) )
		checkByvalT2( returnByvalT3( ) )
		checkByvalT3( returnByvalT3( ) )

		checkByvalT1( returnByrefT1( ) )
		checkByvalT1( returnByrefT2( ) )
		checkByvalT1( returnByrefT3( ) )
		checkByvalT2( returnByrefT2( ) )
		checkByvalT2( returnByrefT3( ) )
		checkByvalT3( returnByrefT3( ) )

		checkByrefT1( returnByvalT1( ) )
		checkByrefT1( returnByvalT2( ) )
		checkByrefT1( returnByvalT3( ) )
		checkByrefT2( returnByvalT2( ) )
		checkByrefT2( returnByvalT3( ) )
		checkByrefT3( returnByvalT3( ) )

		checkByrefT1( returnByrefT1( ) )
		checkByrefT1( returnByrefT2( ) )
		checkByrefT1( returnByrefT3( ) )
		checkByrefT2( returnByrefT2( ) )
		checkByrefT2( returnByrefT3( ) )
		checkByrefT3( returnByrefT3( ) )

		checkByvalT1( type<T1>( ) )
		checkByvalT1( type<T2>( ) )
		checkByvalT1( type<T3>( ) )
		checkByvalT2( type<T2>( ) )
		checkByvalT2( type<T3>( ) )
		checkByvalT3( type<T3>( ) )

		checkByrefT1( type<T1>( ) )
		checkByrefT1( type<T2>( ) )
		checkByrefT1( type<T3>( ) )
		checkByrefT2( type<T2>( ) )
		checkByrefT2( type<T3>( ) )
		checkByrefT3( type<T3>( ) )

		''
		'' Implicit pointer casting
		''

		checkPtrT1(@x3_local)
		checkPtrT2(@x3_local)
		checkPtrT3(@x3_local)
	END_TEST

	'' derived lvalue cast + anon assign
	TEST_GROUP( lvalueCastVsTypeini )
		type Byte1
			dim b1 as byte
		end type

		type Byte2 extends Byte1
		end type

		TEST( default )
			'' crash regression test
			'' As long as lvalue casting like this is allowed,
			'' this should not crash the compiler.
			dim i2 as Byte2
			cast(Byte1, i2) = type<Byte1>(2)
			CU_PASS( )
		END_TEST
	END_TEST_GROUP

	'' bug #719 regression test 1
	TEST_GROUP( bug719_1 )
		'' This shouldn't crash the compiler under -gen gas

		type UDT extends object
			i as integer
		end type

		function returnByvalUdt( ) as UDT
			function = type( )
		end function

		sub f( byref c as object )
		end sub

		TEST( default )
			f( returnByvalUdt( ) )
			f( cast( object, returnByvalUdt( ) ) )
			CU_PASS( )
		END_TEST
	END_TEST_GROUP

	'' bug #719 regression test 2
	TEST_GROUP( bug719_2 )
		'' This shouldn't crash the compiler under -gen gas

		type A extends object
			id as string = "A"
			declare static function CreateA() as A
		end type

		function A.CreateA() as A
			dim x as A
			x.id = "CreateA"
			function = x
		end function

		type B extends A
			id as string = "B"
			declare static function CreateB() as B
		end type

		function B.CreateB() as B
			dim x as B
			x.id = "CreateB"
			function = x
		end function

		TEST( default )
			dim d1 as A = A()
			dim d2 as A = A.CreateA()
			CU_ASSERT( d1.id = "A" )
			CU_ASSERT( d2.id = "CreateA" )

			dim d3 as B = B()
			dim d4 as B = B.CreateB()
			CU_ASSERT( cast( A, d3 ).id = "A" )
			CU_ASSERT( cast( A, d4 ).id = "A" )
			CU_ASSERT( d3.id = "B" )
			CU_ASSERT( d4.id = "CreateB" )

			dim d5 as A = B()
			dim d6 as A = B.CreateB()
			CU_ASSERT( d5.id = "A" )
			CU_ASSERT( d6.id = "A" )
		END_TEST
	END_TEST_GROUP

END_SUITE
