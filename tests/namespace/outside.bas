#include "fbcunit.bi"

'' Outside-of-namespace declarations should be allowed, as long as a prototype
'' was declared in the original namespace, and the proper namespace id is
'' used in the body's header.
'' (this is mostly a compile/link-time test)

#macro hProcTest( )
	namespace procA
		declare function f1( ) as integer

		namespace procB
			declare function f1( ) as integer
			declare function f2( ) as integer
			declare function f3( ) as integer
		end namespace

		private function procB.f2( ) as integer
			function = &hABF2
		end function

		declare function f2( ) as integer
		declare function f3( ) as integer

		private function procB.f3( ) as integer
			function = &hABF3
		end function
	end namespace

	private function procA.f1( ) as integer
		function = &hAF1
	end function

	private function procA.procB.f1( ) as integer
		function = &hABF1
	end function

	private function procA.f2( ) as integer
		function = &hAF2
	end function

	private function procA.f3( ) as integer
		function = &hAF3
	end function
#endmacro

#macro hVarTest( )
	namespace varA
		extern dup1 as integer

		namespace varB
			extern dup1 as integer

			extern i1 as integer
			extern i2 as integer
			extern i3 as integer

			dim i1 as integer

			extern j1 as integer

			dim array1() as integer
		end namespace

		extern i4 as integer
		extern i5 as integer

		dim varB.i2 as integer
		dim i4 as integer

		extern j2 as integer
	end namespace

	dim varA.varB.i3 as integer
	dim varA.i5 as integer
	dim shared i6 as integer

	dim as integer varA.varB.j1, varA.j2

	dim as integer varA.dup1 = 1, varA.varB.dup1 = 2
#endmacro

'' Same tests as below but in the toplevel namespace
hProcTest( )
hVarTest( )

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

SUITE( fbc_tests.namespace_.outside )

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST_GROUP( procedures )
		hProcTest( )

		TEST( default )
			'' outside-of-original namespace REDIM should be allowed,
			'' it's not really declaration but code, but it happens to
			'' be handled by the same parser...
			redim varA.varB.array1(0 to 1)

			CU_ASSERT( procA.procB.f1( ) = &hABF1 )
			CU_ASSERT( procA.procB.f2( ) = &hABF2 )
			CU_ASSERT( procA.procB.f3( ) = &hABF3 )
			CU_ASSERT( procA.f1( ) = &hAF1 )
			CU_ASSERT( procA.f2( ) = &hAF2 )
			CU_ASSERT( procA.f3( ) = &hAF3 )
		END_TEST
	END_TEST_GROUP

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	TEST_GROUP( variables )
		hVarTest( )

		TEST( default )
			CU_ASSERT( varA.varB.i1 = 0 )
			CU_ASSERT( varA.varB.i2 = 0 )
			CU_ASSERT( varA.varB.i3 = 0 )
			CU_ASSERT( varA.i4 = 0 )
			CU_ASSERT( varA.i5 = 0 )
			CU_ASSERT( i6 = 0 )
			CU_ASSERT( varA.varB.j1 = 0 )
			CU_ASSERT( varA.j2 = 0 )

			CU_ASSERT( varA.dup1 = 1 )
			CU_ASSERT( varA.varB.dup1 = 2 )
		END_TEST
	END_TEST_GROUP

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace op
		type UDT
			as integer a
		end type

		declare sub test_proc( )

		'' if global operators are allowed inside namespaces...
		declare operator +( a as UDT, b as UDT ) as integer

		operator -( a as UDT, b as UDT ) as integer
			operator = a.a - b.a - 2
		end operator
	end namespace

	'' and outside-of-namespace bodies like this are allowed...
	sub op.test_proc( )
	end sub

	'' then this outside-of-namespace operator body should be allowed too:
	operator op.+( a as op.UDT, b as op.UDT ) as integer
		operator = a.a + b.a + 2
	end operator

	TEST( operator_ )
		dim as op.UDT a, b

		a.a = 1
		b.a = 1
		CU_ASSERT( a + b = 4 )
		CU_ASSERT( a - b = -2 )

		a.a = 3
		b.a = 7
		CU_ASSERT( a + b = 12 )
		CU_ASSERT( a - b = -6 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace ctor
		type UDT1
			dummy1 as integer
			declare constructor( )
		end type

		constructor UDT1( )
			dummy1 = 1
		end constructor

		type UDT2
			dummy2 as integer
			declare constructor( )
		end type

		namespace nested
			type UDT1
				dummy3 as integer
				declare constructor( )
			end type

			type UDT2
				dummy4 as integer
				declare constructor( )
			end type
		end namespace

		constructor nested.UDT1( )
			dummy3 = 3
		end constructor
	end namespace

	constructor ctor.UDT2( )
		dummy2 = 2
	end constructor

	constructor ctor.nested.UDT2( )
		dummy4 = 4
	end constructor

	TEST( constructor_ )
		dim a as ctor.UDT1
		CU_ASSERT( a.dummy1 = 1 )

		dim b as ctor.UDT2
		CU_ASSERT( b.dummy2 = 2 )

		dim c as ctor.nested.UDT1
		CU_ASSERT( c.dummy3 = 3 )

		dim d as ctor.nested.UDT2
		CU_ASSERT( d.dummy4 = 4 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace dtor
		dim shared as integer calls1, calls2, calls3, calls4

		type UDT1
			dummy1 as integer
			declare destructor( )
		end type

		destructor UDT1( )
			calls1 += 1
		end destructor

		type UDT2
			dummy2 as integer
			declare destructor( )
		end type

		namespace nested
			type UDT1
				dummy3 as integer
				declare destructor( )
			end type

			type UDT2
				dummy4 as integer
				declare destructor( )
			end type
		end namespace

		destructor nested.UDT1( )
			calls3 += 1
		end destructor
	end namespace

	destructor dtor.UDT2( )
		dtor.calls2 += 1
	end destructor

	destructor dtor.nested.UDT2( )
		dtor.calls4 += 1
	end destructor

	TEST( destructor_ )
		CU_ASSERT( dtor.calls1 = 0 )
		CU_ASSERT( dtor.calls2 = 0 )
		CU_ASSERT( dtor.calls3 = 0 )
		CU_ASSERT( dtor.calls4 = 0 )

		scope
			dim a as dtor.UDT1
			dim b as dtor.UDT2
			dim c as dtor.nested.UDT1
			dim d as dtor.nested.UDT2
		end scope

		CU_ASSERT( dtor.calls1 = 1 )
		CU_ASSERT( dtor.calls2 = 1 )
		CU_ASSERT( dtor.calls3 = 1 )
		CU_ASSERT( dtor.calls4 = 1 )
	END_TEST

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace prop
		type UDT1
			dummy1 as integer
			declare property foo( byval i as integer )
			declare property foo( ) as integer
		end type

		property UDT1.foo( byval i as integer )
			dummy1 = i
		end property

		property UDT1.foo( ) as integer
			property = dummy1
		end property

		type UDT2
			dummy2 as integer
			declare property foo( byval i as integer )
			declare property foo( ) as integer
		end type

		namespace nested
			type UDT1
				dummy3 as integer
				declare property foo( byval i as integer )
				declare property foo( ) as integer
			end type

			type UDT2
				dummy4 as integer
				declare property foo( byval i as integer )
				declare property foo( ) as integer
			end type
		end namespace

		property nested.UDT1.foo( byval i as integer )
			dummy3 = i
		end property

		property nested.UDT1.foo( ) as integer
			property = dummy3
		end property
	end namespace

	property prop.UDT2.foo( byval i as integer )
		dummy2 = i
	end property

	property prop.UDT2.foo( ) as integer
		property = dummy2
	end property

	property prop.nested.UDT2.foo( byval i as integer )
		dummy4 = i
	end property

	property prop.nested.UDT2.foo( ) as integer
		property = dummy4
	end property

	TEST( property_ )
		dim a as prop.UDT1
		a.foo = 1
		CU_ASSERT( a.foo = 1 )

		dim b as prop.UDT2
		b.foo = 2
		CU_ASSERT( b.foo = 2 )

		dim c as prop.nested.UDT1
		c.foo = 3
		CU_ASSERT( c.foo = 3 )

		dim d as prop.nested.UDT2
		d.foo = 4
		CU_ASSERT( d.foo = 4 )
	END_TEST

END_SUITE

