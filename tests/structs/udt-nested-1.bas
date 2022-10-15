#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_nested_1 )

	type T1
		a as long
		b as long
		c as short
		d as longint

		declare sub p1( byval arg as T1 )
		declare function f1() as T1

		type T2
			a as short
			b as short
			c as long
			e as longint

			declare sub p1( byval arg as T1 )
			declare sub p2( byval arg as T2 )
			declare function f1() as T1
			declare function f2() as T2
		end type

		declare sub p2( byval arg as T2 )
		declare function f2() as T2

	end type

	#macro chk_t1( o, x, y, z )
		CU_ASSERT_EQUAL( o.a, x )
		CU_ASSERT_EQUAL( o.b, y )
		CU_ASSERT_EQUAL( o.c, z )
		CU_ASSERT( sizeof(o.a) = sizeof(long) )
		CU_ASSERT( sizeof(o.b) = sizeof(long) )
		CU_ASSERT( sizeof(o.c) = sizeof(short) )
	#endmacro

	#macro set_t1( o, x, y, z )
		o.a = x
		o.b = y
		o.c = z
		o.d = 1
	#endmacro

	#macro chk_t2( o, x, y, z )
		CU_ASSERT_EQUAL( o.a, x )
		CU_ASSERT_EQUAL( o.b, y )
		CU_ASSERT_EQUAL( o.c, z )
		CU_ASSERT( sizeof(o.a) = sizeof(short) )
		CU_ASSERT( sizeof(o.b) = sizeof(short) )
		CU_ASSERT( sizeof(o.c) = sizeof(long) )
	#endmacro

	#macro set_t2( o, x, y, z )
		o.a = x
		o.b = y
		o.c = z
		o.e = 1
	#endmacro

	sub T1.p1( byval arg as T1 )
		CU_ASSERT( sizeof(this) = sizeof(T1) )
		CU_ASSERT( sizeof(arg) = sizeof(T1) )
		chk_t1( this, 101, 102, 103 )
		chk_t1( arg , 111, 112, 113 )
		set_t1( this, 121, 122, 123 )
		set_t1( arg , 131, 132, 133 )
	end sub

	sub T1.p2( byval arg as T2 )
		CU_ASSERT( sizeof(this) = sizeof(T1) )
		CU_ASSERT( sizeof(arg) = sizeof(T2) )
		chk_t1( this, 201, 202, 203 )
		chk_t2( arg , 211, 212, 213 )
		set_t1( this, 221, 222, 223 )
		set_t2( arg , 231, 232, 233 )
	end sub

	sub T1.T2.p1( byval arg as T1 )
		CU_ASSERT( sizeof(this) = sizeof(T2) )
		CU_ASSERT( sizeof(arg) = sizeof(T1) )
		chk_t2( this, 301, 302, 303 )
		chk_t1( arg , 311, 312, 313 )
		set_t2( this, 321, 322, 323 )
		set_t1( arg , 331, 332, 333 )
	end sub

	sub T1.T2.p2( byval arg as T2 )
		CU_ASSERT( sizeof(this) = sizeof(T2) )
		CU_ASSERT( sizeof(arg) = sizeof(T2) )
		chk_t2( this, 401, 402, 403 )
		chk_t2( arg , 411, 412, 413 )
		set_t2( this, 421, 422, 423 )
		set_t2( arg , 431, 432, 433 )
	end sub

	function T1.f1() as T1
		CU_ASSERT( sizeof(this) = sizeof(T1) )
		dim ret as T1
		chk_t1( this, 501, 502, 503 )
		set_t1( this, 521, 522, 523 )
		set_t1( ret , 531, 532, 533 )
		function = ret
	end function

	function T1.f2() as T2
		CU_ASSERT( sizeof(this) = sizeof(T1) )
		dim ret as T2
		chk_t1( this, 601, 602, 603 )
		set_t1( this, 621, 622, 623 )
		set_t2( ret , 631, 632, 633 )
		function = ret
	end function

	function T1.T2.f1() as T1
		CU_ASSERT( sizeof(this) = sizeof(T2) )
		dim ret as T1
		chk_t2( this, 701, 702, 703 )
		set_t2( this, 721, 722, 723 )
		set_t1( ret , 731, 732, 733 )
		function = ret
	end function

	function T1.T2.f2() as T2
		CU_ASSERT( sizeof(this) = sizeof(T2) )
		dim ret as T2
		chk_t2( this, 801, 802, 803 )
		set_t2( this, 821, 822, 823 )
		set_t2( ret , 831, 832, 833 )
		function = ret
	end function

	TEST( default )

		dim as T1    x1, y1, z1
		dim as T1.T2 x2, y2, z2

		'' outer instance / outer argument
		set_t1( x1, 101, 102, 103 )
		set_t1( y1, 111, 112, 113 )
		x1.p1( y1 )
		chk_t1( x1, 121, 122, 123 )
		chk_t1( y1, 111, 112, 113 )

		'' outer instance / inner argument
		set_t1( x1, 201, 202, 203 )
		set_t2( y2, 211, 212, 213 )
		x1.p2( y2 )
		chk_t1( x1, 221, 222, 223 )
		chk_t2( y2, 211, 212, 213 )

		'' inner instance / outer argument
		set_t2( x2, 301, 302, 303 )
		set_t1( y1, 311, 312, 313 )
		x2.p1( y1 )
		chk_t2( x2, 321, 322, 323 )
		chk_t1( y1, 311, 312, 313 )

		'' inner instance / inner argument
		set_t2( x2, 401, 402, 403 )
		set_t2( y2, 411, 412, 413 )
		x2.p2( y2 )
		chk_t2( x2, 421, 422, 423 )
		chk_t2( y2, 411, 412, 413 )

		'' outer instance / outer result
		set_t1( x1, 501, 502, 503 )
		set_t1( z1, 511, 512, 513 )
		z1 = x1.f1()
		chk_t1( x1, 521, 522, 523 )
		chk_t1( z1, 531, 532, 533 )

		'' outer instance / inner result
		set_t1( x1, 601, 602, 603 )
		set_t2( z2, 611, 612, 613 )
		z2 = x1.f2()
		chk_t1( x1, 621, 622, 623 )
		chk_t2( z2, 631, 632, 633 )

		'' inner instance / outer result
		set_t2( x2, 701, 702, 703 )
		set_t1( z1, 711, 712, 713 )
		z1 = x2.f1()
		chk_t2( x2, 721, 722, 723 )
		chk_t1( z1, 731, 732, 733 )

		'' inner instance / inner result
		set_t2( x2, 801, 802, 803 )
		set_t2( z2, 811, 813, 813 )
		z2 = x2.f2()
		chk_t2( x2, 821, 822, 823 )
		chk_t2( z2, 831, 832, 833 )

	END_TEST

END_SUITE
