#include "fbcunit.bi"
#include "array.bi"


SUITE( fbc_tests.array.del_long )
 

    TEST( delete_11 )

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

      array_delete(a, 11)
      CU_ASSERT( ubound(a) = 10 )
      CU_ASSERT( a(1) = 1  )
      CU_ASSERT( a(2) = 2  )
      CU_ASSERT( a(3) = 3  )
      CU_ASSERT( a(4) = 4  )
      CU_ASSERT( a(5) = 5  )
      CU_ASSERT( a(6) = 6  )
      CU_ASSERT( a(7) = 7  )
      CU_ASSERT( a(8) = 8  )
      CU_ASSERT( a(9) = 9  )
      CU_ASSERT( a(10) = 10 )

    END_TEST


    TEST( delete_1 )

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

      array_delete(a, 1)
      CU_ASSERT( ubound(a) = 10 )
      CU_ASSERT( a(1) = 2 )
      CU_ASSERT( a(2) = 3  )
      CU_ASSERT( a(3) = 4  )
      CU_ASSERT( a(4) = 5  )
      CU_ASSERT( a(5) = 6  )
      CU_ASSERT( a(6) = 7  )
      CU_ASSERT( a(7) = 8  )
      CU_ASSERT( a(8) = 9  )
      CU_ASSERT( a(9) = 10 )
      CU_ASSERT( a(10) = 11 )

    END_TEST


    TEST( delete_5 )

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

      array_delete(a, 5)
      CU_ASSERT( ubound(a) = 10 )
      CU_ASSERT( a(4) = 4 )
      CU_ASSERT( a(5) = 6 )
      CU_ASSERT( a(6) = 7 )

    END_TEST


END_SUITE
