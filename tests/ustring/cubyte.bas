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


SUITE( fbc_tests.ustring_.cubyte_ )
dim i as long
dim n as long
dim r as long


    TEST( convert_to_CUBYTE )

      dim w as wstring * 50 = wstr(17)
      dim u as ustring = wstr(17)

      if CUBYTE(w) <> CUBYTE(u) then
        CU_FAIL( CUBYTE )
      else
        CU_PASS( CUBYTE )
      end if

    END_TEST


END_SUITE
