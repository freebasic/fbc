' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of mangling between c++ class and fbc type

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
	'' simple UDT to test with and we
	'' declare the same on c++ side

	type UDT
		value as long

		declare constructor ()
		declare constructor ( byref rhs as const UDT )
		declare constructor ( byref rhs as const long )
		declare destructor ()
		declare sub method ( byref rhs as const long )
		declare operator let ( byref rhs as const UDT )
		'' !!! TODO !!! member operators
		'' !!! TODO !!! declare operator + ( byref rhs as const long ) as UDT
		'' !!! TODO !!! declare operator - ( byref rhs as const long ) as UDT

	end type

	'' global operators
	declare operator +( byref lhs as const UDT, byref rhs as const UDT ) as UDT
	declare operator -( byref lhs as const UDT, byref rhs as const UDT ) as UDT
	declare operator +( byref lhs as const long, byref rhs as const UDT ) as UDT
	declare operator -( byref lhs as const long, byref rhs as const UDT ) as UDT

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

DLOG( constructor UDT() )
scope
	resetChecks()
	dim a as UDT
	checkResults( @a, NULL, -1, -1, 0, "UDT::UDT()" )
	assert( a.value = 0 )
end scope

DLOG( destructor UDT() )
scope
	dim p as any ptr
	scope
		resetChecks()
		dim a as UDT
		p = @a
		checkResults( @a, NULL, -1, -1, 0, "UDT::UDT()" )
		assert( a.value = 0 )
	end scope
	checkResults( p, NULL, 0, -1, -1, "UDT::~UDT()" )
end scope

DLOG( constructor UDT( byref rhs as const long ) )
scope
	dim a as long = 1
	resetChecks()
	dim b as UDT = a
	checkResults( @b, @a, -1, 1, 1, "UDT::UDT( int const& rhs )" )
	assert( b.value = 1 )
end scope

DLOG( constructor UDT( byref rhs as const UDT ) )
scope
	dim a as UDT = 2
	resetChecks()
	dim b as UDT = a
	checkResults( @b, @a, -1, 2, 2, "UDT::UDT( UDT const& rhs )" )
	assert( b.value = 2 )
end scope

DLOG( sub UDT.method( byref rhs as const long ) )
scope
	dim a1 as long = 1, a2 as long = 2
	resetChecks()
	dim b as UDT = a1
	checkResults( @b, @a1, -1, 1, 1, "UDT::UDT( int const& rhs )" )
	b.method( a2 )
	checkResults( @b, @a2,  1, 2, 2, "void UDT::method( int const& rhs )" )
	assert( b.value = a2 )
end scope

DLOG( operator UDT.let( byref rhs as const UDT ) )
scope
	dim a as UDT = 2
	dim b as UDT
	resetChecks()
	b = a
	checkResults( @b, @a, 0, 2, 2, "UDT& UDT::operator=( UDT const& rhs )" )
	assert( b.value = 2 )
end scope


'' disable results for ctor/dtor/copy-ctor/let
setInitial( 0 )

/'
!!! TODO !!!
DLOG( operator UDT.+( byref rhs as const long ) )
scope
	dim as UDT a = 3
	dim as long b = 11
	dim as UDT c
	resetChecks()
	c = a + b
	checkResults( @a, @b, 3, 11, 14, "UDT::operator+( int rhs )" )
end scope

DLOG( operator UDT.-( byref rhs as const long ) as UDT )
scope
	dim as UDT a = 17
	dim as long b = 5
	dim as UDT c
	resetChecks()
	c = a - b
	checkResults( @a, @b, 17, 5, 12, "UDT::operator-( int rhs )" )
end scope
'/

#ifdef DOFUNCS
DLOG( operator +( byref lhs as const UDT, byref rhs as const UDT ) as UDT )
scope
	dim as UDT a = 3
	dim as UDT b = 11
	dim as UDT c
	resetChecks()
	c = (a + b)
	checkResults( @a, @b, 3, 11, 14, "UDT operator+( UDT const& lhs, UDT const& rhs )" )
end scope

DLOG( operator -( byref lhs as const UDT, byref rhs as const UDT ) as UDT )
scope
	dim as UDT a = 17
	dim as UDT b = 5
	dim as UDT c
	resetChecks()
	c = a - b
	checkResults( @a, @b, 17, 5, 12, "UDT operator-( UDT const& lhs, UDT const& rhs )" )
end scope

DLOG( operator +( byref lhs as const long, byref rhs as const UDT ) as UDT )
scope
	dim as long a = 3
	dim as UDT b = 11
	dim as UDT c
	resetChecks()
	c = a + b
	checkResults( @a, @b, 3, 11, 14, "UDT operator+( int const& lhs, UDT const& rhs )" )
end scope

DLOG( operator -( byref lhs as const long, byref rhs as const UDT ) as UDT )
scope
	dim as long a = 17
	dim as UDT b = 5
	dim as UDT c
	resetChecks()
	c = a - b
	checkResults( @a, @b, 17, 5, 12, "UDT operator-( int const& lhs, UDT const& rhs )" )
end scope
#endif

#endif '' DOTEST
