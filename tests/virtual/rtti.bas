# include "fbcu.bi"

namespace fbc_tests.virt.rtti

namespace simple
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

	sub test cdecl( )
		var pluto = Dog( "Pluto" )
		var tom = Cat( "Tom" )
		CU_ASSERT( getAction( pluto ) = DOG_ACTION )
		CU_ASSERT( getAction( tom ) = CAT_ACTION )
	end sub
end namespace

namespace emptyVtable
	'' 1. Anything with a vptr must have a vtable, even if the vtable is "empty"
	'' 2. An "empty" vtable means it has only the first two entries,
	''    but no slots for virtuals
	'' This is also a -gen gcc regression test, where the vtable was emitted with
	'' zero size but an initialzer with 2 elements, causing gcc to warn.
	type UDT extends object
		declare function test( ) as integer
	end type

	function UDT.test( ) as integer
		function = 123
	end function

	sub test cdecl( )
		dim x as UDT
		CU_ASSERT( x.test( ) = 123 )
	end sub
end namespace

namespace rttiHandlesNamespaces1
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

	sub test cdecl( )
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
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/virtual/rtti" )
	fbcu.add_test( "Is operator", @simple.test )
	fbcu.add_test( "empty vtable", @emptyVtable.test )
	fbcu.add_test( "RTTI handles namespaces", @rttiHandlesNamespaces1.test )
end sub

end namespace
