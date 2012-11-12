# include "fbcu.bi"

namespace fbc_tests.virt.virt

namespace declarations
	type A extends object
		declare				function f01( ) as integer
		declare		virtual		function f02( ) as integer
		declare		virtual		function f03( ) as integer
		declare	const	virtual		function f04( ) as integer
		declare	const	virtual		function f05( ) as integer
		declare	const	virtual		function f06( ) as integer
		declare	const	virtual		function f07( ) as integer
		declare		abstract	function f08( ) as integer
		declare		abstract	function f09( ) as integer
		declare	const	abstract	function f10( ) as integer
		declare	const	abstract	function f11( ) as integer
		declare	const	abstract	function f12( ) as integer
		declare	const	abstract	function f13( ) as integer
	end type

				function A.f01( ) as integer : function = 1 : end function
				function A.f02( ) as integer : function = 2 : end function
		virtual		function A.f03( ) as integer : function = 3 : end function
				function A.f04( ) as integer : function = 4 : end function
	const			function A.f05( ) as integer : function = 5 : end function
		virtual		function A.f06( ) as integer : function = 6 : end function
	const	virtual		function A.f07( ) as integer : function = 7 : end function

	sub test cdecl( )
		dim x as A
		CU_ASSERT( x.f01( ) = 1 )
		CU_ASSERT( x.f02( ) = 2 )
		CU_ASSERT( x.f03( ) = 3 )
		CU_ASSERT( x.f04( ) = 4 )
		CU_ASSERT( x.f05( ) = 5 )
		CU_ASSERT( x.f06( ) = 6 )
		CU_ASSERT( x.f07( ) = 7 )
	end sub
end namespace

namespace overridingWorks
	type A extends object
		i as integer
		declare constructor( byval j as integer )
		declare abstract sub add( byval j as integer )
		declare virtual sub subtract( byval j as integer )
		declare virtual function toString( ) as string
	end type

	constructor A( byval j as integer )
		this.i = j
	end constructor

	sub A.subtract( byval j as integer )
		this.i -= j
	end sub

	function A.toString( ) as string
		function = str( this.i )
	end function

	type B extends A
		declare constructor( )
		declare constructor( byref as B )
		declare constructor( byval j as integer )
		declare sub add( byval j as integer )
		declare function toString( ) as string
	end type

	constructor B( byval j as integer )
		base( j )
	end constructor

	sub B.add( byval j as integer )
		this.i += j
	end sub

	function B.toString( ) as string
		function = "&h" + hex( this.i, 8 )
	end function

	sub testAToByrefA( byref ra as A )
		CU_ASSERT( ra.i = 10 ) : CU_ASSERT( ra.toString( ) = "10" )
		ra.subtract( 4 )
		CU_ASSERT( ra.i =  6 ) : CU_ASSERT( ra.toString( ) = "6" )
	end sub

	sub testBToByrefA( byref ra as A )
		CU_ASSERT( ra.i = 16 ) : CU_ASSERT( ra.toString( ) = "&h00000010" )
		ra.subtract( 10 )
		CU_ASSERT( ra.i =  6 ) : CU_ASSERT( ra.toString( ) = "&h00000006" )
		ra.add( 4 )
		CU_ASSERT( ra.i = 10 ) : CU_ASSERT( ra.toString( ) = "&h0000000A" )
	end sub

	sub testBToByrefB( byref rb as B )
		CU_ASSERT( rb.i = 10 ) : CU_ASSERT( rb.toString( ) = "&h0000000A" )
		rb.subtract( 10 )
		CU_ASSERT( rb.i =  0 ) : CU_ASSERT( rb.toString( ) = "&h00000000" )
		rb.add( 4 )
		CU_ASSERT( rb.i =  4 ) : CU_ASSERT( rb.toString( ) = "&h00000004" )
	end sub

	sub test cdecl( )
		dim xa as A = A( 10 )
		CU_ASSERT( xa.i = 10 ) : CU_ASSERT( xa.toString( ) = "10" )
		xa.subtract( 4 )
		CU_ASSERT( xa.i =  6 ) : CU_ASSERT( xa.toString( ) = "6" )

		dim xb as B = B( 10 )
		CU_ASSERT( xb.i = 10 ) : CU_ASSERT( xb.toString( ) = "&h0000000A" )
		xb.subtract( 4 )
		CU_ASSERT( xb.i =  6 ) : CU_ASSERT( xb.toString( ) = "&h00000006" )
		xb.add( 5 )
		CU_ASSERT( xb.i = 11 ) : CU_ASSERT( xb.toString( ) = "&h0000000B" )

		dim pa as A ptr = @xa
		CU_ASSERT( pa->i =  6 ) : CU_ASSERT( pa->toString( ) = "6" )
		pa->subtract( -4 )
		CU_ASSERT( pa->i = 10 ) : CU_ASSERT( pa->toString( ) = "10" )

		pa = @xb
		CU_ASSERT( pa->i = 11 ) : CU_ASSERT( pa->toString( ) = "&h0000000B" )
		pa->subtract( 1 )
		CU_ASSERT( pa->i = 10 ) : CU_ASSERT( pa->toString( ) = "&h0000000A" )
		pa->add( 6 )
		CU_ASSERT( pa->i = 16 ) : CU_ASSERT( pa->toString( ) = "&h00000010" )

		testAToByrefA( xa )
		testBToByrefA( xb )
		testBToByrefB( xb )
	end sub
end namespace

namespace overridingVsShadowing
	type A extends object
		declare virtual function f1( ) as integer  '' overridable
		declare         function f2( ) as integer  '' shadowable
	end type

	function A.f1( ) as integer
		function = &hA1
	end function

	function A.f2( ) as integer
		function = &hA2
	end function

	type B extends A
		declare function f1( ) as integer  '' overrides
		declare function f2( ) as integer  '' shadows
	end type

	function B.f1( ) as integer
		function = &hB1
	end function

	function B.f2( ) as integer
		function = &hB2
	end function

	sub testAToByrefA( byref ra as A )
		CU_ASSERT( ra.f1( ) = &hA1 )  '' vtable lookup, not overridden
		CU_ASSERT( ra.f2( ) = &hA2 )
	end sub

	sub testBToByrefA( byref ra as A )
		CU_ASSERT( ra.f1( ) = &hB1 )  '' vtable lookup, overridden
		CU_ASSERT( ra.f2( ) = &hA2 )
	end sub

	sub testBToByrefB( byref rb as B )
		CU_ASSERT( rb.f1( ) = &hB1 )
		CU_ASSERT( rb.f2( ) = &hB2 )
	end sub

	sub test cdecl( )
		dim xa as A
		CU_ASSERT( xa.f1( ) = &hA1 )
		CU_ASSERT( xa.f2( ) = &hA2 )

		dim xb as B
		CU_ASSERT( xb.f1( ) = &hB1 )
		CU_ASSERT( xb.f2( ) = &hB2 )

		dim pa as A ptr

		'' A ptr pointing to A object
		pa = @xa
		CU_ASSERT( pa->f1( ) = &hA1 )  '' vtable lookup, not overridden
		CU_ASSERT( pa->f2( ) = &hA2 )

		'' A ptr pointing to B object (which is a specialized A object)
		pa = @xb
		CU_ASSERT( pa->f1( ) = &hB1 )  '' vtable lookup, overridden
		CU_ASSERT( pa->f2( ) = &hA2 )

		testAToByrefA( xa )
		testBToByrefA( xb )
		testBToByrefB( xb )
	end sub
end namespace

namespace differentSignatureIsntOverridden
	type A extends object
		declare virtual function f1( ) as integer
	end type

	function A.f1( ) as integer
		function = &hA1
	end function

	type B extends A
		'' different signature, should not override
		declare function f1( byval i as integer ) as integer
	end type

	function B.f1( byval i as integer ) as integer
		function = &hB1
	end function

	sub test cdecl( )
		dim pa as A ptr
		dim xb as B
		pa = @xb
		CU_ASSERT( pa->f1( ) = &hA1 )  '' vtable lookup, not overridden
		CU_ASSERT( xb.f1( 123 ) = &hB1 )
	end sub
end namespace

namespace virtualDtor
	dim shared as integer callsA, callsB

	type A extends object
		declare virtual destructor( )
	end type

	destructor A( )
		callsA += 1
	end destructor

	type B extends A
		declare destructor( )
	end type

	destructor B( )
		callsB += 1
	end destructor

	sub test cdecl( )
		callsA = 0 : callsB = 0
		scope
			dim x as A
		end scope
		CU_ASSERT( callsA = 1 ) : CU_ASSERT( callsB = 0 )

		callsA = 0 : callsB = 0
		scope
			dim x as B
		end scope
		CU_ASSERT( callsA = 1 ) : CU_ASSERT( callsB = 1 )

		callsA = 0 : callsB = 0
		scope
			dim p as A ptr = new A
			delete p
		end scope
		CU_ASSERT( callsA = 1 ) : CU_ASSERT( callsB = 0 )

		callsA = 0 : callsB = 0
		scope
			dim p as B ptr = new B
			delete p
		end scope
		CU_ASSERT( callsA = 1 ) : CU_ASSERT( callsB = 1 )

		callsA = 0 : callsB = 0
		scope
			dim p as A ptr = new B
			delete p
		end scope
		CU_ASSERT( callsA = 1 ) : CU_ASSERT( callsB = 1 )
	end sub
end namespace

namespace virtualDtorDestructsField
	dim shared as integer callsA, callsFA, callsB

	type FA
		dummy as integer
		declare destructor( )
	end type

	destructor FA( )
		callsFA += 1
	end destructor

	type A extends object
		f as FA
		declare virtual destructor( )
	end type

	destructor A( )
		callsA += 1
	end destructor

	type B extends A
		declare destructor( )
	end type

	destructor B( )
		callsB += 1
	end destructor

	sub test cdecl( )
		#macro check( stmt, expectedA, expectedFA, expectedB )
			callsA = 0
			callsFA = 0
			callsB = 0
			scope
				stmt
			end scope
			CU_ASSERT( callsA = expectedA )
			CU_ASSERT( callsFA = expectedFA )
			CU_ASSERT( callsB = expectedB )
		#endmacro

		check( dim x as A, 1, 1, 0 )
		check( dim x as B, 1, 1, 1 )
		check( dim p as A ptr = new A : delete p, 1, 1, 0 )
		check( dim p as B ptr = new B : delete p, 1, 1, 1 )

		'' A.dtor is virtual, so B.dtor will be called,
		'' and that in turn calls A.dtor
		check( dim p as A ptr = new B : delete p, 1, 1, 1 )
	end sub
end namespace

namespace virtualDtorDestructsBase
	dim shared as integer callsA, callsB, callsC

	type A extends object
		declare destructor( )
	end type

	destructor A( )
		callsA += 1
	end destructor

	type B extends A
		declare virtual destructor( )
	end type

	destructor B( )
		callsB += 1
	end destructor

	type C extends B
		declare destructor( )
	end type

	destructor C( )
		callsC += 1
	end destructor

	sub test cdecl( )
		#macro check( stmt, expectedA, expectedB, expectedC )
			callsA = 0
			callsB = 0
			callsC = 0
			scope
				stmt
			end scope
			CU_ASSERT( callsA = expectedA )
			CU_ASSERT( callsB = expectedB )
			CU_ASSERT( callsC = expectedC )
		#endmacro

		check( dim x as A, 1, 0, 0 )
		check( dim x as B, 1, 1, 0 )
		check( dim x as C, 1, 1, 1 )
		check( dim p as A ptr = new A : delete p, 1, 0, 0 )
		check( dim p as B ptr = new B : delete p, 1, 1, 0 )
		check( dim p as C ptr = new C : delete p, 1, 1, 1 )

		'' B.dtor won't be called since A.dtor is not virtual
		check( dim p as A ptr = new B : delete p, 1, 0, 0 )

		'' ditto, B.dtor and C.dtor not called
		check( dim p as A ptr = new C : delete p, 1, 0, 0 )

		'' B.dtor is virtual, so C.dtor will be called instead;
		'' it in turn calls B.dtor, and that calls A.dtor
		check( dim p as B ptr = new C : delete p, 1, 1, 1 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/virtual/virtual" )
	fbcu.add_test( "VIRTUAL/ABSTRACT declarations", @declarations.test )
	fbcu.add_test( "basic overriding", @overridingWorks.test )
	fbcu.add_test( "Overriding vs. shadowing", @overridingVsShadowing.test )
	fbcu.add_test( "Methods with a different signature are not overridden", @differentSignatureIsntOverridden.test )
	fbcu.add_test( "VIRTUAL dtor", @virtualDtor.test )
	fbcu.add_test( "VIRTUAL dtor still calls field dtor", @virtualDtorDestructsField.test )
	fbcu.add_test( "VIRTUAL dtor still calls base dtor", @virtualDtorDestructsBase.test )
end sub

end namespace
