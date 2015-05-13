' TEST_MODE : COMPILE_ONLY_OK

'' Note: Procedures that aren't called here should be public (not private),
'' to ensure they're getting emitted (-gen gcc regression tests).

'' procptrs in main scope and main namespace
declare sub sub1( byval as sub( ) )
declare sub sub2( byval as sub( ) )
sub sub1( byval p as sub( ) ) : end sub
sub sub2( byval p as sub( ) ) : end sub

type T1
	as integer a, b, c
end type

declare sub sub3( byval as sub( byref as T1 ) )
declare sub sub4( byval as sub( byref as T1 ) )
declare sub sub5( byval as sub( byval as T1 ptr ) )
declare sub sub6( byval as sub( byval as T1 ptr ) )
sub sub3( byval p as sub( byref as T1 ) ) : end sub
sub sub4( byval p as sub( byref as T1 ) ) : end sub
sub sub5( byval p as sub( byval as T1 ptr ) ) : end sub
sub sub6( byval p as sub( byval as T1 ptr ) ) : end sub

dim as sub( ) p1
dim as sub( ) p2 = p1
sub1( p1 )
sub2( p2 )

dim as sub( byref as T1 ) p3
dim as sub( byref as T1 ) p4 = p3
dim as sub( byval as T1 ptr ) p5
dim as sub( byval as T1 ptr ) p6 = p5
sub3( p3 )
sub4( p4 )
sub5( p5 )
sub6( p6 )

scope
	'' procptrs in nested scope and main namespace
	dim as sub( ) p1
	dim as sub( ) p2 = p1
	sub1( p1 )
	sub2( p2 )

	dim as sub( byref as T1 ) p3
	dim as sub( byref as T1 ) p4 = p3
	dim as sub( byval as T1 ptr ) p5
	dim as sub( byval as T1 ptr ) p6 = p5
	sub3( p3 )
	sub4( p4 )
	sub5( p5 )
	sub6( p6 )
end scope

namespace nested1
	'' procptrs in main scope and nested namespace
	declare sub sub1( byval as sub( ) )
	declare sub sub2( byval as sub( ) )
	sub sub1( byval p as sub( ) ) : end sub
	sub sub2( byval p as sub( ) ) : end sub

	'' using T1 from parent namespace
	declare sub sub3( byval as sub( byref as T1 ) )
	declare sub sub4( byval as sub( byref as T1 ) )
	declare sub sub5( byval as sub( byval as T1 ptr ) )
	declare sub sub6( byval as sub( byval as T1 ptr ) )
	sub sub3( byval p as sub( byref as T1 ) ) : end sub
	sub sub4( byval p as sub( byref as T1 ) ) : end sub
	sub sub5( byval p as sub( byval as T1 ptr ) ) : end sub
	sub sub6( byval p as sub( byval as T1 ptr ) ) : end sub

	declare sub overload1 overload( byval as sub( byref as T1 ) )
	declare sub overload2 overload( byval as sub( byref as T1 ) )
	declare sub overload3 overload( byval as sub( byval as T1 ptr ) )
	declare sub overload4 overload( byval as sub( byval as T1 ptr ) )
	sub overload1 overload( byval p as sub( byref as T1 ) ) : end sub
	sub overload2 overload( byval p as sub( byref as T1 ) ) : end sub
	sub overload3 overload( byval p as sub( byval as T1 ptr ) ) : end sub
	sub overload4 overload( byval p as sub( byval as T1 ptr ) ) : end sub

	type T2
		as integer a, b, c
	end type

	declare sub sub7( byval as sub( byref as T2 ) )
	declare sub sub8( byval as sub( byref as T2 ) )
	declare sub sub9( byval as sub( byval as T2 ptr ) )
	declare sub sub10( byval as sub( byval as T2 ptr ) )
	sub sub7( byval p as sub( byref as T2 ) ) : end sub
	sub sub8( byval p as sub( byref as T2 ) ) : end sub
	sub sub9( byval p as sub( byval as T2 ptr ) ) : end sub
	sub sub10( byval p as sub( byval as T2 ptr ) ) : end sub

	dim as sub( ) p1
	dim as sub( ) p2
	dim as sub( byref as T1 ) p3
	dim as sub( byref as T1 ) p4
	dim as sub( byval as T1 ptr ) p5
	dim as sub( byval as T1 ptr ) p6
	dim as sub( byref as T2 ) p7
	dim as sub( byref as T2 ) p8
	dim as sub( byval as T2 ptr ) p9
	dim as sub( byval as T2 ptr ) p10

	'' procptrs in nested scope and nested namespace
	sub scopeNestedInsideNamespace1( )
		dim as sub( ) p1
		dim as sub( ) p2 = p1
		sub1( p1 )
		sub2( p2 )

		dim as sub( byref as T1 ) p3
		dim as sub( byref as T1 ) p4 = p3
		dim as sub( byval as T1 ptr ) p5
		dim as sub( byval as T1 ptr ) p6 = p5
		dim as sub( byref as T2 ) p7
		dim as sub( byref as T2 ) p8 = p7
		dim as sub( byval as T2 ptr ) p9
		dim as sub( byval as T2 ptr ) p10 = p9
		sub3( p3 )
		sub4( p4 )
		sub5( p5 )
		sub6( p6 )
		sub7( p7 )
		sub8( p8 )
		sub9( p9 )
		sub10( p10 )
	end sub

	'' Overriding T1 with this new one
	type T1
		as integer i
	end type

	sub scopeNestedInsideNamespace2( )
		dim as sub( byref as T1 ) p3
		dim as sub( byref as T1 ) p4 = p3
		dim as sub( byval as T1 ptr ) p5
		dim as sub( byval as T1 ptr ) p6 = p5
	end sub

	'' This should work -- it's a different T1 now, so the overloads are
	'' different aswell.
	declare sub overload1 overload( byval as sub( byref as T1 ) )
	declare sub overload2 overload( byval as sub( byref as T1 ) )
	declare sub overload3 overload( byval as sub( byval as T1 ptr ) )
	declare sub overload4 overload( byval as sub( byval as T1 ptr ) )
	sub overload1 overload( byval p as sub( byref as T1 ) ) : end sub
	sub overload2 overload( byval p as sub( byref as T1 ) ) : end sub
	sub overload3 overload( byval p as sub( byval as T1 ptr ) ) : end sub
	sub overload4 overload( byval p as sub( byval as T1 ptr ) ) : end sub
end namespace
