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


SUITE( fbc_tests.ustring_.wstring_ )
dim i as long
dim n as long
dim r as long


    TEST( rtl_WSTRING )

      dim w as wstring * 50 = wstring( 10, 1234 )
      dim u as ustring = wstring( 10, 1234 )
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( WSTRING )
      else
        CU_PASS( WSTRING )
      end if

    END_TEST


END_SUITE
