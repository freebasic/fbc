' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of mangling between c++ derived class and fbc type

#ifdef __FB_FREEBSD__
	#inclib "c++"
#else
	#ifdef __FB_DOS__
		#inclib "stdcx"
	#else
		#inclib "stdc++"
	#endif
#endif

'' helper macro to track progress
#define DLOG( msg ) '' print #msg

#if ENABLE_CHECK_BUGS
	#define DOTEST
	#define DOFUNCS
#else
	#define DOTEST

	'' some structures returned by value from g++
	'' not working for several targets.  Just disable
	'' for now.  It's likely related to passing
	'' structs in registers and size of the struct.
	#if defined( __FB_WIN32__ )
		#define DOFUNCS
	#endif
#endif

#ifndef NULL
#define NULL 0
#endif

extern "c++"
	'' getters to retrieve call information
	'' from the c++ side
	declare sub setInitial( byval flag as long )
	declare sub resetChecks()
	declare function getPtr1() as any ptr
	declare function getPtr2() as any ptr
	declare function getMsg1() as zstring ptr
	declare function getVal1() as long
	declare function getVal2() as long
	declare function getVal3() as long
end extern

extern "c++"
	'' BASE UDT to test with and we declare the same on c++ side
	type UDT_BASE extends OBJECT
		value as long

		declare constructor ()
		declare constructor ( byref rhs as const UDT_BASE )
		declare constructor ( byref rhs as const long )
		declare virtual destructor ()
		declare virtual sub method ( byref rhs as const long )
		declare operator let ( byref rhs as const UDT_BASE )

	end type

	'' DERIVED UDT to test with and we declare the same on c++ side
	type UDT_DERIVED extends UDT_BASE
		declare constructor ()
		declare constructor ( byref rhs as const UDT_DERIVED )
		declare constructor ( byref rhs as const long )
		declare virtual destructor ()
		declare virtual sub method ( byref rhs as const long )
		declare operator let ( byref rhs as const UDT_DERIVED )

	end type

	'' global operators
	declare operator +( byref lhs as const UDT_BASE, byref rhs as const UDT_BASE ) as UDT_BASE
	declare operator -( byref lhs as const UDT_BASE, byref rhs as const UDT_BASE ) as UDT_BASE
	declare operator +( byref lhs as const long, byref rhs as const UDT_BASE ) as UDT_BASE
	declare operator -( byref lhs as const long, byref rhs as const UDT_BASE ) as UDT_BASE

	'' global operators
	declare operator +( byref lhs as const UDT_DERIVED, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
	declare operator -( byref lhs as const UDT_DERIVED, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
	declare operator +( byref lhs as const long, byref rhs as const UDT_DERIVED ) as UDT_DERIVED
	declare operator -( byref lhs as const long, byref rhs as const UDT_DERIVED ) as UDT_DERIVED

end extern

#macro checkResults( p1, p2, v1, v2, v3, m1 )
	assert( m1 = *getMsg1() )
	assert( p1 = getPtr1() )
	assert( p2 = getPtr2() )
	assert( v1 = getVal1() )
	assert( v2 = getVal2() )
	assert( v3 = getVal3() )
#endmacro

#ifdef DOTEST

'' enable results for ctor/dtor/copy-ctor/let
setInitial( 1 )

DLOG( constructor UDT_BASE() )
scope
	resetChecks()
	dim a as UDT_BASE
	checkResults( @a, NULL, -1, -1, 0, "UDT_BASE::UDT_BASE()" )
	assert( a.value = 0 )
end scope

DLOG( destructor UDT_BASE() )
scope
	dim p as any ptr
	scope
		resetChecks()
		dim a as UDT_BASE
		p = @a
		checkResults( @a, NULL, -1, -1, 0, "UDT_BASE::UDT_BASE()" )
		assert( a.value = 0 )
	end scope
	checkResults( p, NULL, 0, -1, -1, "UDT_BASE::~UDT_BASE()" )
end scope

DLOG( constructor UDT_BASE( byref rhs as const long ) )
scope
	dim a as long = 1
	resetChecks()
	dim b as UDT_BASE = a
	checkResults( @b, @a, -1, 1, 1, "UDT_BASE::UDT_BASE( int const& rhs )" )
	assert( b.value = 1 )
end scope

DLOG( constructor UDT_BASE( byref rhs as const UDT ) )
scope
	dim a as UDT_BASE = 2
	resetChecks()
	dim b as UDT_BASE = a
	checkResults( @b, @a, -1, 2, 2, "UDT_BASE::UDT_BASE( UDT_BASE const& rhs )" )
	assert( b.value = 2 )
end scope

DLOG( sub UDT_BASE.method( byref rhs as const long ) )
scope
	dim a1 as long = 1, a2 as long = 2
	resetChecks()
	dim b as UDT_BASE = a1
	checkResults( @b, @a1, -1, 1, 1, "UDT_BASE::UDT_BASE( int const& rhs )" )
	b.method( a2 )
	checkResults( @b, @a2,  1, 2, 2, "void UDT_BASE::method( int const& rhs )" )
	assert( b.value = a2 )
end scope

DLOG( operator UDT_BASE.let( byref rhs as const UDT ) )
scope
	dim a as UDT_BASE = 2
	dim b as UDT_BASE
	resetChecks()
	b = a
	checkResults( @b, @a, 0, 2, 2, "UDT_BASE& UDT_BASE::operator=( UDT_BASE const& rhs )" )
	assert( b.value = 2 )
end scope

DLOG( constructor UDT_DERIVED() )
scope
	resetChecks()
	dim a as UDT_DERIVED
	checkResults( @a, NULL, -1, -1, 0, "UDT_DERIVED::UDT_DERIVED()" )
	assert( a.value = 0 )
end scope

DLOG( destructor UDT_DERIVED() )
scope
	dim p as any ptr
	scope
		resetChecks()
		dim a as UDT_DERIVED
		p = @a
		checkResults( @a, NULL, -1, -1, 0, "UDT_DERIVED::UDT_DERIVED()" )
		assert( a.value = 0 )
	end scope
	checkResults( p, NULL, 0, -1, -1, "UDT_BASE::~UDT_BASE()" )
end scope

DLOG( constructor UDT_DERIVED( byref rhs as const long ) )
scope
	dim a as long = 1
	resetChecks()
	dim b as UDT_DERIVED = a
	checkResults( @b, @a, -1, 1, 1, "UDT_DERIVED::UDT_DERIVED( int const& rhs )" )
	assert( b.value = 1 )
end scope

DLOG( constructor UDT_DERIVED( byref rhs as const UDT ) )
scope
	dim a as UDT_DERIVED = 2
	resetChecks()
	dim b as UDT_DERIVED = a
	checkResults( @b, @a, -1, 2, 2, "UDT_DERIVED::UDT_DERIVED( UDT_DERIVED const& rhs )" )
	assert( b.value = 2 )
end scope

DLOG( sub UDT_DERIVED.method( byref rhs as const long ) )
scope
	dim a1 as long = 3, a2 as long = 4
	resetChecks()
	dim b as UDT_DERIVED = a1
	checkResults( @b, @a1, -1, 3, 3, "UDT_DERIVED::UDT_DERIVED( int const& rhs )" )
	b.method( a2 )
	checkResults( @b, @a2,  3, 4, 4, "void UDT_DERIVED::method( int const& rhs )" )
	assert( b.value = a2 )
end scope

DLOG( operator UDT_DERIVED.let( byref rhs as const UDT ) )
scope
	dim a as UDT_DERIVED = 2
	dim b as UDT_DERIVED
	resetChecks()
	b = a
	checkResults( @b, @a, 0, 2, 2, "UDT_DERIVED& UDT_DERIVED::operator=( UDT_DERIVED const& rhs )" )
	assert( b.value = 2 )
end scope

'' disable results for ctor/dtor/copy-ctor/let
setInitial( 0 )

#ifdef DOFUNCS
DLOG( operator +( byref lhs as const UDT_BASE, byref rhs as const UDT_BASE ) as UDT_BASE )
scope
	dim as UDT_BASE a = 3
	dim as UDT_BASE b = 11
	dim as UDT_BASE c
	resetChecks()
	c = (a + b)
	checkResults( @a, @b, 3, 11, 14, "UDT_BASE operator+( UDT_BASE const& lhs, UDT_BASE const& rhs )" )
end scope

DLOG( operator -( byref lhs as const UDT_BASE, byref rhs as const UDT_BASE ) as UDT_BASE )
scope
	dim as UDT_BASE a = 17
	dim as UDT_BASE b = 5
	dim as UDT_BASE c
	resetChecks()
	c = a - b
	checkResults( @a, @b, 17, 5, 12, "UDT_BASE operator-( UDT_BASE const& lhs, UDT_BASE const& rhs )" )
end scope

DLOG( operator +( byref lhs as const long, byref rhs as const UDT_DERIVED ) as UDT_DERIVED )
scope
	dim as long a = 3
	dim as UDT_DERIVED b = 11
	dim as UDT_DERIVED c
	resetChecks()
	c = a + b
	checkResults( @a, @b, 3, 11, 14, "UDT_DERIVED operator+( int const& lhs, UDT_DERIVED const& rhs )" )
end scope

DLOG( operator -( byref lhs as const long, byref rhs as const UDT_DERIVED ) as UDT_DERIVED )
scope
	dim as long a = 17
	dim as UDT_DERIVED b = 5
	dim as UDT_DERIVED c
	resetChecks()
	c = a - b
	checkResults( @a, @b, 17, 5, 12, "UDT_DERIVED operator-( int const& lhs, UDT_DERIVED const& rhs )" )
end scope
#endif

#endif '' DOTEST
