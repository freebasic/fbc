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


SUITE( fbc_tests.ustring_.rtrim_ )
dim i as long
dim n as long
dim r as long


    TEST( rtl_RTRIM_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = wspace(5) & y & wspace(5)
      dim u as ustring = w
      w = "'" & rtrim(w) & "'"
      u = "'" & rtrim(u) & "'"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( rtl_RTRIM_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = wspace(5) & y & wspace(5)
      dim u as ustring = w
      w = "'" & rtrim(w) & "'"
      u = "'" & rtrim(u) & "'"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( rtl_RTRIM_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = wspace(5) & y & wspace(5)
      dim u as ustring = w
      w = "'" & rtrim(w) & "'"
      u = "'" & rtrim(u) & "'"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( rtl_RTRIM_russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = wspace(5) & y & wspace(5)
      dim u as ustring = w
      w = "'" & rtrim(w) & "'"
      u = "'" & rtrim(u) & "'"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( rtl_RTRIM_numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = wspace(5) & y & wspace(5)
      dim u as ustring = w
      w = "'" & rtrim(w) & "'"
      u = "'" & rtrim(u) & "'"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST


END_SUITE
