# include "fbcunit.bi"

SUITE( fbc_tests.dim_.udt_init )

	TEST_GROUP( initObject )
		type rational
			num as integer
			den as integer
		end type

		#define radd_num(l,r) ((l.num * r.den) + (l.den * r.num))
		#define radd_den(l,r) ((l.den * r.den))

		function add( lhs as rational, rhs as rational ) as rational
			dim as rational res

			res.num = radd_num( lhs, rhs )
			res.den = radd_den( lhs, rhs )

			function = res
		end function

		TEST( default )
			dim as rational rt(0 to 1) = _
			{ _
				add( type(1,2)   , type(3,4)   ), _
				add( type(-1,-2) , type(-3,-4) ) _
			}

			dim as rational l(0 to 1), r(0 to 1)

			l(0).num = 1: l(0).den = 2
			r(0).num = 3: r(0).den = 4
			l(1).num = -1: l(1).den = -2
			r(1).num = -3: r(1).den = -4

			CU_ASSERT( rt(0).num = radd_num( l(0), r(0) ) )
			CU_ASSERT( rt(0).den = radd_den( l(0), r(0) ) )
			CU_ASSERT( rt(1).num = radd_num( l(1), r(1) ) )
			CU_ASSERT( rt(1).den = radd_den( l(1), r(1) ) )
		END_TEST

		type mytype
			as integer a, b
			as short c(0 to 2)
			as byte d
		end type

		TEST( initStatic )
			static arraytype(10) as mytype => { ( 1, 2, { 3, 4, 5 }, 6 ), ( 1*2, 2*2, { 3*2, 4*2, 5*2 }, 6*2 ) }
			CU_ASSERT( arraytype(0).c(1) = 4 )
			CU_ASSERT( arraytype(0).d = 6 )
			CU_ASSERT( arraytype(1).c(1) = 4*2 )
			CU_ASSERT( arraytype(1).d = 6*2 )
		END_TEST

		TEST( initAuto )
			dim arraytype(10) as mytype => { ( 1, 2, { 3, 4, 5 }, 6 ), ( 1*2, 2*2, { 3*2, 4*2, 5*2 }, 6*2 ) }
			CU_ASSERT( arraytype(0).c(1) = 4 )
			CU_ASSERT( arraytype(0).d = 6 )
			CU_ASSERT( arraytype(1).c(1) = 4*2 )
			CU_ASSERT( arraytype(1).d = 6*2 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( padding )
		TEST( padding1 )
			dim as integer array(0 to 9) = { 0, 1, 2, 3, 4 }
			dim as integer i
			for i = 0 to 4
				CU_ASSERT( array(i) = i )
			next
			for i = 5 to 9
				CU_ASSERT( array(i) = 0 )
			next
		END_TEST

		type tudt
			as integer f0, f1, f2, f3, f4, f5
		end type

		TEST( padding2 )
			dim as tudt udt = ( 0, 1, 2 )
			with udt
				CU_ASSERT( .f0 = 0 )
				CU_ASSERT( .f1 = 1 )
				CU_ASSERT( .f2 = 2 )
				CU_ASSERT( .f3 = 0 )
				CU_ASSERT( .f4 = 0 )
				CU_ASSERT( .f5 = 0 )
			end with
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( anyinit )
		dim shared as integer ctor_count

		type T
			declare constructor( )
			as integer i
		end type

		constructor T( )
			ctor_count += 1
		end constructor

		'= ANY' UDT variable initializer
		TEST( default )
			CU_ASSERT( ctor_count = 0 )
			scope
				dim as T x = any
				CU_ASSERT( ctor_count = 0 )
				x.constructor( )
				CU_ASSERT( ctor_count = 1 )
			end scope
			CU_ASSERT( ctor_count = 1 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( obj1 )
		type T
			declare constructor
			declare constructor (i as integer)
			declare operator let (byref x as T)
			as integer i, j, k, l, m
		end type

		constructor T
		end constructor

		constructor T (i as integer)
		end constructor

		operator T.let (byref x as T)
		end operator

		function f () as T
			return T(420)
		end function

		TEST( default )
			dim x as T = f( )
			with x
				CU_ASSERT( (.i or .j or .k or .l or .m) = 0 )
			end with
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( obj2 )
		type T
			declare constructor
			declare constructor (i as integer)
			declare operator let (byref x as T)
			as integer i = 1, j = 2, k = 3, l = 4, m = 5
		end type

		constructor T
		end constructor

		constructor T (i as integer)
		end constructor

		operator T.let (byref x as T)
		end operator

		function f () as T
			return T(420)
		end function

		TEST( default )
			dim x as T = f( )
			with x
				CU_ASSERT( (.i + .j + .k + .l + .m) = 15 )
			end with
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( obj3 )
		type T
			declare constructor
			declare constructor (i as integer)
			declare operator let (byref x as T)
			as integer i, j, k, l, m
		end type

		constructor T
			i = 12345
		end constructor

		constructor T (i as integer)
			this.i = i
		end constructor

		operator T.let (byref x as T)
		end operator

		function f () as T
			return T(420)
		end function

		TEST( default )
			dim x as T = f( )
			with x
				CU_ASSERT( ( .i = 420 ) )
				CU_ASSERT( ( .j = 0 ) )
				CU_ASSERT( ( .k = 0 ) )
				CU_ASSERT( ( .l = 0 ) )
				CU_ASSERT( ( .m = 0 ) )
			end with
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( derived )
		type UDT1
			as integer i11, i12
		end type

		type UDT2 extends UDT1
			as integer i21, i22, i23, i24
		end type

		type UDT3 extends UDT2
			as integer i31, i32, i33
		end type

		type UDT4 extends UDT3
			as integer i41, i42, i43, i44, i45
		end type

		type UDT5 extends UDT4
			as integer i51, i52, i53, i54, i55
		end type

		TEST( default )
			dim u1 as UDT5 = ( 1, 2, 3, 4, 5, 6, 7, 8, 9 )
			dim u2 as UDT5
			u2 = type( 1, 2, 3, 4, 5, 6, 7, 8, 9 )

			CU_ASSERT( u1.i11 = 1 )
			CU_ASSERT( u1.i12 = 2 )
			CU_ASSERT( u1.i21 = 3 )
			CU_ASSERT( u1.i22 = 4 )
			CU_ASSERT( u1.i23 = 5 )
			CU_ASSERT( u1.i24 = 6 )
			CU_ASSERT( u1.i31 = 7 )
			CU_ASSERT( u1.i32 = 8 )
			CU_ASSERT( u1.i33 = 9 )
			CU_ASSERT( u1.i41 = 0 )
			CU_ASSERT( u1.i42 = 0 )
			CU_ASSERT( u1.i43 = 0 )
			CU_ASSERT( u1.i44 = 0 )
			CU_ASSERT( u1.i45 = 0 )
			CU_ASSERT( u1.i51 = 0 )
			CU_ASSERT( u1.i52 = 0 )
			CU_ASSERT( u1.i53 = 0 )
			CU_ASSERT( u1.i54 = 0 )
			CU_ASSERT( u1.i55 = 0 )

			CU_ASSERT( u2.i11 = 1 )
			CU_ASSERT( u2.i12 = 2 )
			CU_ASSERT( u2.i21 = 3 )
			CU_ASSERT( u2.i22 = 4 )
			CU_ASSERT( u2.i23 = 5 )
			CU_ASSERT( u2.i24 = 6 )
			CU_ASSERT( u2.i31 = 7 )
			CU_ASSERT( u2.i32 = 8 )
			CU_ASSERT( u2.i33 = 9 )
			CU_ASSERT( u2.i41 = 0 )
			CU_ASSERT( u2.i42 = 0 )
			CU_ASSERT( u2.i43 = 0 )
			CU_ASSERT( u2.i44 = 0 )
			CU_ASSERT( u2.i45 = 0 )
			CU_ASSERT( u2.i51 = 0 )
			CU_ASSERT( u2.i52 = 0 )
			CU_ASSERT( u2.i53 = 0 )
			CU_ASSERT( u2.i54 = 0 )
			CU_ASSERT( u2.i55 = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dtorOnly )
		type DtorUDT
			i as integer
			declare destructor( )
		end type

		destructor DtorUDT( )
		end destructor

		'' The initializer should be emitted as for any other global,
		'' despite the UDT having a dtor.
		dim shared as DtorUDT globalx1 = ( 123 )

		'' dtor-UDT init
		TEST( default )
			'' ditto
			static as DtorUDT staticx1 = ( 123 )

			dim as DtorUDT localx1 = ( 123 )

			CU_ASSERT( globalx1.i = 123 )
			CU_ASSERT( staticx1.i = 123 )
			CU_ASSERT( localx1.i = 123 )
		END_TEST
	END_TEST_GROUP

END_SUITE
