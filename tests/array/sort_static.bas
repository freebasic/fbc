#include "fbcunit.bi"
#include "ustring.bi"
#include once "array.bi"


private FUNCTION CustomSortProc_SUstring CDECL (BYVAL a AS ustring PTR, BYVAL b AS ustring PTR) AS LONG
'***********************************************************************************************
' qsort custom comparison function
' return  1, if a should precede b in sorting
' return -1, if b should precede a in sorting
' return  0, if both are equal
' for UDT: compare member variable(s) to get the desired order
'***********************************************************************************************

  if ucase(*a) > ucase(*b) then                       'make it case insensitive
    return 1
  elseif ucase(*a) < ucase(*b) then
    return -1
  else
    return 0
  end if  


END FUNCTION


SUITE( fbc_tests.array.sort_static )
 

    TEST( sort_descending )

      DIM a(1 to 11) AS ustring 
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, descend_)
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) = "string9" )
      CU_ASSERT( a(2) = "string8" )
      CU_ASSERT( a(3) = "string7" )
      CU_ASSERT( a(4) = "string6" )
      CU_ASSERT( a(5) = "string11" )
      CU_ASSERT( a(6) = "string10" )
      CU_ASSERT( a(7) = "String5" )
      CU_ASSERT( a(8) = "String4" )
      CU_ASSERT( a(9) = "String3" )
      CU_ASSERT( a(10) = "String2" )
      CU_ASSERT( a(11) = "String1" )

    END_TEST


    TEST( sort_ascending )

      DIM a(1 to 11) AS ustring
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, ascend_)
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  "String1" )
      CU_ASSERT( a(2) =  "String2" )
      CU_ASSERT( a(3) =  "String3" )
      CU_ASSERT( a(4) =  "String4" )
      CU_ASSERT( a(5) =  "String5" )
      CU_ASSERT( a(6) =  "string10" )
      CU_ASSERT( a(7) =  "string11" )
      CU_ASSERT( a(8) =  "string6" )
      CU_ASSERT( a(9) =  "string7" )
      CU_ASSERT( a(10) = "string8" )
      CU_ASSERT( a(11) = "string9" )

    END_TEST


    TEST( sort_ascending_2 )

      DIM a(1 to 11) AS ustring
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, ascend, 1, 1, 5)                  'sort dimenson 1, from 1, for 5 elements
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  "String1" )
      CU_ASSERT( a(2) =  "String2" )
      CU_ASSERT( a(3) =  "String3" )
      CU_ASSERT( a(4) =  "String4" )
      CU_ASSERT( a(5) =  "String5" )
      CU_ASSERT( a(6) =  "string6" )
      CU_ASSERT( a(7) =  "string7" )
      CU_ASSERT( a(8) =  "string8" )
      CU_ASSERT( a(9) =  "string9" )
      CU_ASSERT( a(10) = "string10" )
      CU_ASSERT( a(11) = "string11" )

    END_TEST


    TEST( sort_ascending_3 )

      DIM a(1 to 11) AS ustring
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, ascend, 1, 5, 6)                  'sort dimenson 1, from 5, for 6 elements
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  "String1" )
      CU_ASSERT( a(2) =  "String2" )
      CU_ASSERT( a(3) =  "String3" )
      CU_ASSERT( a(4) =  "String4" )
      CU_ASSERT( a(5) =  "String5" )
      CU_ASSERT( a(6) =  "string10" )
      CU_ASSERT( a(7) =  "string6" )
      CU_ASSERT( a(8) =  "string7" )
      CU_ASSERT( a(9) =  "string8" )
      CU_ASSERT( a(10) = "string9" )
      CU_ASSERT( a(11) = "string11" )

    END_TEST


    TEST( sort_ascending_4 )

      DIM a(1 to 11) AS ustring
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, ascend, all())
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  "String1" )
      CU_ASSERT( a(2) =  "String2" )
      CU_ASSERT( a(3) =  "String3" )
      CU_ASSERT( a(4) =  "String4" )
      CU_ASSERT( a(5) =  "String5" )
      CU_ASSERT( a(6) =  "string10" )
      CU_ASSERT( a(7) =  "string11" )
      CU_ASSERT( a(8) =  "string6" )
      CU_ASSERT( a(9) =  "string7" )
      CU_ASSERT( a(10) = "string8" )
      CU_ASSERT( a(11) = "string9" )

    END_TEST


    TEST( sort_ascending_5 )

      DIM a(1 to 11) AS ustring
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, ascend, all(1))                   'sort entire 1. dimension
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) =  "String1" )
      CU_ASSERT( a(2) =  "String2" )
      CU_ASSERT( a(3) =  "String3" )
      CU_ASSERT( a(4) =  "String4" )
      CU_ASSERT( a(5) =  "String5" )
      CU_ASSERT( a(6) =  "string10" )
      CU_ASSERT( a(7) =  "string11" )
      CU_ASSERT( a(8) =  "string6" )
      CU_ASSERT( a(9) =  "string7" )
      CU_ASSERT( a(10) = "string8" )
      CU_ASSERT( a(11) = "string9" )

    END_TEST


    TEST( sort_ascending_6 )

      DIM a(1 to 5, 1 to 6) AS ustring
      a(1,1) =  "String1"
      a(1,2) =  "String2"
      a(1,3) =  "String3"
      a(1,4) =  "String4"
      a(1,5) =  "String5"
      a(2,1) =  "string6"
      a(2,2) =  "string7"
      a(2,3) =  "string8"
      a(2,4) =  "string9"
      a(2,5) = "string10"
      a(2,6) = "string11"

      array_sort(a, ascend, all(2))                   'sort entire 2. dimension
      CU_ASSERT( ubound(a) = 5 )
      CU_ASSERT( ubound(a, 2) = 6 )
      CU_ASSERT( a(1,1) = "String1" )
      CU_ASSERT( a(1,2) = "String2" )
      CU_ASSERT( a(1,3) = "String3" )
      CU_ASSERT( a(1,4) = "String4" )
      CU_ASSERT( a(1,5) = "String5" )
      CU_ASSERT( a(2,1) = "string10" )
      CU_ASSERT( a(2,2) = "string11" )
      CU_ASSERT( a(2,3) = "string6" )
      CU_ASSERT( a(2,4) = "string7" )
      CU_ASSERT( a(2,5) = "string8" )
      CU_ASSERT( a(2,6) = "string9" )

    END_TEST


    TEST( sort_ascending_7 )

      DIM a(1 to 5, 1 to 6) AS ustring
      a(1,1) =  "String1"
      a(1,2) =  "String2"
      a(1,3) =  "String3"
      a(1,4) =  "String4"
      a(1,5) =  "String5"
      a(2,1) =  "string6"
      a(2,2) =  "string7"
      a(2,3) =  "string8"
      a(2,4) =  "string9"
      a(2,5) = "string10"
      a(2,6) = "string11"

      array_sort(a, ascend, 2, 3, 4)                  'sort 2. dimension, from 3 for 4 elements
      CU_ASSERT( ubound(a) = 5 )
      CU_ASSERT( ubound(a, 2) = 6 )
      CU_ASSERT( a(1,1) = "String1" )
      CU_ASSERT( a(1,2) = "String2" )
      CU_ASSERT( a(1,3) = "String3" )
      CU_ASSERT( a(1,4) = "String4" )
      CU_ASSERT( a(1,5) = "String5" )
      CU_ASSERT( a(2,1) = "string6" )
      CU_ASSERT( a(2,2) = "string7" )
      CU_ASSERT( a(2,3) = "string10" )
      CU_ASSERT( a(2,4) = "string11" )
      CU_ASSERT( a(2,5) = "string8" )
      CU_ASSERT( a(2,6) = "string9" )

    END_TEST


    TEST( sort_ascending_8 )

      DIM a(1 to 5, 1 to 6) AS ustring
      a(1,1) =  "String1"
      a(1,2) =  "String2"
      a(1,3) =  "String3"
      a(1,4) =  "String4"
      a(1,5) =  "String5"
'      a(1,6) =  ""                                    'implicit gap !
      a(2,1) =  "string6"
      a(2,2) =  "string7"
      a(2,3) =  "string8"
      a(2,4) =  "string9"
      a(2,5) = "string10"
      a(2,6) = "string11"

      array_sort(a, ascend, all())                    'sort entire array
      CU_ASSERT( ubound(a) = 5 )
      CU_ASSERT( ubound(a, 2) = 6 )
      CU_ASSERT( a(1,1) = "" )                        'this is the "gap" from implicit a(1,6)
      CU_ASSERT( a(1,2) = "String1" )
      CU_ASSERT( a(1,3) = "String2" )
      CU_ASSERT( a(1,4) = "String3" )
      CU_ASSERT( a(1,5) = "String4" )
      CU_ASSERT( a(2,1) = "string10" )
      CU_ASSERT( a(2,2) = "string11" )
      CU_ASSERT( a(2,3) = "string6" )
      CU_ASSERT( a(2,4) = "string7" )
      CU_ASSERT( a(2,5) = "string8" )
      CU_ASSERT( a(2,6) = "string9" )

    END_TEST


    TEST( sort_custom )

      DIM a(1 to 11) AS ustring
      a(1) =  "String1"
      a(2) =  "String2"
      a(3) =  "String3"
      a(4) =  "String4"
      a(5) =  "String5"
      a(6) =  "string6"
      a(7) =  "string7"
      a(8) =  "string8"
      a(9) =  "string9"
      a(10) = "string10"
      a(11) = "string11"

      array_sort(a, @CustomSortProc_SUstring, all(1))
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) = "String1" )
      CU_ASSERT( a(2) = "string10" )
      CU_ASSERT( a(3) = "string11" )
      CU_ASSERT( a(4) = "String2" )
      CU_ASSERT( a(5) = "String3" )
      CU_ASSERT( a(6) = "String4" )
      CU_ASSERT( a(7) = "String5" )
      CU_ASSERT( a(8) = "string6" )
      CU_ASSERT( a(9) = "string7" )
      CU_ASSERT( a(10) = "string8" )
      CU_ASSERT( a(11) = "string9" )

    END_TEST


END_SUITE
