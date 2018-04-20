#include "fbcunit.bi"

#include once "fbrtti.bi"

SUITE( fbc_tests.virtual_.rtti )

	'' Is operator
	TEST_GROUP( simple )
		const DOG_ACTION = "rub belly"
		const CAT_ACTION = "sleep"

		type Animal extends Object	'' must extend Object so RTTI will be generated for this class
			dim as string name
		end type

		type Dog extends Animal
			declare constructor (name_ as string)
			declare function getAction as string
		end type

		constructor Dog (name_ as string)
			base.name = name_
		end constructor

		function Dog.getAction as string
			return DOG_ACTION
		end function

		type Cat extends Animal
			declare constructor (name_ as string)
			declare function getAction as string
		end type

		constructor Cat (name_ as string)
			base.name = name_
		end constructor

		function Cat.getAction as string
			return CAT_ACTION
		end function

		function getAction( a as Animal ) as string
			if( a is Dog ) then
				return cast( Dog ptr, @a )->getAction
			elseif( a is Cat ) then
				return cast( Cat ptr, @a )->getAction
			end if
		end function

		TEST( default )
			var pluto = Dog( "Pluto" )
			var tom = Cat( "Tom" )
			CU_ASSERT( getAction( pluto ) = DOG_ACTION )
			CU_ASSERT( getAction( tom ) = CAT_ACTION )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( emptyVtable )
		'' 1. Anything with a vptr must have a vtable, even if the vtable is "empty"
		'' 2. An "empty" vtable means it has only the first two entries,
		''    but no slots for virtuals
		'' This is also a -gen gcc regression test, where the vtable was emitted with
		'' zero size but an initialzer with 2 elements, causing gcc to warn.
		type UDT extends object
			declare function test_proc( ) as integer
		end type

		function UDT.test_proc( ) as integer
			function = 123
		end function

		TEST( default )
			dim x as UDT
			CU_ASSERT( x.test_proc( ) = 123 )
		END_TEST
	END_TEST_GROUP

	'' RTTI handles namespaces
	TEST_GROUP( rttiHandlesNamespaces1 )
		type UDT1 extends object
		end type
		namespace ns1
			type UDT1 extends UDT1
			end type
			namespace ns2
				type UDT1 extends UDT1
				end type
			end namespace
		end namespace

		TEST( default )
			scope
				dim pudt1 as UDT1 ptr = new UDT1
				CU_ASSERT( (*pudt1 is ns1.UDT1) = 0 )
				CU_ASSERT( (*pudt1 is ns1.ns2.UDT1) = 0 )
				delete pudt1
			end scope

			scope
				dim pudt1 as UDT1 ptr = new ns1.UDT1
				CU_ASSERT( *pudt1 is ns1.UDT1 )
				CU_ASSERT( (*pudt1 is ns1.ns2.UDT1) = 0 )
				delete pudt1
			end scope

			scope
				dim pudt1 as UDT1 ptr = new ns1.ns2.UDT1
				CU_ASSERT( *pudt1 is ns1.UDT1 )
				CU_ASSERT( *pudt1 is ns1.ns2.UDT1 )
				delete pudt1
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dtorsResetVptr )
		dim shared as any ptr avptr, bvptr
		dim shared as integer adtors, bdtors

		type A extends object
			declare destructor( )
			declare virtual function f( ) as integer
		end type

		destructor A( )
			adtors += 1
			CU_ASSERT( getvptr( @this ) = avptr )
			CU_ASSERT( f( ) = &hA )
		end destructor

		function A.f( ) as integer
			function = &hA
		end function

		type B extends A
			declare destructor( )
			declare function f( ) as integer override
		end type

		destructor B( )
			bdtors += 1
			CU_ASSERT( getvptr( @this ) = bvptr )
			CU_ASSERT( f( ) = &hB )
		end destructor

		function B.f( ) as integer
			function = &hB
		end function

		TEST( default )
			CU_ASSERT( adtors = 0 )
			CU_ASSERT( bdtors = 0 )
			scope
				dim xa as A
				dim xb as B
				avptr = getvptr( @xa )
				bvptr = getvptr( @xb )
			end scope
			CU_ASSERT( adtors = 2 )
			CU_ASSERT( bdtors = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
