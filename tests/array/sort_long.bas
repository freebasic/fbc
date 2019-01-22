#include "fbcunit.bi"
#include "ustring.bi"
#include  "array.bi"


private FUNCTION CustomSortProc_Long CDECL (BYVAL a AS long PTR, BYVAL b AS long PTR) AS LONG
'***********************************************************************************************
' qsort custom comparison function
' return  1, if a should precede b in sorting
' return -1, if b should precede a in sorting
' return  0, if both are equal
' for UDT: compare member variable(s) to get the desired order
'***********************************************************************************************

  if *a > *b then 
    return 1
  elseif *a < *b then
    return -1
  else
    return 0
  end if  


END FUNCTION


SUITE( fbc_tests.array.sort_long )
 

    TEST( sort_descending )

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

      array_sort(a, descend_)
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) = 11 )
      CU_ASSERT( a(2) = 10 )
      CU_ASSERT( a(3) = 9 )
      CU_ASSERT( a(4) = 8 )
      CU_ASSERT( a(5) = 7 )  
      CU_ASSERT( a(6) = 6 )
      CU_ASSERT( a(7) = 5 )
      CU_ASSERT( a(8) = 4 )
      CU_ASSERT( a(9) = 3 )
      CU_ASSERT( a(10) = 2 )
      CU_ASSERT( a(11) = 1 )

    END_TEST


    TEST( sort_ascending )

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

      array_sort(a, ascend_)
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  1 )
      CU_ASSERT( a(2) =  2 )
      CU_ASSERT( a(3) =  3 )
      CU_ASSERT( a(4) =  4 )
      CU_ASSERT( a(5) =  5 )
      CU_ASSERT( a(6) =  6 )
      CU_ASSERT( a(7) =  7 )
      CU_ASSERT( a(8) =  8 )
      CU_ASSERT( a(9) =  9 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( sort_ascending_2 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  5
      a(2) =  2
      a(3) =  3
      a(4) =  4
      a(5) =  1
      a(6) =  7
      a(7) =  6
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_sort(a, ascend, 1, 1, 5)                  'sort dimenson 1, from 1, for 5 elements
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  1 )
      CU_ASSERT( a(2) =  2 )
      CU_ASSERT( a(3) =  3 )
      CU_ASSERT( a(4) =  4 )
      CU_ASSERT( a(5) =  5 )
      CU_ASSERT( a(6) =  7 )
      CU_ASSERT( a(7) =  6 )
      CU_ASSERT( a(8) =  8 )
      CU_ASSERT( a(9) =  9 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( sort_ascending_3 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  2
      a(2) =  1
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  7
      a(7) =  6
      a(8) =  8
      a(9) =  9
      a(10) = 10
      a(11) = 11

      array_sort(a, ascend, 1, 5, 6)                  'sort dimenson 1, from 5, for 6 elements
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  2 )
      CU_ASSERT( a(2) =  1 )
      CU_ASSERT( a(3) =  3 )
      CU_ASSERT( a(4) =  4 )
      CU_ASSERT( a(5) =  5 )
      CU_ASSERT( a(6) =  6 )
      CU_ASSERT( a(7) =  7 )
      CU_ASSERT( a(8) =  8 )
      CU_ASSERT( a(9) =  9 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( sort_ascending_4 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  2
      a(2) =  1
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 11
      a(11) = 10

      array_sort(a, ascend, all())
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  1 )
      CU_ASSERT( a(2) =  2 )
      CU_ASSERT( a(3) =  3 )
      CU_ASSERT( a(4) =  4 )
      CU_ASSERT( a(5) =  5 )
      CU_ASSERT( a(6) =  6 )
      CU_ASSERT( a(7) =  7 )
      CU_ASSERT( a(8) =  8 )
      CU_ASSERT( a(9) =  9 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( sort_ascending_5 )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  2
      a(2) =  1
      a(3) =  3
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 11
      a(11) = 10

      array_sort(a, ascend, all(1))                   'sort entire 1. dimension
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  1 )
      CU_ASSERT( a(2) =  2 )
      CU_ASSERT( a(3) =  3 )
      CU_ASSERT( a(4) =  4 )
      CU_ASSERT( a(5) =  5 )
      CU_ASSERT( a(6) =  6 )
      CU_ASSERT( a(7) =  7 )
      CU_ASSERT( a(8) =  8 )
      CU_ASSERT( a(9) =  9 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


    TEST( sort_ascending_6 )

      DIM a() AS long
      redim a(1 to 5, 1 to 6)
      a(1,1) =  1
      a(1,2) =  2
      a(1,3) =  3
      a(1,4) =  4
      a(1,5) =  5
      a(2,1) =  6
      a(2,2) =  9
      a(2,3) =  8
      a(2,4) =  7
      a(2,5) = 11
      a(2,6) = 10

      array_sort(a, ascend, all(2))                   'sort entire 2. dimension
      CU_ASSERT( ubound(a) = 5 )
      CU_ASSERT( ubound(a, 2) = 6 )
      CU_ASSERT( a(1,1) = 1 )
      CU_ASSERT( a(1,2) = 2 )
      CU_ASSERT( a(1,3) = 3 )
      CU_ASSERT( a(1,4) = 4 )
      CU_ASSERT( a(1,5) = 5 )
      CU_ASSERT( a(2,1) = 6 )
      CU_ASSERT( a(2,2) = 7 )
      CU_ASSERT( a(2,3) = 8 )
      CU_ASSERT( a(2,4) = 9 )
      CU_ASSERT( a(2,5) = 10 )
      CU_ASSERT( a(2,6) = 11 )

    END_TEST


    TEST( sort_ascending_7 )

      DIM a() AS long
      redim a(1 to 5, 1 to 6)
      a(1,1) =  1
      a(1,2) =  2
      a(1,3) =  3
      a(1,4) =  4
      a(1,5) =  5
      a(2,1) =  7
      a(2,2) =  6
      a(2,3) =  9
      a(2,4) =  8
      a(2,5) = 11
      a(2,6) = 10

      array_sort(a, ascend, 2, 3, 4)                  'sort 2. dimension, from 3 for 4 elements
      CU_ASSERT( ubound(a) = 5 )
      CU_ASSERT( ubound(a, 2) = 6 )
      CU_ASSERT( a(1,1) = 1 )
      CU_ASSERT( a(1,2) = 2 )
      CU_ASSERT( a(1,3) = 3 )
      CU_ASSERT( a(1,4) = 4 )
      CU_ASSERT( a(1,5) = 5 )
      CU_ASSERT( a(2,1) = 7 )
      CU_ASSERT( a(2,2) = 6 )
      CU_ASSERT( a(2,3) = 8 )
      CU_ASSERT( a(2,4) = 9 )
      CU_ASSERT( a(2,5) = 10 )
      CU_ASSERT( a(2,6) = 11 )

    END_TEST


    TEST( sort_ascending_8 )

      DIM a() AS long
      redim a(1 to 5, 1 to 6)
      a(1,1) =  10
      a(1,2) =  2
      a(1,3) =  3
      a(1,4) =  4
      a(1,5) =  5
'      a(1,6) =  0                                     'implicit gap !
      a(2,1) =  6
      a(2,2) =  7
      a(2,3) =  8
      a(2,4) =  9
      a(2,5) = 1
      a(2,6) = 11

      array_sort(a, ascend, all())                    'sort entire array
      CU_ASSERT( ubound(a) = 5 )
      CU_ASSERT( ubound(a, 2) = 6 )
      CU_ASSERT( a(1,1) = 0 )                         'this is the "gap" from implicit a(1,6)
      CU_ASSERT( a(1,2) = 1 )
      CU_ASSERT( a(1,3) = 2 )
      CU_ASSERT( a(1,4) = 3 )
      CU_ASSERT( a(1,5) = 4 )
      CU_ASSERT( a(2,1) = 6 )
      CU_ASSERT( a(2,2) = 7 )
      CU_ASSERT( a(2,3) = 8 )
      CU_ASSERT( a(2,4) = 9 )
      CU_ASSERT( a(2,5) = 10 )
      CU_ASSERT( a(2,6) = 11 )

    END_TEST


    TEST( sort_custom )

      DIM a() AS long
      redim a(1 to 11)
      a(1) =  2
      a(2) =  3
      a(3) =  1
      a(4) =  4
      a(5) =  5
      a(6) =  6
      a(7) =  7
      a(8) =  8
      a(9) =  9
      a(10) = 11
      a(11) = 10

      array_sort(a, @CustomSortProc_Long, all(1))
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  1 )
      CU_ASSERT( a(2) =  2 )
      CU_ASSERT( a(3) =  3 )
      CU_ASSERT( a(4) =  4 )
      CU_ASSERT( a(5) =  5 )
      CU_ASSERT( a(6) =  6 )
      CU_ASSERT( a(7) =  7 )
      CU_ASSERT( a(8) =  8 )
      CU_ASSERT( a(9) =  9 )
      CU_ASSERT( a(10) = 10 )
      CU_ASSERT( a(11) = 11 )

    END_TEST


END_SUITE
