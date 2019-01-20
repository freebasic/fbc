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


SUITE( fbc_tests.ustring_.vallng_ )
dim i as long
dim n as long
dim r as long


    TEST( convert_value_vallng )

      dim w as wstring * 50 = wstr(12345678900)
      dim u as ustring = wstr(12345678900)

      if vallng(w) <> vallng(u) then
        CU_FAIL( vallng )
      else
        CU_PASS( vallng )
      end if

    END_TEST


END_SUITE
