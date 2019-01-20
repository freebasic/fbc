#include "fbcunit.bi"
#include "ustring.bi"
#include "array.bi"


SUITE( fbc_tests.array.ins_string )

 

    TEST( insert_11 )

      DIM a() AS ustring
      redim a(1 to 11)
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

      array_insert(a, 11, "asdf")
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(10) = "string10" )
      CU_ASSERT( a(11) = "asdf" )
      CU_ASSERT( a(12) = "string11" )

    END_TEST


    TEST( insert_12 )

      DIM a() AS ustring
      redim a(1 to 11)
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

      array_insert(a, 12, "asdf")
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(10) = "string10" )
      CU_ASSERT( a(12) = "asdf" )
      CU_ASSERT( a(11) = "string11" )

    END_TEST


    TEST( insert_1 )

      DIM a() AS ustring
      redim a(1 to 11)
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

      array_insert(a, 1, "asdf")
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(1) = "asdf" )
      CU_ASSERT( a(2) = "String1" )

    END_TEST


    TEST( insert_5 )

      DIM a() AS ustring
      redim a(1 to 11)
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

      array_insert(a, 5, "asdf")
      CU_ASSERT( ubound(a) = 12 )
      CU_ASSERT( a(4) = "String4" )
      CU_ASSERT( a(5) = "asdf" )
      CU_ASSERT( a(6) = "String5" )

    END_TEST


END_SUITE
