#include "fbcunit.bi"

SUITE( fbc_tests.virtual_.virtual_ )

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

			declare				sub s01( )
			declare		virtual		sub s02( )
			declare		virtual		sub s03( )
			declare	const	virtual		sub s04( )
			declare	const	virtual		sub s05( )
			declare	const	virtual		sub s06( )
			declare	const	virtual		sub s07( )
			declare		abstract	sub s08( )
			declare		abstract	sub s09( )
			declare	const	abstract	sub s10( )
			declare	const	abstract	sub s11( )
			declare	const	abstract	sub s12( )
			declare	const	abstract	sub s13( )

			declare		virtual		function fOverrideMe1( ) as integer
			declare		abstract	function fOverrideMe2( ) as integer
			declare		virtual		sub sOverrideMe1( )
			declare		abstract	sub sOverrideMe2( )
		end type

					function A.f01( ) as integer : function = 1 : end function
					function A.f02( ) as integer : function = 2 : end function
			virtual		function A.f03( ) as integer : function = 3 : end function
					function A.f04( ) as integer : function = 4 : end function
		const			function A.f05( ) as integer : function = 5 : end function
			virtual		function A.f06( ) as integer : function = 6 : end function
		const	virtual		function A.f07( ) as integer : function = 7 : end function

					sub A.s01( ) : end sub
					sub A.s02( ) : end sub
			virtual		sub A.s03( ) : end sub
					sub A.s04( ) : end sub
		const			sub A.s05( ) : end sub
			virtual		sub A.s06( ) : end sub
		const	virtual		sub A.s07( ) : end sub

		function A.fOverrideMe1( ) as integer : function = 1 : end function
		sub A.sOverrideMe1( ) : end sub

		type B extends A
			declare function fOverrideMe1( ) as integer override
			declare function fOverrideMe2( ) as integer override
			declare sub sOverrideMe1( ) override
			declare sub sOverrideMe2( ) override
		end type

		function B.fOverrideMe1( ) as integer : function = 1 : end function
		function B.fOverrideMe2( ) as integer : function = 2 : end function
		sub B.sOverrideMe1( ) : end sub
		sub B.sOverrideMe2( ) : end sub
	end namespace

	'' basic overriding
	TEST_GROUP( overridingWorks )
		type A extends object
			i as integer
			declare constructor( byval j as integer )
			declare virtual sub add( byval j as integer )
			declare virtual sub subtract( byval j as integer )
			declare virtual function toString( ) as string
		end type

		constructor A( byval j as integer )
			this.i = j
		end constructor

		sub A.add( byval j as integer )
		end sub

		sub A.subtract( byval j as integer )
			this.i -= j
		end sub

		function A.toString( ) as string
			function = str( this.i )
		end function

		type B extends A
			declare constructor( )
			declare constructor( byref as const B )
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

		TEST( default )
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
		END_TEST
	END_TEST_GROUP

	'' Overriding vs. shadowing
	TEST_GROUP( overridingVsShadowing )
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

		TEST( default )
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
		END_TEST
	END_TEST_GROUP

	'' Overriding overloaded methods
	TEST_GROUP( overridingOverloadedMethods )
		type A extends object
			declare virtual function f(            ) as integer
			declare virtual function f( as integer ) as integer
			declare virtual function f( as longint ) as integer
		end type

		type B extends A
			declare function f( as integer ) as integer
			declare function f( as longint ) as integer
			declare function f(            ) as integer
		end type

		function A.f(              ) as integer
			function = &hA1
		end function

		function A.f( i as integer ) as integer
			function = &hA2
		end function

		function A.f( i as longint ) as integer
			function = &hA3
		end function

		function B.f(              ) as integer
			function = &hB1
		end function

		function B.f( i as integer ) as integer
			function = &hB2
		end function

		function B.f( i as longint ) as integer
			function = &hB3
		end function

		TEST( default )
			dim pa as A ptr

			pa = new A
			CU_ASSERT( pa->f(              ) = &hA1 )
			CU_ASSERT( pa->f(          1   ) = &hA2 )
			CU_ASSERT( pa->f( clngint( 1 ) ) = &hA3 )
			delete pa

			pa = new B
			CU_ASSERT( pa->f(              ) = &hB1 )
			CU_ASSERT( pa->f(          1   ) = &hB2 )
			CU_ASSERT( pa->f( clngint( 1 ) ) = &hB3 )
			delete pa
		END_TEST
	END_TEST_GROUP

	'' VIRTUAL properties
	TEST_GROUP( virtualProperties )
		dim shared as integer Agets, Asets, Bgets, Bsets

		type A extends object
			declare virtual property f(            ) as integer
			declare virtual property f( as integer )
		end type

		type B extends A
			declare property f(            ) as integer
			declare property f( as integer )
		end type

		property A.f(              ) as integer : Agets += 1 : property = &hA : end property
		property A.f( i as integer )            : Asets += 1 :                : end property
		property B.f(              ) as integer : Bgets += 1 : property = &hB : end property
		property B.f( i as integer )            : Bsets += 1 :                : end property

		TEST( default )
			dim pa as A ptr

			Agets = 0
			Asets = 0
			Bgets = 0
			Bsets = 0
			pa = new A
			CU_ASSERT( pa->f = &hA )
			pa->f = 123
			CU_ASSERT( Agets = 1 )
			CU_ASSERT( Asets = 1 )
			CU_ASSERT( Bgets = 0 )
			CU_ASSERT( Bsets = 0 )
			delete pa

			Agets = 0
			Asets = 0
			Bgets = 0
			Bsets = 0
			pa = new B
			CU_ASSERT( pa->f = &hB )
			pa->f = 123
			CU_ASSERT( Agets = 0 )
			CU_ASSERT( Asets = 0 )
			CU_ASSERT( Bgets = 1 )
			CU_ASSERT( Bsets = 1 )
			delete pa
		END_TEST
	END_TEST_GROUP

	'' VIRTUAL operators
	TEST_GROUP( virtualOperators )
		dim shared as integer Alets, Blets

		type UDT1
			a as integer
		end type

		type A extends object
			declare virtual operator let( as UDT1 )
			declare virtual operator cast( ) as string
			declare virtual operator cast( ) as integer
			declare virtual operator @( ) as any ptr
		end type

		type B extends A
			declare operator let( as UDT1 ) override
			declare operator cast( ) as string override
			declare operator cast( ) as integer override
			declare operator @( ) as any ptr override
		end type

		operator A.let( rhs as UDT1 ) : Alets += 1 : end operator
		operator B.let( rhs as UDT1 ) : Blets += 1 : end operator

		operator A.cast( ) as string : operator = "A" : end operator
		operator B.cast( ) as string : operator = "B" : end operator

		operator A.cast( ) as integer : operator = &hA : end operator
		operator B.cast( ) as integer : operator = &hB : end operator

		operator A.@( ) as any ptr : operator = cptr( any ptr, &hA ) : end operator
		operator B.@( ) as any ptr : operator = cptr( any ptr, &hB ) : end operator

		TEST( default )
			dim s as string, i as integer, x1 as UDT1

			scope
				dim pa as A ptr = new A

				Alets = 0 : Blets =  0
				*pa = x1
				CU_ASSERT( Alets = 1 ) : CU_ASSERT( Blets = 0 )

				s = ""
				s = *pa
				CU_ASSERT( s = "A" )
				CU_ASSERT( *pa = "A" )

				i = 0
				i = *pa
				CU_ASSERT( i = &hA )
				CU_ASSERT( cint( *pa ) = &hA )

				CU_ASSERT( @*pa = &hA )

				delete pa
			end scope

			scope
				dim pa as A ptr = new B

				Alets = 0 : Blets =  0
				*pa = x1
				CU_ASSERT( Alets = 0 ) : CU_ASSERT( Blets = 1 )

				s = ""
				s = *pa
				CU_ASSERT( s = "B" )
				CU_ASSERT( *pa = "B" )

				i = 0
				i = *pa
				CU_ASSERT( i = &hB )
				CU_ASSERT( cint( *pa ) = &hB )

				CU_ASSERT( @*pa = &hB )

				delete pa
			end scope

			scope
				dim pb as B ptr = new B

				Alets = 0 : Blets =  0
				*pb = x1
				CU_ASSERT( Alets = 0 ) : CU_ASSERT( Blets = 1 )

				s = ""
				s = *pb
				CU_ASSERT( s = "B" )
				CU_ASSERT( *pb = "B" )

				i = 0
				i = *pb
				CU_ASSERT( i = &hB )
				CU_ASSERT( cint( *pb ) = &hB )

				CU_ASSERT( @*pb = &hB )

				delete pb
			end scope
		END_TEST
	END_TEST_GROUP

	'' Methods with a different signature are not overridden
	TEST_GROUP( differentSignatureIsntOverridden )
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

		TEST( default )
			dim pa as A ptr
			dim xb as B
			pa = @xb
			CU_ASSERT( pa->f1( ) = &hA1 )  '' vtable lookup, not overridden
			CU_ASSERT( xb.f1( 123 ) = &hB1 )
		END_TEST
	END_TEST_GROUP

	'' VIRTUAL dtor
	TEST_GROUP( virtualDtor )
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

		TEST( default )
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
		END_TEST
	END_TEST_GROUP

	'' VIRTUAL dtor still calls field dtor
	TEST_GROUP( virtualDtorDestructsField )
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

		TEST( default )
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
		END_TEST
	END_TEST_GROUP

	'' VIRTUAL dtor still calls base dtor
	TEST_GROUP( virtualDtorDestructsBase )
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

		TEST( default )
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
		END_TEST
	END_TEST_GROUP

	'' implicit dtor also overrides
	TEST_GROUP( implicitDtorOverrides )
		dim shared as integer callsA, callsFB

		type A extends object
			declare virtual destructor( )
		end type

		destructor A( )
			callsA += 1
		end destructor

		type FB
			dummy as integer
			declare destructor( )
		end type

		destructor FB( )
			callsFB += 1
		end destructor

		type B extends A
			f as FB
			'' B has a field with a dtor, but B has no explicit dtor,
			'' so an implicit dtor will be generated.
			'' Since A's dtor is virtual, B's implicit dtor should
			'' override it.
		end type

		TEST( default )
			callsA = 0
			callsFB = 0
			scope
				dim x as B
			end scope
			CU_ASSERT( callsA = 1 )
			CU_ASSERT( callsFB = 1 )

			callsA = 0
			callsFB = 0
			scope
				dim as B ptr p = new B
				delete p
			end scope
			CU_ASSERT( callsA = 1 )
			CU_ASSERT( callsFB = 1 )

			callsA = 0
			callsFB = 0
			scope
				dim as A ptr p = new B
				delete p
			end scope
			CU_ASSERT( callsA = 1 )
			CU_ASSERT( callsFB = 1 )
		END_TEST
	END_TEST_GROUP

	'' virtuals reuse vtable slots #1
	TEST_GROUP( vtableSlotsReused1 )
		'' For both ABSTRACTs and VIRTUALs, the overrides should use the same
		'' vtable slots like the overridden methods,
		'' no matter what nesting level...

		type A extends object
			declare virtual  function f1( ) as integer
			declare abstract function f2( ) as integer
			declare abstract function f3( ) as integer
		end type

		type B extends A
			declare virtual  function f1( ) as integer
			declare virtual  function f2( ) as integer
			declare abstract function f3( ) as integer
		end type

		type C extends B
			declare function f1( ) as integer
			declare function f2( ) as integer
			declare function f3( ) as integer
		end type

		function A.f1( ) as integer : function = &hA1 : end function
		function B.f1( ) as integer : function = &hB1 : end function
		function B.f2( ) as integer : function = &hB2 : end function
		function C.f1( ) as integer : function = &hC1 : end function
		function C.f2( ) as integer : function = &hC2 : end function
		function C.f3( ) as integer : function = &hC3 : end function

		TEST( default )
			scope
				dim p as A ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				CU_ASSERT( p->f3( ) = &hC3 )
				delete p
			end scope

			scope
				dim p as B ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				CU_ASSERT( p->f3( ) = &hC3 )
				delete p
			end scope

			scope
				dim p as C ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				CU_ASSERT( p->f3( ) = &hC3 )
				delete p
			end scope
		END_TEST
	END_TEST_GROUP

	'' virtuals reuse vtable slots #2
	TEST_GROUP( vtableSlotsReused2 )
		'' Same test but only with VIRTUALs, allowing for more extensive
		'' testing since there are no ABSTRACTs preventing their parent UDT
		'' from being instantiated...

		type A extends object
			declare virtual function f1( ) as integer
			declare virtual function f2( ) as integer
			declare virtual function f3( ) as integer
		end type

		type B extends A
			declare virtual function f1( ) as integer
			declare virtual function f2( ) as integer
			declare virtual function f3( ) as integer
		end type

		type C extends B
			declare function f1( ) as integer
			declare function f2( ) as integer
			declare function f3( ) as integer
		end type

		function A.f1( ) as integer : function = &hA1 : end function
		function A.f2( ) as integer : function = &hA2 : end function
		function A.f3( ) as integer : function = &hA3 : end function
		function B.f1( ) as integer : function = &hB1 : end function
		function B.f2( ) as integer : function = &hB2 : end function
		function B.f3( ) as integer : function = &hB3 : end function
		function C.f1( ) as integer : function = &hC1 : end function
		function C.f2( ) as integer : function = &hC2 : end function
		function C.f3( ) as integer : function = &hC3 : end function

		TEST( default )
			scope
				dim p as A ptr = new A
				CU_ASSERT( p->f1( ) = &hA1 )
				CU_ASSERT( p->f2( ) = &hA2 )
				CU_ASSERT( p->f3( ) = &hA3 )
				delete p
			end scope

			scope
				dim p as A ptr = new B
				CU_ASSERT( p->f1( ) = &hB1 )
				CU_ASSERT( p->f2( ) = &hB2 )
				CU_ASSERT( p->f3( ) = &hB3 )
				delete p
			end scope

			scope
				dim p as A ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				CU_ASSERT( p->f3( ) = &hC3 )
				delete p
			end scope

			scope
				dim p as B ptr = new B
				CU_ASSERT( p->f1( ) = &hB1 )
				CU_ASSERT( p->f2( ) = &hB2 )
				CU_ASSERT( p->f3( ) = &hB3 )
				delete p
			end scope

			scope
				dim p as B ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				CU_ASSERT( p->f3( ) = &hC3 )
				delete p
			end scope

			scope
				dim p as C ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				CU_ASSERT( p->f3( ) = &hC3 )
				delete p
			end scope
		END_TEST
	END_TEST_GROUP

	'' virtual properties reuse vtable slots
	TEST_GROUP( vtableSlotsReusedProperties )
		dim shared as integer Agets, Asets, Bgets, Bsets, Cgets, Csets

		type A extends object
			declare virtual property f(            ) as integer
			declare virtual property f( as integer )
		end type

		type B extends A
			declare virtual property f(            ) as integer override
			declare virtual property f( as integer )            override
		end type

		type C extends B
			declare property f(            ) as integer override
			declare property f( as integer )            override
		end type

		property A.f(              ) as integer : Agets += 1 : property = &hA : end property
		property A.f( i as integer )            : Asets += 1 :                : end property
		property B.f(              ) as integer : Bgets += 1 : property = &hB : end property
		property B.f( i as integer )            : Bsets += 1 :                : end property
		property C.f(              ) as integer : Cgets += 1 : property = &hC : end property
		property C.f( i as integer )            : Csets += 1 :                : end property

		TEST( default )
			#macro resetCounts( )
				Agets = 0 : Asets = 0
				Bgets = 0 : Bsets = 0
				Cgets = 0 : Csets = 0
			#endmacro

			#macro expect( Aget, Aset, Bget, Bset, Cget, Cset )
				CU_ASSERT( Agets = Aget ) : CU_ASSERT( Asets = Aset )
				CU_ASSERT( Bgets = Bget ) : CU_ASSERT( Bsets = Bset )
				CU_ASSERT( Cgets = Cget ) : CU_ASSERT( Csets = Cset )
			#endmacro

			scope
				resetCounts( )
				dim pa as A ptr = new A
				CU_ASSERT( pa->f = &hA )
				pa->f = 123
				delete pa
				expect( 1, 1, 0, 0, 0, 0 )
			end scope

			scope
				resetCounts( )
				dim pa as A ptr = new B
				CU_ASSERT( pa->f = &hB )
				pa->f = 123
				delete pa
				expect( 0, 0, 1, 1, 0, 0 )
			end scope

			scope
				resetCounts( )
				dim pa as A ptr = new C
				CU_ASSERT( pa->f = &hC )
				pa->f = 123
				delete pa
				expect( 0, 0, 0, 0, 1, 1 )
			end scope

			scope
				resetCounts( )
				dim pb as B ptr = new B
				CU_ASSERT( pb->f = &hB )
				pb->f = 123
				delete pb
				expect( 0, 0, 1, 1, 0, 0 )
			end scope

			scope
				resetCounts( )
				dim pb as B ptr = new C
				CU_ASSERT( pb->f = &hC )
				pb->f = 123
				delete pb
				expect( 0, 0, 0, 0, 1, 1 )
			end scope
		END_TEST
	END_TEST_GROUP

	'' virtual operators reuse vtable slots
	TEST_GROUP( vtableSlotsReusedOperators )
		dim shared as integer Alets, Blets, Clets

		type A extends object
			declare virtual operator let( as integer )
		end type

		type B extends A
			declare virtual operator let( as integer ) override
		end type

		type C extends B
			declare operator let( as integer ) override
		end type

		operator A.let( rhs as integer ) : Alets += 1 : end operator
		operator B.let( rhs as integer ) : Blets += 1 : end operator
		operator C.let( rhs as integer ) : Clets += 1 : end operator

		TEST( default )
			#macro check( Tpointer, Tobject, Alets_, Blets_, Clets_ )
				Alets = 0
				Blets = 0
				Clets = 0

				scope
					dim p as Tpointer ptr = new Tobject
					*p = 123
					delete p
				end scope

				CU_ASSERT( Alets = Alets_ )
				CU_ASSERT( Blets = Blets_ )
				CU_ASSERT( Clets = Clets_ )
			#endmacro

			check( A, A, 1, 0, 0 )
			check( A, B, 0, 1, 0 )
			check( A, C, 0, 0, 1 )
			check( B, B, 0, 1, 0 )
			check( B, C, 0, 0, 1 )
			check( C, C, 0, 0, 1 )
		END_TEST
	END_TEST_GROUP

	'' virtual dtors reuse vtable slots
	TEST_GROUP( vtableSlotsReusedDtor )
		dim shared as integer callsA, callsB, callsC

		type A extends object
			declare virtual destructor( )
		end type

		type B extends A
			declare virtual destructor( ) override
		end type

		type C extends B
			declare destructor( ) override
		end type

		destructor A( ) : callsA += 1 : end destructor
		destructor B( ) : callsB += 1 : end destructor
		destructor C( ) : callsC += 1 : end destructor

		TEST( default )
			#macro check( Tpointer, Tobject, callsA_, callsB_, callsC_ )
				callsA = 0
				callsB = 0
				callsC = 0
				scope
					dim p as Tpointer ptr = new Tobject
					delete p
				end scope
				CU_ASSERT( callsA = callsA_ )
				CU_ASSERT( callsB = callsB_ )
				CU_ASSERT( callsC = callsC_ )
			#endmacro

			check( A, A, 1, 0, 0 )
			check( A, B, 1, 1, 0 )
			check( A, C, 1, 1, 1 )
			check( B, B, 1, 1, 0 )
			check( B, C, 1, 1, 1 )
			check( C, C, 1, 1, 1 )
		END_TEST
	END_TEST_GROUP

	'' overrides are not made virtual automatically
	TEST_GROUP( noImplicitVirtual )
		type A extends object
			'' new ABSTRACT
			declare abstract function f1( ) as integer
		end type

		type B extends A
			'' overrides the ABSTRACT, but should not become ABSTRACT/VIRTUAL itself implicitly
			declare          function f1( ) as integer

			'' new VIRTUAL
			declare virtual  function f2( ) as integer
		end type

		type C extends B
			'' shadows B.f1() but shouldn't become VIRTUAL implicitly
			declare function f1( ) as integer

			'' overrides B.f2() but shouldn't become VIRTUAL implicitly
			declare function f2( ) as integer
		end type

		type D extends C
			'' shadows C.f2() but shouldn't become VIRTUAL implicitly
			declare function f2( ) as integer
		end type

		function B.f1( ) as integer : function = &hB1 : end function
		function B.f2( ) as integer : function = &hB2 : end function
		function C.f1( ) as integer : function = &hC1 : end function
		function C.f2( ) as integer : function = &hC2 : end function
		function D.f2( ) as integer : function = &hD2 : end function

		TEST( default )
			scope
				dim p as A ptr = new B
				CU_ASSERT( p->f1( ) = &hB1 ) '' A.f1() is overridden by B.f1()
				delete p
			end scope

			scope
				dim p as A ptr = new C
				CU_ASSERT( p->f1( ) = &hB1 ) '' A.f1() is overridden by B.f1(), but not C.f1() since B.f1() isn't VIRTUAL
				delete p
			end scope

			scope
				dim p as A ptr = new D
				CU_ASSERT( p->f1( ) = &hB1 ) '' ditto
				delete p
			end scope

			scope
				dim p as B ptr = new B
				CU_ASSERT( p->f1( ) = &hB1 )
				CU_ASSERT( p->f2( ) = &hB2 )
				delete p
			end scope

			scope
				dim p as B ptr = new C
				CU_ASSERT( p->f1( ) = &hB1 ) '' B.f1() isn't VIRTUAL, so not overridden by C.f1()
				CU_ASSERT( p->f2( ) = &hC2 ) '' B.f2() is VIRTUAL though, and overridden by C.f2()
				delete p
			end scope

			scope
				dim p as B ptr = new D
				CU_ASSERT( p->f1( ) = &hB1 )
				CU_ASSERT( p->f2( ) = &hC2 ) '' B.f2() is overridden by C.f2(), but not D.f2() (since C.f2() isn't VIRTUAL)
				delete p
			end scope

			scope
				dim p as C ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 )
				delete p
			end scope

			scope
				dim p as C ptr = new D
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hC2 ) '' C.f2() isn't VIRTUAL, so not overridden by D.f2()
				delete p
			end scope

			scope
				dim p as D ptr = new D
				CU_ASSERT( p->f1( ) = &hC1 )
				CU_ASSERT( p->f2( ) = &hD2 )
				delete p
			end scope
		END_TEST
	END_TEST_GROUP

	'' VIRTUALs are inherited even if not overridden #1
	TEST_GROUP( virtualsAreInherited1 )
		'' With a class hierarchy like A>B>C, C should be able to override A's
		'' virtuals even if B does not.

		type A extends object
			declare virtual function f1( ) as integer
		end type

		type B extends A
			'' not overriding anything
		end type

		type C extends B
			declare function f1( ) as integer
		end type

		function A.f1( ) as integer : function = &hA1 : end function
		function C.f1( ) as integer : function = &hC1 : end function

		TEST( default )
			scope
				dim p as A ptr = new A
				CU_ASSERT( p->f1( ) = &hA1 )
				delete p
			end scope

			scope
				dim p as A ptr = new B
				CU_ASSERT( p->f1( ) = &hA1 )
				delete p
			end scope

			scope
				dim p as A ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				delete p
			end scope

			scope
				dim p as B ptr = new B
				CU_ASSERT( p->f1( ) = &hA1 )
				delete p
			end scope

			scope
				dim p as B ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				delete p
			end scope

			scope
				dim p as C ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				delete p
			end scope
		END_TEST
	END_TEST_GROUP

	'' VIRTUALs are inherited even if not overridden #2
	TEST_GROUP( virtualsAreInherited2 )
		'' same with an ABSTRACT

		type A extends object
			declare abstract function f1( ) as integer
		end type

		type B extends A
			'' not overriding anything
		end type

		type C extends B
			declare function f1( ) as integer
		end type

		function C.f1( ) as integer : function = &hC1 : end function

		TEST( default )
			scope
				dim p as A ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 ) '' should not crash because it should have been overridden
				delete p
			end scope

			scope
				dim p as B ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 ) '' ditto
				delete p
			end scope

			scope
				dim p as C ptr = new C
				CU_ASSERT( p->f1( ) = &hC1 )
				delete p
			end scope
		END_TEST
	END_TEST_GROUP

	'' BYREF return of abstract UDT
	TEST_GROUP( returnByrefAbstract )
		'' abstract UDT
		type A extends object
			declare abstract function f( ) as integer
		end type

		'' non-abstract UDT
		type B extends A
			declare function f( ) as integer
		end type

		function B.f( ) as integer
			function = 123
		end function

		function f( ) byref as A
			static x as B
			function = x
		end function

		TEST( default )
			CU_ASSERT( f( ).f( ) = 123 )
		END_TEST
	END_TEST_GROUP

	'' overriding an EXTERN C method
	TEST_GROUP( externC )
		'' cdecl + case-preserving alias
		'' declare a type inside an extern "c" block and extend it outside
		extern "c"
			type A extends object
				declare virtual function foo( byval i as integer ) as integer
			end type

			function A.foo( byval i as integer ) as integer
				function = &hA
			end function
		end extern

		type B extends A
			declare function foo cdecl( byval i as integer ) as integer override
		end type

		function B.foo cdecl( byval i as integer ) as integer
			function = &hB
		end function

		TEST( default )
			dim p as A ptr = new B
			CU_ASSERT( p->foo( 123 ) = &hB )
			delete p
		END_TEST
	END_TEST_GROUP

	'' overriding an EXTERN C++ method
	TEST_GROUP( externCxx )
		'' cdecl + C++ mangling (member procedures have that already anyways though)
		'' declare a type inside an extern "c++" block and extend it outside
		'' on win32 / x86 non-static member procedures have a default of
		'' __thiscall calling convention inside the extern "c++" block but will
		'' default to fbcall outside, so the declaration needs an explicit
		'' matching calling convention in the declaration.  The definition
		'' will automatically get the calling convention from the declaration.
		extern "c++"
			type A extends object
				declare virtual function foo1( byval i as integer ) as integer
				declare virtual function foo2( byval i as integer ) as integer
			end type

			function A.foo1( byval i as integer ) as integer
				function = &hA1
			end function

			function A.foo2( byval i as integer ) as integer
				function = &hA2
			end function
		end extern

		#if defined( __FB_WIN32__ ) and not defined (__FB_64BIT__)
			#define NonStaticCallConv __thiscall
		#else
			#define NonStaticCallConv cdecl
		#endif

		type B extends A
			declare function foo1 NonStaticCallConv( byval i as integer ) as integer override
			declare function foo2 NonStaticCallConv( byval i as integer ) as integer override
		end type

		'' explicit calling convention
		function B.foo1 NonStaticCallConv( byval i as integer ) as integer
			function = &hB1
		end function

		'' implicit calling convention based on declaration
		function B.foo2( byval i as integer ) as integer
			function = &hB2
		end function

		TEST( default )
			dim p as A ptr = new B
			CU_ASSERT( p->foo1( 123 ) = &hB1 )
			CU_ASSERT( p->foo2( 123 ) = &hB2 )
			delete p
		END_TEST
	END_TEST_GROUP

	'' overriding an EXTERN C++ method with explicit calling convention
	TEST_GROUP( externCxxExplicit )
		'' cdecl + C++ mangling (member procedures have that already anyways though)
		'' declare a type inside an extern "c++" block with an explicit cdecl
		'' calling convention and extend it outside using an explicit cdecl
		extern "c++"
			type A extends object
				declare virtual function foo cdecl( byval i as integer ) as integer
			end type

			function A.foo cdecl( byval i as integer ) as integer
				function = &hA
			end function
		end extern

		type B extends A
			declare function foo cdecl( byval i as integer ) as integer override
		end type

		function B.foo cdecl( byval i as integer ) as integer
			function = &hB
		end function

		TEST( default )
			dim p as A ptr = new B
			CU_ASSERT( p->foo( 123 ) = &hB )
			delete p
		END_TEST
	END_TEST_GROUP

	'' overriding an EXTERN Windows method
	TEST_GROUP( externWindows )
		extern "windows" '' stdcall + @N suffix + case-preserving alias
			type A extends object
				declare virtual function foo( byval i as integer ) as integer
			end type

			function A.foo( byval i as integer ) as integer
				function = &hA
			end function
		end extern

		type B extends A
			declare function foo stdcall( byval i as integer ) as integer override
		end type

		function B.foo stdcall( byval i as integer ) as integer
			function = &hB
		end function

		TEST( default )
			dim p as A ptr = new B
			CU_ASSERT( p->foo( 123 ) = &hB )
			delete p
		END_TEST
	END_TEST_GROUP

	'' overriding an EXTERN Windows-MS method
	TEST_GROUP( externWindowsMs )
		'' It should be ok to override a virtual STDCALL_MS method with an
		'' STDCALL override; their calling convention is compatible,
		'' only their mangling is different.

		extern "windows-ms"  '' stdcall + case-preserving alias but no @N suffix
			type A extends object
				declare virtual function foo( byval i as integer ) as integer
			end type

			function A.foo( byval i as integer ) as integer
				function = &hA
			end function
		end extern

		type B extends A
			declare function foo stdcall( byval i as integer ) as integer override
		end type

		function B.foo stdcall( byval i as integer ) as integer
			function = &hB
		end function

		TEST( default )
			dim p as A ptr = new B
			CU_ASSERT( p->foo( 123 ) = &hB )
			delete p
		END_TEST
	END_TEST_GROUP

	'' explicit BASE access
	TEST_GROUP( explicitBase )
		type A extends object
			i as integer
			declare virtual function f1( ) as integer
			declare virtual sub f2( byref as integer )
		end type

		function A.f1( ) as integer
			function = &hA
		end function

		sub A.f2( byref i as integer )
			i = &hA
		end sub

		type B extends A
			declare function f1( ) as integer override
			declare sub f2( byref as integer ) override
		end type

		function B.f1( ) as integer
			'' base.f1() should call A.f1(), not B.f1() recursively
			function = base.f1( ) + &hB
		end function

		sub B.f2( byref i as integer )
			base.f2( i )
			i += &hB
		end sub

		TEST( default )
			dim i as integer

			dim as A ptr pa = new B
			CU_ASSERT( pa->f1( ) = &hA + &hB )
			pa->f2( i )
			CU_ASSERT( i = &hA + &hB )
			delete pa

			i = 0

			dim as B ptr pb = new B
			CU_ASSERT( pb->f1( ) = &hA + &hB )
			pb->f2( i )
			CU_ASSERT( i = &hA + &hB )
			delete pb
		END_TEST
	END_TEST_GROUP

	'' bydescParamGccWarningRegressionTest
	TEST_GROUP( bydescParamGccWarningRegressionTest )
		type UDT extends object
			i as integer

			declare function test_proc( ) as integer
			declare virtual function f( array() as integer ) as integer
		end type

		function UDT.f( array() as integer ) as integer
			function = array(0)
		end function

		function UDT.test_proc( ) as integer
			dim as integer temp()
			redim temp(0 to 1)
			temp(0) = 111
			function = f( temp() )
		end function

		TEST( default )
			dim x as UDT
			CU_ASSERT( x.test_proc( ) = 111 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( bydescParams1 )
		type A extends object
			declare virtual function f0( array() as integer ) as integer
			declare virtual function f1( array(any) as integer ) as integer
			declare virtual function f2( array(any, any) as integer ) as integer
			declare virtual function f8( array(any, any, any, any, any, any, any, any) as integer ) as integer
		end type

		function A.f0( array() as integer ) as integer
			function = &hA0
		end function

		function A.f1( array(any) as integer ) as integer
			function = &hA1
		end function

		function A.f2( array(any, any) as integer ) as integer
			function = &hA2
		end function

		function A.f8( array(any, any, any, any, any, any, any, any) as integer ) as integer
			function = &hA8
		end function

		type B extends A
			declare function f0( array() as integer ) as integer override
			declare function f1( array(any) as integer ) as integer override
			declare function f2( array(any, any) as integer ) as integer override
			declare function f8( array(any, any, any, any, any, any, any, any) as integer ) as integer override
		end type

		function B.f0( array() as integer ) as integer
			function = &hB0
		end function

		function B.f1( array(any) as integer ) as integer
			function = &hB1
		end function

		function B.f2( array(any, any) as integer ) as integer
			function = &hB2
		end function

		function B.f8( array(any, any, any, any, any, any, any, any) as integer ) as integer
			function = &hB8
		end function

		TEST( default )
			dim array0() as integer
			dim array1(any) as integer
			dim array2(any, any) as integer
			dim array8(any, any, any, any, any, any, any, any) as integer

			scope
				var pa = new A
				CU_ASSERT( pa->f0( array0() ) = &hA0 )
				CU_ASSERT( pa->f1( array1() ) = &hA1 )
				CU_ASSERT( pa->f2( array2() ) = &hA2 )
				CU_ASSERT( pa->f8( array8() ) = &hA8 )
				delete pa
			end scope

			scope
				dim as A ptr pa = new B
				CU_ASSERT( pa->f0( array0() ) = &hB0 )
				CU_ASSERT( pa->f1( array1() ) = &hB1 )
				CU_ASSERT( pa->f2( array2() ) = &hB2 )
				CU_ASSERT( pa->f8( array8() ) = &hB8 )
				delete pa
			end scope

			scope
				var pb = new B
				CU_ASSERT( pb->f0( array0() ) = &hB0 )
				CU_ASSERT( pb->f1( array1() ) = &hB1 )
				CU_ASSERT( pb->f2( array2() ) = &hB2 )
				CU_ASSERT( pb->f8( array8() ) = &hB8 )
				delete pb
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( bydescParams2 )
		type A extends object
			declare virtual function f( array(any) as integer ) as integer
			declare virtual function f( array(any, any) as integer ) as integer
			declare virtual function f( array(any, any, any, any, any, any, any, any) as integer ) as integer
		end type

		function A.f( array(any) as integer ) as integer
			function = &hA1
		end function

		function A.f( array(any, any) as integer ) as integer
			function = &hA2
		end function

		function A.f( array(any, any, any, any, any, any, any, any) as integer ) as integer
			function = &hA8
		end function

		type B extends A
			declare function f( array(any) as integer ) as integer override
			declare function f( array(any, any) as integer ) as integer override
			declare function f( array(any, any, any, any, any, any, any, any) as integer ) as integer override
		end type

		function B.f( array(any) as integer ) as integer
			function = &hB1
		end function

		function B.f( array(any, any) as integer ) as integer
			function = &hB2
		end function

		function B.f( array(any, any, any, any, any, any, any, any) as integer ) as integer
			function = &hB8
		end function

		TEST( default )
			dim array1(any) as integer
			dim array2(any, any) as integer
			dim array8(any, any, any, any, any, any, any, any) as integer

			scope
				var pa = new A
				CU_ASSERT( pa->f( array1() ) = &hA1 )
				CU_ASSERT( pa->f( array2() ) = &hA2 )
				CU_ASSERT( pa->f( array8() ) = &hA8 )
				delete pa
			end scope

			scope
				dim as A ptr pa = new B
				CU_ASSERT( pa->f( array1() ) = &hB1 )
				CU_ASSERT( pa->f( array2() ) = &hB2 )
				CU_ASSERT( pa->f( array8() ) = &hB8 )
				delete pa
			end scope

			scope
				var pb = new B
				CU_ASSERT( pb->f( array1() ) = &hB1 )
				CU_ASSERT( pb->f( array2() ) = &hB2 )
				CU_ASSERT( pb->f( array8() ) = &hB8 )
				delete pb
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( callingConventions )
		'' All these methods have multiple parameters, ensuring that the
		'' parameter cycling loops aren't bypassed. The calling convention
		'' should not affect parameter checking, especially not Pascal for which
		'' the parameters are reversed in many places of the compiler.

		type A extends object
			declare virtual function fcdecl   cdecl  ( as integer, as string ) as integer
			declare virtual function fstdcall stdcall( as integer, as string ) as integer
			declare virtual function fpascal  pascal ( as integer, as string ) as integer
		end type

		function A.fcdecl   cdecl  ( i as integer, s as string ) as integer : function = &hA1 : end function
		function A.fstdcall stdcall( i as integer, s as string ) as integer : function = &hA2 : end function
		function A.fpascal  pascal ( i as integer, s as string ) as integer : function = &hA3 : end function

		type B extends A
			declare function fcdecl   cdecl  ( as integer, as string ) as integer override
			declare function fstdcall stdcall( as integer, as string ) as integer override
			declare function fpascal  pascal ( as integer, as string ) as integer override
		end type

		function B.fcdecl   cdecl  ( i as integer, s as string ) as integer : function = &hB1 : end function
		function B.fstdcall stdcall( i as integer, s as string ) as integer : function = &hB2 : end function
		function B.fpascal  pascal ( i as integer, s as string ) as integer : function = &hB3 : end function

		TEST( default )
			scope
				var pa = new A
				CU_ASSERT( pa->fcdecl  ( 0, "" ) = &hA1 )
				CU_ASSERT( pa->fstdcall( 0, "" ) = &hA2 )
				CU_ASSERT( pa->fpascal ( 0, "" ) = &hA3 )
				delete pa
			end scope

			scope
				dim as A ptr pa = new B
				CU_ASSERT( pa->fcdecl  ( 0, "" ) = &hB1 )
				CU_ASSERT( pa->fstdcall( 0, "" ) = &hB2 )
				CU_ASSERT( pa->fpascal ( 0, "" ) = &hB3 )
				delete pa
			end scope

			scope
				var pb = new B
				CU_ASSERT( pb->fcdecl  ( 0, "" ) = &hB1 )
				CU_ASSERT( pb->fstdcall( 0, "" ) = &hB2 )
				CU_ASSERT( pb->fpascal ( 0, "" ) = &hB3 )
				delete pb
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( callConstVirtual )
		type A extends object
			declare const virtual function f1( ) as integer
			declare const abstract function f2( ) as integer
		end type

		type B extends A
			declare const function f1( ) as integer override
			declare const function f2( ) as integer override
		end type

		function A.f1( ) as integer : function = &hA1 : end function
		function B.f1( ) as integer : function = &hB1 : end function
		function B.f2( ) as integer : function = &hB2 : end function

		TEST( default )
			scope
				dim p as A ptr = new B
				CU_ASSERT( p->f1( ) = &hB1 )
				CU_ASSERT( p->f2( ) = &hB2 )
				delete p
			end scope

			scope
				dim p as B ptr = new B
				CU_ASSERT( p->f1( ) = &hB1 )
				CU_ASSERT( p->f2( ) = &hB2 )
				delete p
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( constObjectWithVirtualDtor )
		dim shared as integer adtors, bdtors

		type A extends object
			declare virtual destructor( )
		end type

		type B extends A
			declare destructor( ) override
		end type

		destructor A( ) : adtors += 1 : end destructor
		destructor B( ) : bdtors += 1 : end destructor

		TEST( default )
			adtors = 0
			bdtors = 0
			scope
				dim xa as const A = A()
				CU_ASSERT( adtors = 0 )
				CU_ASSERT( bdtors = 0 )
			end scope
			CU_ASSERT( adtors = 1 )
			CU_ASSERT( bdtors = 0 )

			adtors = 0
			bdtors = 0
			scope
				dim xb as const B = B()
				CU_ASSERT( adtors = 0 )
				CU_ASSERT( bdtors = 0 )
			end scope
			CU_ASSERT( adtors = 1 )
			CU_ASSERT( bdtors = 1 )

			adtors = 0
			bdtors = 0
			scope
				dim p as const A ptr = new const A
				CU_ASSERT( adtors = 0 )
				CU_ASSERT( bdtors = 0 )
				delete p
				CU_ASSERT( adtors = 1 )
				CU_ASSERT( bdtors = 0 )
			end scope
			CU_ASSERT( adtors = 1 )
			CU_ASSERT( bdtors = 0 )

			adtors = 0
			bdtors = 0
			scope
				dim p as const A ptr = new B
				CU_ASSERT( adtors = 0 )
				CU_ASSERT( bdtors = 0 )
				delete p
				CU_ASSERT( adtors = 1 )
				CU_ASSERT( bdtors = 1 )
			end scope
			CU_ASSERT( adtors = 1 )
			CU_ASSERT( bdtors = 1 )

			adtors = 0
			bdtors = 0
			scope
				dim p as const B ptr = new B
				CU_ASSERT( adtors = 0 )
				CU_ASSERT( bdtors = 0 )
				delete p
				CU_ASSERT( adtors = 1 )
				CU_ASSERT( bdtors = 1 )
			end scope
			CU_ASSERT( adtors = 1 )
			CU_ASSERT( bdtors = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
