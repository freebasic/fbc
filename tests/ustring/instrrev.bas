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


SUITE( fbc_tests.ustring_.instrrev_ )
dim i as long
dim n as long
dim r as long


    TEST( rtl_INSTRREV_look_for_ANY )

      dim w as wstring * 50 = wspace(5) & !"wstring\u4644" & wspace(5)
      dim u as ustring = w
      i = instrrev(w, any "ri")
      n = instrrev(u, any "ri")

      if i <> n then
        CU_FAIL( INSTRREV look for ANY )
      else
        CU_PASS( INSTRREV look for ANY )
      end if

    END_TEST


END_SUITE
