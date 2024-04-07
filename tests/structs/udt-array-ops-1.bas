#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_array_ops_1 )

	#macro setArray( expr )
		for i as integer = lbound(array) to ubound(array)
			expr
		next
	#endmacro

	#macro chkArray( expr1, expr2 )
		for i as integer = 0 to 9
			CU_ASSERT( (expr1) = (expr2) )
		next
	#endmacro

	type T
		myarray(any) as integer
		declare constructor( array() as integer )
		declare operator let( array() as integer )
		declare operator +=( array() as integer )
		declare operator -=( array() as integer )
		declare constructor()
	end type

	constructor T()
	end constructor

	constructor T( array() as integer )
		redim myarray( lbound(array) to ubound(array) )
		setArray( myarray(i) = array(i) )
	end constructor

	operator T.let( array() as integer )
		redim myarray( lbound(array) to ubound(array) )
		setArray( myarray(i) = array(i) )
	end operator

	operator T.+=( array() as integer )
		setArray( myarray(i) += array(i) )
	end operator

	operator T.-=( array() as integer )
		setArray( myarray(i) -= array(i) )
	end operator

	TEST( default )
		dim a( 0 to 9 ) as integer = { 2,3,5,7,11,13,17,19,23,29 }
		dim b( 0 to 9 ) as integer = { 1,2,3,4, 5, 6, 7, 8, 9,10 }
		dim c( 0 to 9 ) as integer = { 1,1,1,1, 1, 1, 1, 1, 1, 1 }

		dim x as T = a( )
		chkArray( x.myarray(i), a(i) )

		dim y as T ptr = new T( b() )
		chkArray( y->myarray(i), b(i) )

		dim z as T = c()
		z = a()
		chkArray( z.myarray(i), a(i) )

		dim pz as T ptr = @z
		*pz = b()
		chkArray( pz->myarray(i), b(i) )

		x = c()
		chkArray( x.myarray(i), c(i) )

		x += a()
		chkArray( x.myarray(i), a(i) + c(i) )

		x -= c()
		chkArray( x.myarray(i), a(i) )

		*y = c()
		chkArray( y->myarray(i), c(i) )

		*y += a()
		chkArray( y->myarray(i), a(i) + c(i) )

		*y -= c()
		chkArray( y->myarray(i), a(i) )

		delete y

	END_TEST

	type U
		dim a( 0 to 9 ) as integer = { 2,3,5,7,11,13,17,19,23,29 }
		dim b( 0 to 9 ) as integer = { 1,2,3,4, 5, 6, 7, 8, 9,10 }
		dim c( 0 to 9 ) as integer = { 1,1,1,1, 1, 1, 1, 1, 1, 1 }

		redim o(any) as T
		redim po(any) as T ptr

		declare constructor()
	end type

	constructor U()
		dim h( 0 to 9 ) as integer = { 2,3,5,7,11,13,17,19,23,29 }

		redim o(1 to 3) as T
		o(1) = h()
		o(2) = b()
		o(3) = this.c()

		redim this.po(1 to 3) as T ptr
		po(1) = @o(1)
		po(2) = @o(2)
		po(3) = @o(3)

	end constructor

	TEST( member )

		dim x as U
		x.o(1) = x.a()
		chkArray( x.o(1).myarray(i), x.a(i) )

		dim y as U ptr = new U
		y->o(1) = x.b()
		chkArray( y->o(1).myarray(i), x.b(i) )

		dim z as U
		z.o(1) = x.a()
		chkArray( z.o(1).myarray(i), x.a(i) )

		dim pz as U ptr = @z
		pz->o(1) = x.b()
		chkArray( pz->o(1).myarray(i), x.b(i) )

		x.o(1) = x.c()
		chkArray( x.o(1).myarray(i), x.c(i) )

		x.o(1) += x.a()
		chkArray( x.o(1).myarray(i), x.a(i) + x.c(i) )

		x.o(1) -= x.c()
		chkArray( x.o(1).myarray(i), x.a(i) )

		y->o(1) = x.c()
		chkArray( y->o(1).myarray(i), x.c(i) )

		y->o(1) += x.a()
		chkArray( y->o(1).myarray(i), x.a(i) + x.c(i) )

		y->o(1) -= x.c()
		chkArray( y->o(1).myarray(i), x.a(i) )

		delete y

	END_TEST

END_SUITE
