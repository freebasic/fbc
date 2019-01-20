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


SUITE( fbc_tests.ustring_.concatenation_4 )
dim i as long
dim r as long
dim x as long
dim z as long


    TEST( as_const_WSTRING )

      dim w as wstring * 50 = !"wstring\u4644"
      dim u as ustring = !"wstring\u4644"
      w &= !"wstring\u4644"
      u &= !"wstring\u4644"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as const WSTRING (&= operator) )
      else
        CU_PASS( as const WSTRING (&= operator) )
      end if

    END_TEST

    TEST( as_WSTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = y
      dim u as ustring = w
      u &= w
      w &= w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( lcase (&= operator) )
      else
        CU_PASS( lcase (&= operator) )
      end if

    END_TEST

    TEST( as_WSTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = y
      dim u as ustring = w
      u &= w
      w &= w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( ucase (&= operator) )
      else
        CU_PASS( ucase (&= operator) )
      end if

    END_TEST

    TEST( as_WSTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = y
      dim u as ustring = w
      u &= w
      w &= w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( wide string (&= operator) )
      else
        CU_PASS( wide string (&= operator) )
      end if

    END_TEST

    TEST( as_WSTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = y
      dim u as ustring = w
      u &= w
      w &= w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( russian string (&= operator) )
      else
        CU_PASS( russian string (&= operator) )
      end if

    END_TEST

    TEST( as_WSTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = y
      dim u as ustring = w
      u &= w
      w &= w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( numbers (&= operator) )
      else
        CU_PASS( numbers (&= operator) )
      end if

    END_TEST

    TEST( as_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      w &= u1
      u &= u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( lcase (&= operator) )
      else
        CU_PASS( lcase (&= operator) )
      end if

    END_TEST

    TEST( as_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      w &= u1
      u &= u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( ucase (&= operator) )
      else
        CU_PASS( ucase (&= operator) )
      end if

    END_TEST

    TEST( as_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      w &= u1
      u &= u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( wide string (&= operator) )
      else
        CU_PASS( wide string (&= operator) )
      end if

    END_TEST

    TEST( as_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      w &= u1
      u &= u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( russian string (&= operator) )
      else
        CU_PASS( russian string (&= operator) )
      end if

    END_TEST

    TEST( as_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      w &= u1
      u &= u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( numbers (&= operator) )
      else
        CU_PASS( numbers (&= operator) )
      end if

    END_TEST

    TEST( as_STRING )

      dim s as string = "ansi string"
      dim w as wstring * 50 = s
      dim u as ustring = s
      w &= s
      u &= s
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as STRING (&= operator) )
      else
        CU_PASS( as STRING (&= operator) )
      end if

    END_TEST

    TEST( as_ZSTRING )

      dim z as Zstring * 50 = "z string"
      dim w as wstring * 50 = z
      dim u as ustring = z
      w &= z
      u &= z
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as ZSTRING (&= operator) )
      else
        CU_PASS( as ZSTRING (&= operator) )
      end if

    END_TEST

    TEST( as_LONGINT )

      dim w as wstring * 50 = Wstr(123)
      dim u as ustring = 123
      w &= 123
      u &= 123
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as LONGINT (&= operator) )
      else
        CU_PASS( as LONGINT (&= operator) )
      end if

    END_TEST

    TEST( as_DOUBLE )

      dim w as wstring * 50 = Wstr(3.14)
      dim u as ustring = 3.14
      w &= 3.14
      u &= 3.14
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as DOUBLE (&= operator) )
      else
        CU_PASS( as DOUBLE (&= operator) )
      end if

    END_TEST


END_SUITE
