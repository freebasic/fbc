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


SUITE( fbc_tests.ustring_.initialization )
dim i as long
dim r as long
dim x as long
dim z as long


    TEST( empty_constructor )

      dim u as ustring
      dim w as wstring * 50
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( empty constructor )
      else
        CU_PASS( empty constructor )
      end if

    END_TEST

    TEST( as_const_WSTRING )

      dim w as wstring * 50 = !"wstring\u4644"
      dim u as ustring = !"wstring\u4644"
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as const WSTRING )
      else
        CU_PASS( as const WSTRING )
      end if

    END_TEST

    TEST( as_WSTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = y
      dim u as ustring = w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( as_WSTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = y
      dim u as ustring = w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( as_WSTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = y
      dim u as ustring = w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( as_WSTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = y
      dim u as ustring = w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( as_WSTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = y
      dim u as ustring = w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( as_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( as_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( as_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( as_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( as_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = y
      dim u1 as ustring = w
      dim u as ustring = u1
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( as_STRING )

      dim s as string = "ansi string"
      dim w as wstring * 50 = s
      dim u as ustring = s
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as STRING )
      else
        CU_PASS( as STRING )
      end if

    END_TEST

    TEST( as_ZSTRING )

      dim z as Zstring * 50 = "z string"
      dim w as wstring * 50 = z
      dim u as ustring = z
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( as ZSTRING )
      else
        CU_PASS( as ZSTRING )
      end if

    END_TEST

    TEST( as_const_WSTRING_PTR_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = y
      dim u as ustring = @w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( as_const_WSTRING_PTR_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = y
      dim u as ustring = @w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( as_const_WSTRING_PTR_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = y
      dim u as ustring = @w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( as_const_WSTRING_PTR_russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = y
      dim u as ustring = @w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( as_const_WSTRING_PTR_numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = y
      dim u as ustring = @w
      hCheckString(u, w)

      if r = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST


END_SUITE
