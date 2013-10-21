# include "fbcu.bi"

namespace fbc_tests.pointers.new_delete

private sub newIntFloatInit cdecl( )
	#macro check( T, N )
		scope
			var p = new T( N )
			CU_ASSERT( *p = N )
			delete p
		end scope
	#endmacro

	check( byte, cbyte( 0 ) )
	check( byte, cbyte( -128 ) )
	check( byte, cbyte( 127 ) )
	check( ubyte, cubyte( 0 ) )
	check( ubyte, cubyte( 255 ) )
	check( short, cbyte( 0 ) )
	check( short, cshort( -32768 ) )
	check( short, cshort( 32767 ) )
	check( short, -15 )
	check( ushort, cushort( 0 ) )
	check( ushort, cushort( 65535 ) )
	check( long, 0l )
	check( long, &h80000000l )
	check( long, &h7FFFFFFFl )
	check( ulong, 0ul )
	check( ulong, &hFFFFFFFFul )
	check( longint, 0ll )
	check( longint, &h8000000000000000ll )
	check( longint, &h7FFFFFFFFFFFFFFFll )
	check( ulongint, 0ull )
	check( ulongint, &hFFFFFFFFFFFFFFFFull )

	check( integer, 0 )
	check( integer, &h80000000 )
	check( integer, &h7FFFFFFF )
	check( integer, 5 )
	check( uinteger, 0u )
	check( uinteger, &hFFFFFFFFu )
#ifdef __FB_64BIT__
	check( integer, 0ll )
	check( integer, &h8000000000000000ll )
	check( integer, &h7FFFFFFFFFFFFFFFll )
	check( uinteger, 0ull )
	check( uinteger, &hFFFFFFFFFFFFFFFFull )
#endif

	check( single, 0.0f )
	check( single, 2.5f )
	check( single, 2.5 )
	check( single, 1.0 )
	check( single, -1.0 )
	check( double, 0.0 )
	check( double, 0.5 )
	check( double, 1.0 )
	check( double, -1.0 )
end sub

private sub newUDTInit cdecl( )
	type T1
		as integer a, b, c
		as single d
	end type

	type T2
		as byte a
		as short b
		as integer c
		as double d
	end type

	type T3
		as integer i
	end type

	type T4
		as single f
	end type

	scope
		var p = new T1( 1, 2, 3, 4 )

		CU_ASSERT( p->a = 1 )
		CU_ASSERT( p->b = 2 )
		CU_ASSERT( p->c = 3 )
		CU_ASSERT( p->d = 4 )

		delete p
	end scope

	scope
		dim as T1 x = ( 4, 5, 6, 7 )
		dim as T1 ptr p = new T1( x )

		CU_ASSERT( p->a = 4 )
		CU_ASSERT( p->b = 5 )
		CU_ASSERT( p->c = 6 )
		CU_ASSERT( p->d = 7 )

		delete p
	end scope

	scope
		dim as T1 ptr a = new T1( 1, 2, 3, 4 )
		dim as T1 ptr b = new T1( *a )

		CU_ASSERT( a->a = 1 )
		CU_ASSERT( a->b = 2 )
		CU_ASSERT( a->c = 3 )
		CU_ASSERT( a->d = 4 )

		CU_ASSERT( b->a = 1 )
		CU_ASSERT( b->b = 2 )
		CU_ASSERT( b->c = 3 )
		CU_ASSERT( b->d = 4 )

		delete b
		delete a
	end scope

	scope
		var p = new T2( 123, 12345, 123456789 )

		CU_ASSERT( p->a = 123 )
		CU_ASSERT( p->b = 12345 )
		CU_ASSERT( p->c = 123456789 )
		CU_ASSERT( p->d = 0.0 )

		delete p
	end scope

	scope
		dim as T3 x1 = ( 123 )
		dim as T4 x2 = ( 2.5 )

		var a = new T3( 123 )
		var b = new T3( *a )
		var c = new T4( 2.5 )
		var d = new T3( x1 )
		var e = new T4( x2 )
		var f = new T1( 1, 2, 3, 2.5 )

		CU_ASSERT( a->i = 123 )
		CU_ASSERT( b->i = 123 )
		CU_ASSERT( c->f = 2.5 )
		CU_ASSERT( d->i = 123 )
		CU_ASSERT( e->f = 2.5 )
		CU_ASSERT( f->a = 1 )
		CU_ASSERT( f->b = 2 )
		CU_ASSERT( f->c = 3 )
		CU_ASSERT( f->d = 2.5 )

		delete a
		delete b
		delete c
		delete d
		delete e
		delete f
	end scope
end sub

namespace newQuirkInit
	'' An UDT that fits in registers
	type T1
		as integer i
	end type

	'' A bigger UDT that must be put on stack
	type T2
		as integer a, b, c, d, e, f
	end type

	private function getT1( ) as T1
		function = type( 123 )
	end function

	private function getT2( ) as T2
		function = type( 1, 2, 3, 4, 5, 6 )
	end function

	private function getInteger( ) as integer
		function = 123
	end function

	private function getLongint( ) as longint
		function = 123ll
	end function

	private function getSingle( ) as single
		function = 2.5f
	end function

	private function getDouble( ) as double
		function = 2.5
	end function

	private sub test cdecl( )
		var a1 = new T1( getT1( ) )
		var b1 = new T1( type<T1>( 123 ) )
		var c1 = new T1( type( 123 ) )
		var a2 = new T2( getT2( ) )
		var b2 = new T2( type<T2>( 1, 2, 3, 4, 5, 6 ) )
		var c2 = new T2( type( 1 ) )  '' TODO: type( 1, 2, 3, 4, 5, 6 ) isn't working here!
		var d = new integer( getInteger( ) )
		var e = new longint( getLongint( ) )
		var f = new single( getSingle( ) )
		var g = new double( getDouble( ) )
		CU_ASSERT( a1->i = 123 )
		CU_ASSERT( b1->i = 123 )
		CU_ASSERT( c1->i = 123 )
		CU_ASSERT( a2->a = 1 )
		CU_ASSERT( a2->b = 2 )
		CU_ASSERT( a2->c = 3 )
		CU_ASSERT( a2->d = 4 )
		CU_ASSERT( a2->e = 5 )
		CU_ASSERT( a2->f = 6 )
		CU_ASSERT( b2->a = 1 )
		CU_ASSERT( b2->b = 2 )
		CU_ASSERT( b2->c = 3 )
		CU_ASSERT( b2->d = 4 )
		CU_ASSERT( b2->e = 5 )
		CU_ASSERT( b2->f = 6 )
		CU_ASSERT( c2->a = 1 )
		CU_ASSERT( c2->b = 0 )
		CU_ASSERT( c2->c = 0 )
		CU_ASSERT( c2->d = 0 )
		CU_ASSERT( c2->e = 0 )
		CU_ASSERT( c2->f = 0 )
		CU_ASSERT( *d = 123 )
		CU_ASSERT( *e = 123ll )
		CU_ASSERT( *f = 2.5f )
		CU_ASSERT( *g = 2.5 )
		delete a1
		delete b1
		delete c1
		delete a2
		delete b2
		delete c2
		delete d
		delete e
		delete f
		delete g
	end sub
end namespace

namespace vectorNew
	type T1
		as integer i
	end type

	dim shared as integer T2_ctor_count = 0
	type T2
		as integer i
		declare constructor( )
	end type
	constructor T2( )
		T2_ctor_count += 1
	end constructor

	dim shared as integer T3_dtor_count = 0
	type T3
		as integer i
		declare destructor( )
	end type
	destructor T3( )
		T3_dtor_count += 1
	end destructor

	dim shared as integer T4_ctor_count = 0, T4_dtor_count = 0
	type T4
		as integer i
		declare constructor( )
		declare destructor( )
	end type
	constructor T4( )
		T4_ctor_count += 1
	end constructor
	destructor T4( )
		T4_dtor_count += 1
	end destructor

	private sub test cdecl( )
		scope
			var p = new T1[2]
			CU_ASSERT( p[0].i = 0 )
			CU_ASSERT( p[1].i = 0 )
			delete[] p
		end scope

		scope
			var p = new T1[3]
			CU_ASSERT( p[0].i = 0 )
			CU_ASSERT( p[1].i = 0 )
			CU_ASSERT( p[2].i = 0 )
			delete[] p
		end scope

		scope
			CU_ASSERT( T2_ctor_count = 0 )
			var p = new T2[2]
			CU_ASSERT( T2_ctor_count = 2 )
			delete[] p
		end scope

		scope
			CU_ASSERT( T3_dtor_count = 0 )
			var p = new T3[2]
			CU_ASSERT( T3_dtor_count = 0 )
			delete[] p
			CU_ASSERT( T3_dtor_count = 2 )
		end scope

		scope
			CU_ASSERT( T4_ctor_count = 0 )
			CU_ASSERT( T4_dtor_count = 0 )
			var p = new T4[2]
			CU_ASSERT( T4_ctor_count = 2 )
			CU_ASSERT( T4_dtor_count = 0 )
			delete[] p
			CU_ASSERT( T4_ctor_count = 2 )
			CU_ASSERT( T4_dtor_count = 2 )
		end scope
	end sub
end namespace

namespace newAsFieldInit
	type T
		declare constructor( )
		declare destructor( )
		as short ptr a = new short[8]
		as short ptr ptr b = new short ptr[8]
		as integer ptr pi1 = new integer[3]
		as integer ptr pi2 = new integer( 123 )
	end type

	constructor T( )
		CU_ASSERT( a <> NULL )
		CU_ASSERT( b <> NULL )
		CU_ASSERT( pi1 <> NULL )
		CU_ASSERT( pi1[0] = 0 )
		CU_ASSERT( pi1[1] = 0 )
		CU_ASSERT( pi1[2] = 0 )
		CU_ASSERT( pi2 <> NULL )
		CU_ASSERT( *pi2 = 123 )
	end constructor

	destructor T( )
		delete[] a
		delete[] b
		delete[] pi1
		delete pi2
	end destructor

	private sub test cdecl( )
		dim as t a, b, c, d, e, f
	end sub
end namespace

namespace newSideFx
	dim shared as integer count

	function f( ) as integer
		count += 1
		function = 123
	end function

	private sub test cdecl( )
		CU_ASSERT( count = 0 )
		var p = new integer( f( ) )
		CU_ASSERT( *p = 123 )
		CU_ASSERT( count = 1 )
		delete p
	end sub
end namespace

namespace vectorNewSideFx
	dim shared as integer calls

	function f( ) as integer
		calls += 1
		function = 2
	end function

	type DtorUDT
		i as integer
		declare destructor( )
	end type

	destructor DtorUDT( )
	end destructor

	sub test cdecl( )
		'' new type[elementsexpr]

		scope
			CU_ASSERT( calls = 0 )

			'' p = allocate( elementsexpr * sizeof( type ) )
			var p = new integer[f( )] { any }

			CU_ASSERT( calls = 1 )
			calls = 0

			delete[] p
		end scope

		scope
			CU_ASSERT( calls = 0 )

			'' p = allocate( elementsexpr * sizeof( type ) )
			'' memclear( *p, elementsexpr * sizeof( type ) )
			var p = new integer[f( )]

			CU_ASSERT( calls = 1 )
			calls = 0

			delete[] p
		end scope

		scope
			CU_ASSERT( calls = 0 )

			'' p = allocate( (elementsexpr * sizeof( type )) + sizeof( integer ) )
			'' *p = elementsexpr
			'' p = cptr( any ptr, p ) + sizeof( integer )
			var p = new DtorUDT[f( )] { any }

			CU_ASSERT( calls = 1 )
			calls = 0

			delete[] p
		end scope

		scope
			CU_ASSERT( calls = 0 )

			'' p = allocate( (elementsexpr * sizeof( type )) + sizeof( integer ) )
			'' *p = elementsexpr
			'' p = cptr( any ptr, p ) + sizeof( integer )
			'' memclear( *p, elementsexpr * sizeof( type ) )
			var p = new DtorUDT[f( )]

			CU_ASSERT( calls = 1 )
			calls = 0

			delete[] p
		end scope
	end sub
end namespace

namespace vectorNewCtorList
	type UDT
		i as integer
	end type

	type ClassUDT
		i as integer
		declare constructor( )
	end type

	constructor ClassUDT( )
		this.i = 123
	end constructor

	function f( byval p as ClassUDT ptr ) as UDT
		function = type( p->i )
	end function

	sub test cdecl( )
		dim x as UDT
		CU_ASSERT( x.i = 0 )
		x = f( new ClassUDT[1] )
		CU_ASSERT( x.i = 123 )
	end sub
end namespace

namespace vectorNewComplexElements
	dim shared as integer ctors, dtors

	type ClassUdt
		i as integer
		declare constructor( )
		declare destructor( )
	end type

	constructor ClassUdt( )
		ctors += 1
	end constructor

	destructor ClassUdt( )
		dtors += 1
	end destructor

	type UDT
		i as integer
	end type

	sub test cdecl( )
		ctors = 0
		dtors = 0
		scope
			var p = new ClassUdt[iif( (type<UDT>( (type<UDT>( 123 )).i )).i = 123, 4, 8 )]
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( dtors = 0 )
			delete[] p
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( dtors = 4 )
		end scope
		CU_ASSERT( ctors = 4 )
		CU_ASSERT( dtors = 4 )

		ctors = 0
		dtors = 0
		scope
			var p = new ClassUdt[iif( (type<UDT>( (type<UDT>( 123 )).i )).i = 456, 4, 8 )]
			CU_ASSERT( ctors = 8 )
			CU_ASSERT( dtors = 0 )
			delete[] p
			CU_ASSERT( ctors = 8 )
			CU_ASSERT( dtors = 8 )
		end scope
		CU_ASSERT( ctors = 8 )
		CU_ASSERT( dtors = 8 )
	end sub
end namespace

'' #3509495 regression test
namespace deleteDerivedPtr
	type Parent
		as integer i
	end type

	type Child extends Parent
		declare constructor( )
		declare destructor( )
	end type

	constructor Child( )
		base.i = 123
	end constructor

	destructor Child( )
	end destructor

	private sub test cdecl( )
		scope
			var p = new Child( )
			CU_ASSERT( p->i = 123 )
			delete p
		end scope

		scope
			dim as Child ptr p = new Child[5]
			for i as integer = 0 to 4
				CU_ASSERT( p[i].i = 123 )
			next
			delete[] p
		end scope
	end sub
end namespace

namespace deleteSideFx1
	dim shared as integer count
	dim shared as integer ptr p

	function f( ) as integer ptr
		count += 1
		function = p
	end function

	private sub test cdecl( )
		p = new integer( 123 )
		CU_ASSERT( *p = 123 )
		CU_ASSERT( count = 0 )
		delete f( )
		CU_ASSERT( count = 1 )
	end sub
end namespace

namespace deleteSideFx2
	dim shared as integer count
	dim shared as integer ptr p

	function f( ) as integer ptr
		count += 1
		function = p
	end function

	private sub test cdecl( )
		p = new integer[5]
		CU_ASSERT( count = 0 )
		delete[] f( )
		CU_ASSERT( count = 1 )
	end sub
end namespace

namespace deleteSideFx3
	type T
		as integer i
		declare destructor( )
	end type

	destructor T( )
	end destructor

	dim shared as integer count
	dim shared as T ptr p

	function f( ) as T ptr
		count += 1
		function = p
	end function

	private sub test cdecl( )
		p = new T
		CU_ASSERT( count = 0 )
		delete f( )
		CU_ASSERT( count = 1 )
	end sub
end namespace

namespace deleteSideFx4
	type T
		as integer i
		declare destructor( )
	end type

	destructor T( )
	end destructor

	dim shared as integer count
	dim shared as T ptr p

	function f( ) as T ptr
		count += 1
		function = p
	end function

	private sub test cdecl( )
		p = new T[2]
		CU_ASSERT( count = 0 )
		delete[] f( )
		CU_ASSERT( count = 1 )
	end sub
end namespace

namespace deleteNull
	type T
		as integer i
		declare destructor( )
	end type

	destructor T( )
		'' Shouldn't be called
		CU_FAIL( )
	end destructor

	private sub test cdecl( )
		dim as T ptr a = 0
		CU_ASSERT( a = 0 )
		delete a
		delete[] a

		dim as T ptr b(0 to 0) = { 0 }
		CU_ASSERT( b(0) = 0 )
		delete b(0)
		delete[] b(0)
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/pointers/new-delete" )
	fbcu.add_test( "New with int/float initializer", @newIntFloatInit )
	fbcu.add_test( "New with UDT initializer", @newUDTInit )
	fbcu.add_test( "Some obscure NEW initializers", @newQuirkInit.test )
	fbcu.add_test( "New[]", @vectorNew.test )
	fbcu.add_test( "New as field initializer", @newAsFieldInit.test )
	fbcu.add_test( "New + side-effects", @newSideFx.test )
	fbcu.add_test( "New[sidefx]", @vectorNewSideFx.test )
	fbcu.add_test( "new[iif + TYPEINIs]", @vectorNewComplexElements.test )
	fbcu.add_test( "Delete on derived UDT pointers", @deleteDerivedPtr.test )
	fbcu.add_test( "Delete + side-effects 1", @deleteSideFx1.test )
	fbcu.add_test( "Delete + side-effects 2", @deleteSideFx2.test )
	fbcu.add_test( "Delete + side-effects 3", @deleteSideFx3.test )
	fbcu.add_test( "Delete + side-effects 4", @deleteSideFx4.test )
	fbcu.add_test( "Delete on NULL pointer", @deleteNull.test )
end sub

end namespace
