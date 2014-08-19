# include "fbcu.bi"

namespace fbc_tests.structs.implicit_methods

namespace copyCtorUdt
	dim shared as integer ctors, copyctors, lets

	type Nested
		i as integer
		declare constructor( )
		declare constructor( byref rhs as const Nested )
		declare operator let( byref rhs as const Nested )
	end type

	constructor Nested( )
		ctors += 1
	end constructor

	constructor Nested( byref rhs as const Nested )
		copyctors += 1
	end constructor

	operator Nested.let( byref rhs as const Nested )
		this.i = rhs.i
		lets += 1
	end operator

	type UDT
		myfield as Nested
	end type

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		dim x1 as UDT
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		dim x2 as UDT = x1
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 1 )
	end sub
end namespace

namespace copyCtorConstUdt
	dim shared as integer ctors, copyctors, lets

	type Nested
		i as integer
		declare constructor( )
		declare constructor( byref rhs as const Nested )
		declare operator let( byref rhs as const Nested )
	end type

	constructor Nested( )
		ctors += 1
	end constructor

	constructor Nested( byref rhs as const Nested )
		copyctors += 1
	end constructor

	operator Nested.let( byref rhs as const Nested )
		this.i = rhs.i
		lets += 1
	end operator

	type UDT
		myfield as Nested
	end type

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		dim x1 as const UDT = UDT( )
		CU_ASSERT( ctors = 1 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		dim x2 as UDT = x1
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 1 )
	end sub
end namespace

namespace copyCtorString
	type UDT
		s as string
	end type

	sub test cdecl( )
		dim x1 as UDT
		x1.s = "abc"

		dim x2 as UDT = x1
		CU_ASSERT( x2.s = "abc" )

		CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
	end sub
end namespace

namespace copyCtorConstString
	type UDT
		s as string
		declare constructor( byref as string )
	end type

	constructor UDT( byref s as string )
		this.s = s
	end constructor

	sub test cdecl( )
		dim x1 as const UDT = UDT( "abc" )
		CU_ASSERT( x1.s = "abc" )

		dim x2 as UDT = x1
		CU_ASSERT( x2.s = "abc" )

		CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
	end sub
end namespace

namespace copyLetUdt
	dim shared as integer ctors, copyctors, lets

	type Nested
		i as integer
		declare constructor( )
		declare constructor( byref rhs as const Nested )
		declare operator let( byref rhs as const Nested )
	end type

	constructor Nested( )
		ctors += 1
	end constructor

	constructor Nested( byref rhs as const Nested )
		copyctors += 1
	end constructor

	operator Nested.let( byref rhs as const Nested )
		this.i = rhs.i
		lets += 1
	end operator

	type UDT
		myfield as Nested
	end type

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		dim as UDT x1, x2
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		x2 = x1
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 1 )
	end sub
end namespace

namespace copyLetConstUdt
	dim shared as integer ctors, copyctors, lets

	type Nested
		i as integer
		declare constructor( )
		declare constructor( byref rhs as const Nested )
		declare operator let( byref rhs as const Nested )
	end type

	constructor Nested( )
		ctors += 1
	end constructor

	constructor Nested( byref rhs as const Nested )
		copyctors += 1
	end constructor

	operator Nested.let( byref rhs as const Nested )
		this.i = rhs.i
		lets += 1
	end operator

	type UDT
		myfield as Nested
	end type

	sub test cdecl( )
		CU_ASSERT( ctors = 0 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		dim as const UDT x1 = UDT( )
		dim as UDT x2
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 0 )

		x2 = x1
		CU_ASSERT( ctors = 2 )
		CU_ASSERT( copyctors = 0 )
		CU_ASSERT( lets = 1 )
	end sub
end namespace

namespace copyLetString
	type UDT
		s as string
	end type

	sub test cdecl( )
		dim as UDT x1, x2
		x1.s = "abc"

		x2 = x1
		CU_ASSERT( x2.s = "abc" )

		CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
	end sub
end namespace

namespace copyLetConstString
	type UDT
		s as string
		declare constructor( byref as string )
	end type

	constructor UDT( byref s as string )
		this.s = s
	end constructor

	sub test cdecl( )
		dim x1 as const UDT = UDT( "abc" )
		CU_ASSERT( x1.s = "abc" )

		dim x2 as UDT = UDT( "foo" )
		CU_ASSERT( x2.s = "foo" )

		x2 = x1
		CU_ASSERT( x2.s = "abc" )

		CU_ASSERT( strptr( x1.s ) <> strptr( x2.s ) )
	end sub
end namespace

''
'' We have to detect copy-constructors or copy-LET-overloads even if their
'' parameter if a forward reference to the UDT, otherwise we'd add the implicit
'' copyctor/copylet despite the user-defined ones already being there, and then
'' we'd end up with duplicate definitions...
''
namespace copyCtorFwdref1
	dim shared as integer copyctors

	type UDT as UDT_

	type UDT_
		i as integer
		declare constructor( )
		declare constructor( byref as UDT )
	end type

	constructor UDT_( )
	end constructor

	sub test cdecl( )
		dim as UDT_ a
		CU_ASSERT( copyctors = 0 )

		dim as UDT_ b = a
		CU_ASSERT( copyctors = 1 )
	end sub

	constructor UDT_( byref rhs as UDT )
		copyctors += 1
	end constructor
end namespace

namespace copyCtorFwdref2
	dim shared as integer copyctors

	type UDT as UDT_

	type UDT_
		i as integer
		declare constructor( )
		declare constructor( byref as UDT )
	end type

	constructor UDT_( )
	end constructor

	constructor UDT_( byref rhs as UDT )
		copyctors += 1
	end constructor

	sub test cdecl( )
		dim as UDT_ a
		CU_ASSERT( copyctors = 0 )

		dim as UDT_ b = a
		CU_ASSERT( copyctors = 1 )
	end sub
end namespace

namespace copyCtorConstFwdref1
	dim shared as integer copyctors

	type UDT as UDT_

	type UDT_
		i as integer
		declare constructor( )
		declare constructor( byref as const UDT )
	end type

	constructor UDT_( )
	end constructor

	sub test cdecl( )
		scope
			dim as UDT_ a
			CU_ASSERT( copyctors = 0 )

			dim as UDT_ b = a
			CU_ASSERT( copyctors = 1 )
		end scope
		copyctors = 0

		scope
			dim as const UDT_ a = UDT_( )
			CU_ASSERT( copyctors = 0 )

			dim as UDT_ b = a
			CU_ASSERT( copyctors = 1 )
		end scope
	end sub

	constructor UDT_( byref rhs as const UDT )
		copyctors += 1
	end constructor
end namespace

namespace copyCtorConstFwdref2
	dim shared as integer copyctors

	type UDT as UDT_

	type UDT_
		i as integer
		declare constructor( )
		declare constructor( byref as const UDT )
	end type

	constructor UDT_( )
	end constructor

	constructor UDT_( byref rhs as const UDT )
		copyctors += 1
	end constructor

	sub test cdecl( )
		scope
			dim as UDT_ a
			CU_ASSERT( copyctors = 0 )

			dim as UDT_ b = a
			CU_ASSERT( copyctors = 1 )
		end scope
		copyctors = 0

		scope
			dim as const UDT_ a = UDT_( )
			CU_ASSERT( copyctors = 0 )

			dim as UDT_ b = a
			CU_ASSERT( copyctors = 1 )
		end scope
	end sub
end namespace

namespace copyLetFwdref1
	dim shared as integer copylets

	type UDT as UDT_

	type UDT_
		i as integer
		declare operator let( byref as UDT )
	end type

	sub test cdecl( )
		dim as UDT_ a, b
		CU_ASSERT( copylets = 0 )

		b = a
		CU_ASSERT( copylets = 1 )
	end sub

	operator UDT_.let( byref rhs as UDT )
		copylets += 1
	end operator
end namespace

namespace copyLetFwdref2
	dim shared as integer copylets

	type UDT as UDT_

	type UDT_
		i as integer
		declare operator let( byref as UDT )
	end type

	operator UDT_.let( byref rhs as UDT )
		copylets += 1
	end operator

	sub test cdecl( )
		dim as UDT_ a, b
		CU_ASSERT( copylets = 0 )

		b = a
		CU_ASSERT( copylets = 1 )
	end sub
end namespace

namespace copyLetConstFwdref1
	dim shared as integer copylets

	type UDT as UDT_

	type UDT_
		i as integer
		declare operator let( byref as const UDT )
	end type

	sub test cdecl( )
		scope
			dim as UDT_ a, b
			CU_ASSERT( copylets = 0 )

			b = a
			CU_ASSERT( copylets = 1 )
		end scope
		copylets = 0

		scope
			dim a as const UDT_ = ( 123 )
			dim b as UDT_
			CU_ASSERT( copylets = 0 )

			b = a
			CU_ASSERT( copylets = 1 )
		end scope
	end sub

	operator UDT_.let( byref rhs as const UDT )
		copylets += 1
	end operator
end namespace

namespace copyLetConstFwdref2
	dim shared as integer copylets

	type UDT as UDT_

	type UDT_
		i as integer
		declare operator let( byref as const UDT )
	end type

	operator UDT_.let( byref rhs as const UDT )
		copylets += 1
	end operator

	sub test cdecl( )
		scope
			dim as UDT_ a, b
			CU_ASSERT( copylets = 0 )

			b = a
			CU_ASSERT( copylets = 1 )
		end scope
		copylets = 0

		scope
			dim a as const UDT_ = ( 123 )
			dim b as UDT_
			CU_ASSERT( copylets = 0 )

			b = a
			CU_ASSERT( copylets = 1 )
		end scope
	end sub
end namespace

namespace virtualWithByvalSelfResult
	'' An UDT with a virtual method that returns the UDT itself byval.
	''
	'' fbc must be careful to declare implicit members, calculate the UDT
	'' return type, and implement implicit members in the right order,
	'' otherwise some code (such as the function pointers for vtable slots)
	'' may try to use the UDT return type while it's not known yet.

	type UDT extends object
		i as integer = 123
		declare virtual function f() as UDT
	end type

	function UDT.f() as UDT
		function = type()
	end function

	sub test cdecl( )
		dim as UDT a, b
		CU_ASSERT( a.i = 123 )
		CU_ASSERT( b.i = 123 )

		a.i = 0
		b.i = 0
		CU_ASSERT( a.i = 0 )
		CU_ASSERT( b.i = 0 )

		b = a.f()
		CU_ASSERT( a.i = 0 )
		CU_ASSERT( b.i = 123 )

		a.i = 0
		b.i = 0
		CU_ASSERT( a.i = 0 )
		CU_ASSERT( b.i = 0 )

		a = a.f()
		CU_ASSERT( a.i = 123 )
		CU_ASSERT( b.i = 0 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/structs/implicit-methods" )

	fbcu.add_test( "copyCtorUdt"        , @copyCtorUdt.test )
	fbcu.add_test( "copyCtorConstUdt"   , @copyCtorConstUdt.test )
	fbcu.add_test( "copyCtorString"     , @copyCtorString.test )
	fbcu.add_test( "copyCtorConstString", @copyCtorConstString.test )

	fbcu.add_test( "copyLetUdt"        , @copyLetUdt.test )
	fbcu.add_test( "copyLetConstUdt"   , @copyLetConstUdt.test )
	fbcu.add_test( "copyLetString"     , @copyLetString.test )
	fbcu.add_test( "copyLetConstString", @copyLetConstString.test )

	fbcu.add_test( "copyCtorFwdref1"     , @copyCtorFwdref1.test )
	fbcu.add_test( "copyCtorFwdref2"     , @copyCtorFwdref2.test )
	fbcu.add_test( "copyCtorConstFwdref1", @copyCtorConstFwdref1.test )
	fbcu.add_test( "copyCtorConstFwdref2", @copyCtorConstFwdref2.test )

	fbcu.add_test( "copyLetFwdref1"     , @copyLetFwdref1.test )
	fbcu.add_test( "copyLetFwdref2"     , @copyLetFwdref2.test )
	fbcu.add_test( "copyLetConstFwdref1", @copyLetConstFwdref1.test )
	fbcu.add_test( "copyLetConstFwdref2", @copyLetConstFwdref2.test )

	fbcu.add_test( "virtualWithByvalSelfResult", @virtualWithByvalSelfResult.test )
end sub

end namespace
