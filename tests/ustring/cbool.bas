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


SUITE( fbc_tests.ustring_.cbool_ )
dim i as long
dim n as long
dim r as long


    TEST( convert_to_CBOOL )

      dim w as wstring * 50 = wstr(1)
      dim u as ustring = wstr(1)

      if cbool(w) <> cbool(u) then
        CU_FAIL( CBOOL )
      else
        CU_PASS( CBOOL )
      end if

    END_TEST


END_SUITE
