#include "fbcunit.bi"
#include "ustring.bi"


#macro hCheckString( U, w )
  r = 0                                               'reset flag

  CU_ASSERT_EQUAL(u, w)

    scope

    if(len(u) <> len(w)) then
      r = 1                                           'signal error

    else
      for i as integer = 0 to len(u) - 1
        if(u[i] <> w[i]) then
          r = 1                                       'signal error
          exit for
        end if
      next
    end if
  end scope
#endmacro


SUITE( fbc_tests.ustring_.swap_ )
dim r as long


    TEST( rtl_SWAP )

      dim w  as wstring * 50 = "12345"
      dim w1  as wstring * 50 = "12345"
      dim u  as ustring = "asdfg"
      dim u1 as ustring = "asdfg"

      swap u, w

      hCheckString(u, w1)

      if r = 1 then
        CU_FAIL( SWAP )
      else
        CU_PASS( SWAP )
      end if

      hCheckString(w, u1)

      if r = 1 then
        CU_FAIL( SWAP_2 )
      else
        CU_PASS( SWAP_2 )
      end if


      swap u, u1
      hCheckString(u1, w1)

      if r = 1 then
        CU_FAIL( SWAP_3 )
      else
        CU_PASS( SWAP_3 )
      end if


    END_TEST


END_SUITE
