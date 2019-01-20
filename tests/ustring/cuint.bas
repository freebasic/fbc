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


SUITE( fbc_tests.ustring_.cuint_ )
dim i as long
dim n as long
dim r as long


    TEST( convert_to_CUINT )

      dim w as wstring * 50 = wstr(70001)
      dim u as ustring = wstr(70001)

      if CUINT(w) <> CUINT(u) then
        CU_FAIL( CUINT )
      else
        CU_PASS( CUINT )
      end if

    END_TEST


END_SUITE
