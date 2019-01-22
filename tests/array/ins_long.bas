#include "fbcunit.bi"
#include "array.bi"


SUITE( fbc_tests.array.ins_long )
 

    TEST( insert_11 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  1
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_insert(a, 11, 99)
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 99 )
      CU_ASSERT( a(12) = 11 )

    END_TEST


    TEST( insert_12 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  1
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_insert(a, 12, 98)
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(12) = 98 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( insert_1 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  1
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_insert(a, 1, 97)
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(1) = 97 )
      CU_ASSERT( a(2) = 1 )

    END_TEST


    TEST( insert_5 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  1
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_insert(a, 5, 96)
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(4) = 4 )
      CU_ASSERT( a(5) = 96 )
      CU_ASSERT( a(6) = 5 )

    END_TEST


    TEST( insert_13 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  1
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_insert(a, 13, 95)
      CU_ASSERT( err = 6 )
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( insert_0 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  1
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_insert(a, 0, 94)
      CU_ASSERT( err = 6 )
      CU_ASSERT( lbound(a) = 1 )
      CU_ASSERT( a(1) = 1 )
      CU_ASSERT( a(1) = 1 )

    END_TEST


END_SUITE
