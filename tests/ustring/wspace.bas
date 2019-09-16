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


SUITE( fbc_tests.ustring_.wspace_ )
dim i as long
dim n as long
dim r as long


    TEST( rtl_WSPACE )

      dim w as wstring * 50 = wspace( 10 )
      dim u as ustring = wspace( 10 )
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( WSPACE )
      else
        CU_PASS( WSPACE )
      end if

    END_TEST


END_SUITE