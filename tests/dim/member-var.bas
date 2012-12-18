# include "fbcu.bi"

namespace fbc_tests.dim_.member_var

namespace integers
	'' Checking that declarations & "bodies" are accepted,
	'' also usage in expressions and assignments

	type UDT
		dummy as integer

		static a as integer
		static as integer b, c, d, e, f, g
	end type

	dim UDT.a as integer
	dim UDT.b as integer
	dim as integer UDT.c, UDT.d
	dim shared UDT.e as integer
	static UDT.f as integer
	static shared UDT.g as integer

	sub test cdecl( )
		CU_ASSERT( UDT.a = 0 )
		CU_ASSERT( UDT.b = 0 )
		CU_ASSERT( UDT.c = 0 )
		CU_ASSERT( UDT.d = 0 )
		CU_ASSERT( UDT.e = 0 )
		CU_ASSERT( UDT.f = 0 )
		CU_ASSERT( UDT.g = 0 )

		UDT.a = 5
		UDT.b = UDT.a
		CU_ASSERT( UDT.a = 5 )
		CU_ASSERT( 5 = UDT.a )

		dim x as UDT

		CU_ASSERT( x.a = 5 )
		CU_ASSERT( x.b = 5 )
		CU_ASSERT( x.c = 0 )
		CU_ASSERT( x.d = 0 )
		CU_ASSERT( x.e = 0 )
		CU_ASSERT( x.f = 0 )
		CU_ASSERT( x.g = 0 )

		x.a = 10
		x.b = x.a
		CU_ASSERT( x.a = 10 )
		CU_ASSERT( 10 = x.a )

		with( x )
			CU_ASSERT( .a = 10 )
		end with

		CU_ASSERT( @UDT.a = @x.a )
	end sub
end namespace

namespace arrays
	'' Checking that the parser accepts array accesses on member vars

	type UDT
		dummy as integer

		static a(0 to 1) as integer
	end type

	dim UDT.a(0 to 1) as integer

	sub test cdecl( )
		UDT.a(0) = 1
		UDT.a(1) = 2
		CU_ASSERT( UDT.a(0) = 1 )
		CU_ASSERT( UDT.a(1) = 2 )

		dim x as UDT

		CU_ASSERT( x.a(0) = 1 )
		CU_ASSERT( x.a(1) = 2 )

		x.a(0) = 3
		x.a(1) = 4
		CU_ASSERT( x.a(0) = 3 )
		CU_ASSERT( x.a(1) = 4 )

		CU_ASSERT( UDT.a(0) = 3 )
		CU_ASSERT( UDT.a(1) = 4 )

		CU_ASSERT( @UDT.a(0) = @x.a(0) )

		dim y(0 to 1) as UDT
		y(0).a(0) = 5
		y(0).a(1) = 6
		CU_ASSERT( y(0).a(0) = 5 )
		CU_ASSERT( y(0).a(1) = 6 )
		CU_ASSERT( y(1).a(0) = 5 )
		CU_ASSERT( y(1).a(1) = 6 )
	end sub
end namespace

namespace udts
	'' Same for field accesses

	type OtherUDT
		as integer a, b
	end type

	type UDT
		dummy as integer

		static a as OtherUDT
	end type

	dim UDT.a as OtherUDT

	type ContainerUDT
		x as UDT
	end type

	sub test cdecl( )
		UDT.a.a = 1
		UDT.a.b = 2
		CU_ASSERT( UDT.a.a = 1 )
		CU_ASSERT( UDT.a.b = 2 )

		dim x as UDT

		CU_ASSERT( x.a.a = 1 )
		CU_ASSERT( x.a.b = 2 )

		x.a.a = 3
		x.a.b = 4
		CU_ASSERT( x.a.a = 3 )
		CU_ASSERT( x.a.b = 4 )

		CU_ASSERT( UDT.a.a = 3 )
		CU_ASSERT( UDT.a.b = 4 )

		CU_ASSERT( @UDT.a.a = @x.a.a )

		dim y as ContainerUDT
		y.x.a.a = 5
		y.x.a.b = 6
		CU_ASSERT( y.x.a.a = 5 )
		CU_ASSERT( y.x.a.b = 6 )
	end sub
end namespace

namespace pointers
	type OtherUDT
		as integer a, b
	end type

	type UDT
		dummy as integer

		static p1 as integer ptr
		static p2 as OtherUDT ptr

		static fp1 as sub( )
		static fp2 as function( as integer ) as integer
	end type

	dim UDT.p1 as integer ptr
	dim UDT.p2 as OtherUDT ptr

	dim UDT.fp1 as sub( )
	dim UDT.fp2 as function( as integer ) as integer

	dim shared x1 as integer
	dim shared x2 as OtherUDT

	private sub f1( )
	end sub

	private function f2( byval i as integer ) as integer
		function = i
	end function

	sub test cdecl( )
		UDT.p1 = @x1
		UDT.p2 = @x2

		* UDT.p1  = 1
		*(UDT.p1) = 1

		   UDT.p2 ->a = 2
		(  UDT.p2)->a = 2
		(* UDT.p2) .a = 2
		(*(UDT.p2)).a = 2

		   UDT.p2 ->b = 3
		(  UDT.p2)->b = 3
		(* UDT.p2) .b = 3
		(*(UDT.p2)).b = 3

		CU_ASSERT( * UDT.p1  = 1 )
		CU_ASSERT( *(UDT.p1) = 1 )

		CU_ASSERT(    UDT.p2 ->a = 2 )
		CU_ASSERT( (  UDT.p2)->a = 2 )
		CU_ASSERT( (* UDT.p2) .a = 2 )
		CU_ASSERT( (*(UDT.p2)).a = 2 )

		CU_ASSERT(    UDT.p2 ->b = 3 )
		CU_ASSERT( (  UDT.p2)->b = 3 )
		CU_ASSERT( (* UDT.p2) .b = 3 )
		CU_ASSERT( (*(UDT.p2)).b = 3 )

		dim x as UDT

		* x.p1 = 1
		*(x.p1) = 1

		   x.p2 ->a = 2
		(  x.p2)->a = 2
		(* x.p2) .a = 2
		(*(x.p2)).a = 2

		   x.p2 ->b = 3
		(  x.p2)->b = 3
		(* x.p2) .b = 3
		(*(x.p2)).b = 3

		CU_ASSERT( * x.p1  = 1 )
		CU_ASSERT( *(x.p1) = 1 )

		CU_ASSERT(    x.p2 ->a = 2 )
		CU_ASSERT( (  x.p2)->a = 2 )
		CU_ASSERT( (* x.p2) .a = 2 )
		CU_ASSERT( (*(x.p2)).a = 2 )

		CU_ASSERT(    x.p2 ->b = 3 )
		CU_ASSERT( (  x.p2)->b = 3 )
		CU_ASSERT( (* x.p2) .b = 3 )
		CU_ASSERT( (*(x.p2)).b = 3 )

		dim y as UDT ptr = @x
		y->p1 = 0
		y->p2 = 0
		y->p1 = @x1
		y->p2 = @x2

		* y->p1 = 1
		*(y->p1) = 1

		   y->p2 ->a = 2
		(  y->p2)->a = 2
		(* y->p2) .a = 2
		(*(y->p2)).a = 2

		   y->p2 ->b = 3
		(  y->p2)->b = 3
		(* y->p2) .b = 3
		(*(y->p2)).b = 3

		CU_ASSERT( * y->p1  = 1 )
		CU_ASSERT( *(y->p1) = 1 )

		CU_ASSERT(    y->p2 ->a = 2 )
		CU_ASSERT( (  y->p2)->a = 2 )
		CU_ASSERT( (* y->p2) .a = 2 )
		CU_ASSERT( (*(y->p2)).a = 2 )

		CU_ASSERT(    y->p2 ->b = 3 )
		CU_ASSERT( (  y->p2)->b = 3 )
		CU_ASSERT( (* y->p2) .b = 3 )
		CU_ASSERT( (*(y->p2)).b = 3 )

		(*y).p1 = 0
		(*y).p2 = 0
		(*y).p1 = @x1
		(*y).p2 = @x2

		* (*y).p1 = 1
		*((*y).p1) = 1

		   (*y).p2 ->a = 2
		(  (*y).p2)->a = 2
		(* (*y).p2) .a = 2
		(*((*y).p2)).a = 2

		   (*y).p2 ->b = 3
		(  (*y).p2)->b = 3
		(* (*y).p2) .b = 3
		(*((*y).p2)).b = 3

		CU_ASSERT( * (*y).p1  = 1 )
		CU_ASSERT( *((*y).p1) = 1 )

		CU_ASSERT(    (*y).p2 ->a = 2 )
		CU_ASSERT( (  (*y).p2)->a = 2 )
		CU_ASSERT( (* (*y).p2) .a = 2 )
		CU_ASSERT( (*((*y).p2)).a = 2 )

		CU_ASSERT(    (*y).p2 ->b = 3 )
		CU_ASSERT( (  (*y).p2)->b = 3 )
		CU_ASSERT( (* (*y).p2) .b = 3 )
		CU_ASSERT( (*((*y).p2)).b = 3 )
	end sub
end namespace

namespace outsideOfOriginalNamespace
	namespace a
		namespace b
			type UDT
				dummy as integer
				static i1 as integer
				static i2 as integer
			end type
		end namespace

		dim b.UDT.i1 as integer
	end namespace

	dim a.b.UDT.i2 as integer

	sub test cdecl( )
		a.b.UDT.i1 = 123
		CU_ASSERT( a.b.UDT.i1 = 123 )

		a.b.UDT.i2 = 456
		CU_ASSERT( a.b.UDT.i2 = 456 )

		dim x as a.b.UDT

		CU_ASSERT( x.i1 = 123 )
		CU_ASSERT( x.i2 = 456 )
	end sub
end namespace

namespace initialized
	type UDT
		static i as integer
		static array(0 to 2) as short
		dummy as integer
	end type

	dim UDT.i as integer = 123
	dim UDT.array(0 to 2) as short = { 1, 2, 3 }

	sub test cdecl( )
		CU_ASSERT( UDT.i = 123 )
		CU_ASSERT( UDT.array(0) = 1 )
		CU_ASSERT( UDT.array(1) = 2 )
		CU_ASSERT( UDT.array(2) = 3 )
	end sub
end namespace

namespace inheritance
	type A extends object
		static i1 as integer
		static i3 as integer
	end type

	type B extends A
		static as integer i1, i2
	end type

	dim as integer A.i1, A.i3, B.i1, B.i2

	sub test cdecl( )
		A.i1 = 1
		A.i3 = 2

		B.i1 = 3
		B.i2 = 4

		CU_ASSERT( A.i1 = 1 )
		CU_ASSERT( A.i3 = 2 )

		CU_ASSERT( B.i1 = 3 )  '' it's B.i1, shadowing A.i1 
		CU_ASSERT( B.i2 = 4 )
		CU_ASSERT( B.i3 = 2 )  '' accessing A.i3 should work since it's inherited

		dim xa as A
		dim xb as B

		CU_ASSERT( xa.i1 = 1 )
		CU_ASSERT( xa.i3 = 2 )

		CU_ASSERT( xb.i1 = 3 )
		CU_ASSERT( xb.i2 = 4 )
		CU_ASSERT( xb.i3 = 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/member-var" )
	fbcu.add_test( "basic declaration/usage", @integers.test )
	fbcu.add_test( "array access parsing", @arrays.test )
	fbcu.add_test( "field access parsing", @udts.test )
	fbcu.add_test( "pointer deref parsing", @pointers.test )
	fbcu.add_test( "member var bodies outside of parent namespace", @outsideOfOriginalNamespace.test )
	fbcu.add_test( "member var bodies with initializers", @initialized.test )
	fbcu.add_test( "inherited member vars", @inheritance.test )
end sub

end namespace
