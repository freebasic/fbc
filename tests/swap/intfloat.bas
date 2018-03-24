#include "fbcunit.bi"

#define NULL 0

SUITE( fbc_tests.swap_.intfloat )

	dim shared as integer global_a
	dim shared as integer global_b

	'' SWAP on vars
	TEST( variables )
		#macro make( TA, TB )
			scope
				dim as TA var_a
				dim as TB var_b

				static as TA static_var_a
				static as TB static_var_b

				var_a = 1
				var_b = 0
				swap var_a, var_b
				CU_ASSERT( var_a = 0 )
				CU_ASSERT( var_b = 1 )

				static_var_a = 1
				static_var_b = 0
				swap static_var_a, static_var_b
				CU_ASSERT( static_var_a = 0 )
				CU_ASSERT( static_var_b = 1 )

				var_a = 1
				static_var_b = 0
				swap var_a, static_var_b
				CU_ASSERT( var_a = 0 )
				CU_ASSERT( static_var_b = 1 )

				static_var_a = 1
				var_b = 0
				swap static_var_a, var_b
				CU_ASSERT( static_var_a = 0 )
				CU_ASSERT( var_b = 1 )
			end scope
		#endmacro

		make( byte, byte )
		make( byte, short )
		make( byte, integer )
		make( byte, longint )
		make( byte, single )
		make( byte, double )

		make( short, byte )
		make( short, short )
		make( short, integer )
		make( short, longint )
		make( short, single )
		make( short, double )

		make( integer, byte )
		make( integer, short )
		make( integer, integer )
		make( integer, longint )
		make( integer, single )
		make( integer, double )

		make( longint, byte )
		make( longint, short )
		make( longint, integer )
		make( longint, longint )
		make( longint, single )
		make( longint, double )

		make( single, byte )
		make( single, short )
		make( single, integer )
		make( single, longint )
		make( single, single )
		make( single, double )

		make( double, byte )
		make( double, short )
		make( double, integer )
		make( double, longint )
		make( double, single )
		make( double, double )

		global_a = 1
		global_b = 0
		swap global_a, global_b
		CU_ASSERT( global_a = 0 )
		CU_ASSERT( global_b = 1 )
	END_TEST

	'' SWAP on derefs
	TEST( derefs )
		#macro make( TA, TB )
			scope
				dim as TA ptr ptr_a = callocate( sizeof(TA) * 3 )
				dim as TB ptr ptr_b = callocate( sizeof(TB) * 3 )
				CU_ASSERT( ptr_a <> NULL )
				CU_ASSERT( ptr_b <> NULL )

				'' Derefs + surrounding memory check
				ptr_a[0] = 17
				ptr_a[1] = 1
				ptr_a[2] = 17
				ptr_b[0] = 31
				ptr_b[1] = 0
				ptr_b[2] = 31

				dim as integer i = 1
				swap ptr_a[i], ptr_b[i]

				CU_ASSERT( ptr_a[0] = 17 )
				CU_ASSERT( ptr_a[1] = 0 )
				CU_ASSERT( ptr_a[2] = 17 )
				CU_ASSERT( ptr_b[0] = 31 )
				CU_ASSERT( ptr_b[1] = 1 )
				CU_ASSERT( ptr_b[2] = 31 )

				swap ptr_a[0], ptr_b[0]

				CU_ASSERT( ptr_a[0] = 31 )
				CU_ASSERT( ptr_a[1] = 0 )
				CU_ASSERT( ptr_a[2] = 17 )
				CU_ASSERT( ptr_b[0] = 17 )
				CU_ASSERT( ptr_b[1] = 1 )
				CU_ASSERT( ptr_b[2] = 31 )

				swap ptr_a[2], ptr_b[2]

				CU_ASSERT( ptr_a[0] = 31 )
				CU_ASSERT( ptr_a[1] = 0 )
				CU_ASSERT( ptr_a[2] = 31 )
				CU_ASSERT( ptr_b[0] = 17 )
				CU_ASSERT( ptr_b[1] = 1 )
				CU_ASSERT( ptr_b[2] = 17 )

				deallocate( ptr_b )
				deallocate( ptr_a )
			end scope
		#endmacro

		make( byte, byte )
		make( byte, short )
		make( byte, integer )
		make( byte, longint )
		make( byte, single )
		make( byte, double )

		make( short, byte )
		make( short, short )
		make( short, integer )
		make( short, longint )
		make( short, single )
		make( short, double )

		make( integer, byte )
		make( integer, short )
		make( integer, integer )
		make( integer, longint )
		make( integer, single )
		make( integer, double )

		make( longint, byte )
		make( longint, short )
		make( longint, integer )
		make( longint, longint )
		make( longint, single )
		make( longint, double )

		make( single, byte )
		make( single, short )
		make( single, integer )
		make( single, longint )
		make( single, single )
		make( single, double )

		make( double, byte )
		make( double, short )
		make( double, integer )
		make( double, longint )
		make( double, single )
		make( double, double )
	END_TEST

	dim shared as integer global_array(0 to 1)

	'' SWAP on arrays
	TEST( arrays )
		#macro make( TA, TB )
			scope
				static as TA static_array_a(0 to 2)
				static as TB static_array_b(0 to 2)

				dim as TA local_array_a(0 to 2)
				dim as TB local_array_b(0 to 2)

				dim as integer i = 1

				'' Local array accesses + surrounding memory check
				local_array_a(0) = 17
				local_array_a(1) = 1
				local_array_a(2) = 17
				local_array_b(0) = 31
				local_array_b(1) = 0
				local_array_b(2) = 31

				swap local_array_a(i), local_array_b(i)

				CU_ASSERT( local_array_a(0) = 17 )
				CU_ASSERT( local_array_a(1) = 0 )
				CU_ASSERT( local_array_a(2) = 17 )
				CU_ASSERT( local_array_b(0) = 31 )
				CU_ASSERT( local_array_b(1) = 1 )
				CU_ASSERT( local_array_b(2) = 31 )

				swap local_array_a(0), local_array_b(0)

				CU_ASSERT( local_array_a(0) = 31 )
				CU_ASSERT( local_array_a(1) = 0 )
				CU_ASSERT( local_array_a(2) = 17 )
				CU_ASSERT( local_array_b(0) = 17 )
				CU_ASSERT( local_array_b(1) = 1 )
				CU_ASSERT( local_array_b(2) = 31 )

				swap local_array_a(2), local_array_b(2)

				CU_ASSERT( local_array_a(0) = 31 )
				CU_ASSERT( local_array_a(1) = 0 )
				CU_ASSERT( local_array_a(2) = 31 )
				CU_ASSERT( local_array_b(0) = 17 )
				CU_ASSERT( local_array_b(1) = 1 )
				CU_ASSERT( local_array_b(2) = 17 )

				'' Static arrays + surrounding memory check
				static_array_a(0) = 17
				static_array_a(1) = 1
				static_array_a(2) = 17
				static_array_b(0) = 31
				static_array_b(1) = 0
				static_array_b(2) = 31

				swap static_array_a(i), static_array_b(i)

				CU_ASSERT( static_array_a(0) = 17 )
				CU_ASSERT( static_array_a(1) = 0 )
				CU_ASSERT( static_array_a(2) = 17 )
				CU_ASSERT( static_array_b(0) = 31 )
				CU_ASSERT( static_array_b(1) = 1 )
				CU_ASSERT( static_array_b(2) = 31 )
			end scope
		#endmacro

		make( byte, byte )
		make( byte, short )
		make( byte, integer )
		make( byte, longint )
		make( byte, single )
		make( byte, double )

		make( short, byte )
		make( short, short )
		make( short, integer )
		make( short, longint )
		make( short, single )
		make( short, double )

		make( integer, byte )
		make( integer, short )
		make( integer, integer )
		make( integer, longint )
		make( integer, single )
		make( integer, double )

		make( longint, byte )
		make( longint, short )
		make( longint, integer )
		make( longint, longint )
		make( longint, single )
		make( longint, double )

		make( single, byte )
		make( single, short )
		make( single, integer )
		make( single, longint )
		make( single, single )
		make( single, double )

		make( double, byte )
		make( double, short )
		make( double, integer )
		make( double, longint )
		make( double, single )
		make( double, double )

		global_array(0) = 1
		global_array(1) = 0
		swap global_array(0), global_array(1)
		CU_ASSERT( global_array(0) = 0 )
		CU_ASSERT( global_array(1) = 1 )
	END_TEST

	'' Mixes of var/deref/array
	TEST( mixups )
		#macro make( TA, TB )
			scope
				dim as TA var_a
				dim as TB var_b

				static as TA static_var_a
				static as TB static_var_b

				dim as TA local_array_a(0 to 2)
				dim as TB local_array_b(0 to 2)

				static as TA static_array_a(0 to 2)
				static as TB static_array_b(0 to 2)

				dim as TA ptr ptr_a = callocate( sizeof(TA) * 3 )
				dim as TB ptr ptr_b = callocate( sizeof(TB) * 3 )
				CU_ASSERT( ptr_a <> NULL )
				CU_ASSERT( ptr_b <> NULL )

				scope
					var_a = 1
					ptr_b[0] = 31
					ptr_b[1] = 0
					ptr_b[2] = 31
					dim as integer i = 1
					swap var_a, ptr_b[i]
					CU_ASSERT( var_a = 0 )
					CU_ASSERT( ptr_b[0] = 31 )
					CU_ASSERT( ptr_b[1] = 1 )
					CU_ASSERT( ptr_b[2] = 31 )
				end scope

				scope
					ptr_a[0] = 17
					ptr_a[1] = 1
					ptr_a[2] = 17
					var_b = 0
					dim as integer i = 1
					swap ptr_a[i], var_b
					CU_ASSERT( ptr_a[0] = 17 )
					CU_ASSERT( ptr_a[1] = 0 )
					CU_ASSERT( ptr_a[2] = 17 )
					CU_ASSERT( var_b = 1 )
				end scope

				scope
					var_a = 1
					local_array_b(0) = 31
					local_array_b(1) = 0
					local_array_b(2) = 31

					dim as integer i = 1
					swap var_a, local_array_b(i)

					CU_ASSERT( var_a = 0 )
					CU_ASSERT( local_array_b(0) = 31 )
					CU_ASSERT( local_array_b(1) = 1 )
					CU_ASSERT( local_array_b(2) = 31 )
				end scope

				scope
					local_array_a(0) = 17
					local_array_a(1) = 1
					local_array_a(2) = 17
					var_b = 0

					dim as integer i = 1
					swap local_array_a(i), var_b

					CU_ASSERT( local_array_a(0) = 17 )
					CU_ASSERT( local_array_a(1) = 0 )
					CU_ASSERT( local_array_a(2) = 17 )
					CU_ASSERT( var_b = 1 )
				end scope

				deallocate( ptr_b )
				deallocate( ptr_a )
			end scope
		#endmacro

		make( byte, byte )
		make( byte, short )
		make( byte, integer )
		make( byte, longint )
		make( byte, single )
		make( byte, double )

		make( short, byte )
		make( short, short )
		make( short, integer )
		make( short, longint )
		make( short, single )
		make( short, double )

		make( integer, byte )
		make( integer, short )
		make( integer, integer )
		make( integer, longint )
		make( integer, single )
		make( integer, double )

		make( longint, byte )
		make( longint, short )
		make( longint, integer )
		make( longint, longint )
		make( longint, single )
		make( longint, double )

		make( single, byte )
		make( single, short )
		make( single, integer )
		make( single, longint )
		make( single, single )
		make( single, double )

		make( double, byte )
		make( double, short )
		make( double, integer )
		make( double, longint )
		make( double, single )
		make( double, double )
	END_TEST

	'' SWAP should swap values not just bytes
	TEST( swapsValuesNotJustBytes )
		#macro make( TA, NA1, NA2, TB, NB1, NB2 )
			scope
				dim as TA var_a = NA1
				dim as TB var_b = NB1

				swap var_a, var_b

				CU_ASSERT( var_a = NA2 )
				CU_ASSERT( var_b = NB2 )
			end scope

			scope
				dim as TA var_a = NA1
				dim as TB var_b = NB1
				dim as TA ptr ptr_a = @var_a
				dim as TB ptr ptr_b = @var_b

				dim as integer i = 0
				swap ptr_a[i], ptr_b[i]

				CU_ASSERT( var_a = NA2 )
				CU_ASSERT( var_b = NB2 )
			end scope

			scope
				dim as TA array_a(0 to 0) = { NA1 }
				dim as TB array_b(0 to 0) = { NB1 }

				dim as integer i = 0
				swap array_a(i), array_b(i)

				CU_ASSERT( array_a(0) = NA2 )
				CU_ASSERT( array_b(0) = NB2 )
			end scope
		#endmacro

		make( byte, -1, 0, short, 0, -1 )
		make( byte, 0, -1, short, -1, 0 )
		make( short, -1, 0, byte, 0, -1 )
		make( short, 0, -1, byte, -1, 0 )

		make( byte, &h11, 0, short, 0, &h11 )
		make( short, 0, &h11, byte, &h11, 0 )

		make( byte, 0, &h11, short, &h2211, 0 )
		make( short, &h2211, 0, byte, 0, &h11 )

		make( short, 0, &h2211, integer, &h44332211, 0 )
		make( integer, &h44332211, 0, short, 0, &h2211 )

		make( byte, 0, &h11, integer, &h44332211, 0 )
		make( integer, &h44332211, 0, byte, 0, &h11 )

		#macro makeFloat( TA, NA1, NA2, TB, NB1, NB2 )
			scope
				dim as TA var_a = NA1
				dim as TB var_b = NB1

				swap var_a, var_b

				CU_ASSERT( abs( var_a ) - abs( NA2 ) < 0.1 )
				CU_ASSERT( abs( var_b ) - abs( NB2 ) < 0.1 )
			end scope

			scope
				dim as TA var_a = NA1
				dim as TB var_b = NB1
				dim as TA ptr ptr_a = @var_a
				dim as TB ptr ptr_b = @var_b

				dim as integer i = 0
				swap ptr_a[i], ptr_b[i]

				CU_ASSERT( abs( var_a ) - abs( NA2 ) < 0.1 )
				CU_ASSERT( abs( var_b ) - abs( NB2 ) < 0.1 )
			end scope

			scope
				dim as TA array_a(0 to 0) = { NA1 }
				dim as TB array_b(0 to 0) = { NB1 }

				dim as integer i = 0
				swap array_a(i), array_b(i)

				CU_ASSERT( abs( array_a(0) ) - abs( NA2 ) < 0.1 )
				CU_ASSERT( abs( array_b(0) ) - abs( NB2 ) < 0.1 )
			end scope
		#endmacro

		makeFloat( single, 53, -1, integer, -1, 53 )
		makeFloat( integer, -1, 53, single, 53, -1 )

		makeFloat( double, 3.1, -1.1, single, -1.1, 3.1 )
		makeFloat( single, -1.1, 3.1, double, 3.1, -1.1 )
	END_TEST

	'' SWAP on fields
	TEST( fields )
		type T
			as integer a, b
		end type

		dim as T x
		x.a = 1
		x.b = 0

		swap x.a, x.b

		CU_ASSERT( x.a = 0 )
		CU_ASSERT( x.b = 1 )
	END_TEST

	'' bug #3215431 regression test
	TEST( bug3215431 )
		scope
			dim as ubyte array(9, 9)
			dim as ubyte i = 5, j = 5, t
			t = i * j

			swap t, array(i, j)

			CU_ASSERT( array(5, 5) = 25 )
		end scope

		scope
			dim as ubyte array(9)
			dim as ubyte i = 5, t = 123

			swap t, array(i)

			CU_ASSERT( array(5) = 123 )
		end scope
	END_TEST

END_SUITE
