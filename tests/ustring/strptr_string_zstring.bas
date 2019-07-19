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


SUITE( fbc_tests.ustring_.strptr_string_zstring_ )
dim i as long
dim n as long
dim r as long


    TEST( rtl_STRPTR__STRING_ZSTRING__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim z as zstring * 50 = y
      dim s as string = y
      dim z1 as zstring * 50
      dim s1 as string 
      dim p1 as zstring ptr
      dim p2 as zstring ptr

      p1 = strptr(z)
      p2 = strptr(s)

      z1 = *p1
      s1 = *p2

      hCheckString(s1, z1)

      if r = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( rtl_STRPTR__STRING_ZSTRING__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim z as zstring * 50 = y
      dim s as string = y
      dim z1 as zstring * 50
      dim s1 as string 
      dim p1 as zstring ptr
      dim p2 as zstring ptr

      p1 = strptr(z)
      p2 = strptr(s)

      z1 = *p1
      s1 = *p2

      hCheckString(s1, z1)

      if r = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( rtl_STRPTR__STRING_ZSTRING__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim z as zstring * 50 = y
      dim s as string = y
      dim z1 as zstring * 50
      dim s1 as string 
      dim p1 as zstring ptr
      dim p2 as zstring ptr

      p1 = strptr(z)
      p2 = strptr(s)

      z1 = *p1
      s1 = *p2

      hCheckString(s1, z1)

      if r = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( rtl_STRPTR__STRING_ZSTRING__russian )

      dim y as wstring * 50 = "фывапр"
      dim z as zstring * 50 = y
      dim s as string = y
      dim z1 as zstring * 50
      dim s1 as string 
      dim p1 as zstring ptr
      dim p2 as zstring ptr

      p1 = strptr(z)
      p2 = strptr(s)

      z1 = *p1
      s1 = *p2

      hCheckString(s1, z1)

      if r = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( rtl_STRPTR__STRING_ZSTRING__numbers )

      dim y as wstring * 50 = "1234567890"
      dim z as zstring * 50 = y
      dim s as string = y
      dim z1 as zstring * 50
      dim s1 as string 
      dim p1 as zstring ptr
      dim p2 as zstring ptr

      p1 = strptr(z)
      p2 = strptr(s)

      z1 = *p1
      s1 = *p2

      hCheckString(s1, z1)

      if r = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST


END_SUITE
