#include "fbcunit.bi"
#include "ustring.bi"
#include "array.bi"


SUITE( fbc_tests.array.del_static )

 

    TEST( delete_11 )

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

      array_delete(a, 11)
      CU_ASSERT( err = 99 )
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(10) = "string10" )
      CU_ASSERT( a(11) = "" )

    END_TEST


    TEST( delete_1 )

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

      array_delete(a, 1)
      CU_ASSERT( err = 99 )
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(1) = "String2" )
      CU_ASSERT( a(11) = "" )

    END_TEST


    TEST( delete_5 )

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

      array_delete(a, 5)
      CU_ASSERT( err = 99 )
      CU_ASSERT( ubound(a) = 11 )
      CU_ASSERT( a(4) = "String4" )
      CU_ASSERT( a(5) = "string6" )
      CU_ASSERT( a(6) = "string7" )
      CU_ASSERT( a(11) = "" )

    END_TEST


END_SUITE
