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


SUITE( fbc_tests.ustring_.iif_ )
dim i as long
dim n as long
dim r as long


    TEST( rtl_IIF__WSTRING_USTRING__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim w as wstring * 50 = y
      dim u as ustring = y
      dim w1 as wstring * 50
      dim u1 as ustring 
      dim p1 as wstring ptr
      dim p2 as wstring ptr

      u1 = iif(n<>0, u, wstr(""))
      u1 = iif(n<>0, u1, w)
      u1 = iif(n=0, w, u1)
      u1 = u + iif(n<>0, u1, u)

      w1 = iif(n<>0, u, wstr(""))
      w1 = iif(n<>0, u1, w)
      w1 = iif(n=0, w, u1)
      w1 = u + iif(n=0, w1, u)

      hCheckString(u1, w1)

      if r = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( rtl_IIF__WSTRING_USTRING__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim w as wstring * 50 = y
      dim u as ustring = y
      dim w1 as wstring * 50
      dim u1 as ustring 
      dim p1 as wstring ptr
      dim p2 as wstring ptr

      u1 = iif(n<>0, u, wstr(""))
      u1 = iif(n<>0, u1, w)
      u1 = iif(n=0, w, u1)
      u1 = u + iif(n<>0, u1, u)

      w1 = iif(n<>0, u, wstr(""))
      w1 = iif(n<>0, u1, w)
      w1 = iif(n=0, w, u1)
      w1 = u + iif(n=0, w1, u)

      hCheckString(u1, w1)

      if r = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( rtl_IIF__WSTRING_USTRING__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim w as wstring * 50 = y
      dim u as ustring = y
      dim w1 as wstring * 50
      dim u1 as ustring 
      dim p1 as wstring ptr
      dim p2 as wstring ptr

      u1 = iif(n<>0, u, wstr(""))
      u1 = iif(n<>0, u1, w)
      u1 = iif(n=0, w, u1)
      u1 = u + iif(n<>0, u1, u)

      w1 = iif(n<>0, u, wstr(""))
      w1 = iif(n<>0, u1, w)
      w1 = iif(n=0, w, u1)
      w1 = u + iif(n=0, w1, u)

      hCheckString(u1, w1)

      if r = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( rtl_IIF__WSTRING_USTRING__russian )

      dim y as wstring * 50 = "фывапр"
      dim w as wstring * 50 = y
      dim u as ustring = y
      dim w1 as wstring * 50
      dim u1 as ustring 
      dim p1 as wstring ptr
      dim p2 as wstring ptr

      u1 = iif(n<>0, u, wstr(""))
      u1 = iif(n<>0, u1, w)
      u1 = iif(n=0, w, u1)
      u1 = u + iif(n<>0, u1, u)

      w1 = iif(n<>0, u, wstr(""))
      w1 = iif(n<>0, u1, w)
      w1 = iif(n=0, w, u1)
      w1 = u + iif(n=0, w1, u)

      hCheckString(u1, w1)

      if r = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( rtl_IIF__WSTRING_USTRING__numbers )

      dim y as wstring * 50 = "1234567890"
      dim w as wstring * 50 = y
      dim u as ustring = y
      dim w1 as wstring * 50
      dim u1 as ustring 
      dim p1 as wstring ptr
      dim p2 as wstring ptr

      u1 = iif(n<>0, u, wstr(""))
      u1 = iif(n<>0, u1, w)
      u1 = iif(n=0, w, u1)
      u1 = u + iif(n<>0, u1, u)

      w1 = iif(n<>0, u, wstr(""))
      w1 = iif(n<>0, u1, w)
      w1 = iif(n=0, w, u1)
      w1 = u + iif(n=0, w1, u)

      hCheckString(u1, w1)

      if r = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST


END_SUITE
