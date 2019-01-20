#include "fbcunit.bi"
#include "ustring.bi"
#include "functions.bi"

SUITE( fbc_tests.ustring_.parameter )

    TEST( Parameter_passing__byref__byref__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_1(u, w)
      if u1 <> u + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_1(u, w)
      if u1 <> u + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_1(u, w)
      if u1 <> u + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_1(u, w)
      if u1 <> u + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_1(u, w)
      if u1 <> u + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref_const__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_2(u, w)
      if u1 <> u + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref_const__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_2(u, w)
      if u1 <> u + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref_const__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_2(u, w)
      if u1 <> u + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref_const__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_2(u, w)
      if u1 <> u + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_passing__byref__byref_const__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_2(u, w)
      if u1 <> u + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_3(u, w)
      if u1 <> u + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_3(u, w)
      if u1 <> u + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_3(u, w)
      if u1 <> u + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_3(u, w)
      if u1 <> u + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_3(u, w)
      if u1 <> u + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref_const__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_4(u, w)
      if u1 <> u + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref_const__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_4(u, w)
      if u1 <> u + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref_const__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_4(u, w)
      if u1 <> u + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref_const__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_4(u, w)
      if u1 <> u + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_passing__byval__byref_const__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = paramtest_4(u, w)
      if u1 <> u + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Parameter_Conversion_ZSTRING_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(z, s) = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_Conversion_ZSTRING_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(z, s) = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_Conversion_ZSTRING_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(z, s) = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_Conversion_ZSTRING_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(z, s) = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_Conversion_ZSTRING_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(z, s) = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Parameter_Conversion_STRING_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(s, s) = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_Conversion_STRING_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(s, s) = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_Conversion_STRING_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(s, s) = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_Conversion_STRING_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(s, s) = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_Conversion_STRING_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(s, s) = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Parameter_Conversion_WSTRING_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(w, w) = 1 then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Parameter_Conversion_WSTRING_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(w, w) = 1 then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Parameter_Conversion_WSTRING_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(w, w) = 1 then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Parameter_Conversion_WSTRING_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(w, w) = 1 then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Parameter_Conversion_WSTRING_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      if conversiontest_1(w, w) = 1 then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s)
      if u1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s)
      if u1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s)
      if u1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s)
      if u1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s)
      if u1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in__Const___Return_Conversion_USTRING_receives_a_STRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_2(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s)
      if u1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s)
      if u1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s)
      if u1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s)
      if u1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s)
      if u1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in_Byval____Return_Conversion_USTRING_receives_a_STRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_3(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s)
      if u1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s)
      if u1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s)
      if u1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s)
      if u1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s)
      if u1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_STRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_4(u, s, 1)
      if u1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w)
      if u1 <> w + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w)
      if u1 <> w + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w)
      if u1 <> w + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w)
      if u1 <> w + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w)
      if u1 <> w + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( in_Byref____Return_Conversion_USTRING_receives_a_WSTRING_PTR__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_5(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s)
      if z <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s)
      if z <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s)
      if z <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s)
      if z <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s)
      if z <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s, 1)
      if z <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s, 1)
      if z <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s, 1)
      if z <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s, 1)
      if z <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_ZSTRING_receives_a_USTRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      z = conversiontest_6(u, s, 1)
      if z <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s)
      if s1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s)
      if s1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s)
      if s1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s)
      if s1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s)
      if s1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s, 1)
      if s1 <> s + s then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s, 1)
      if s1 <> s + s then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s, 1)
      if s1 <> s + s then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s, 1)
      if s1 <> s + s then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_STRING_receives_a_USTRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      s1 = conversiontest_6(u, s, 1)
      if s1 <> s + s then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w)
      if w1 <> w + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w)
      if w1 <> w + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w)
      if w1 <> w + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w)
      if w1 <> w + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w)
      if w1 <> w + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w, 1)
      if w1 <> w + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w, 1)
      if w1 <> w + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w, 1)
      if w1 <> w + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w, 1)
      if w1 <> w + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_WSTRING_receives_a_USTRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      w1 = conversiontest_7(u, w, 1)
      if w1 <> w + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING_lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w)
      if u1 <> w + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING_ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w)
      if u1 <> w + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING_wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w)
      if u1 <> w + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING_russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w)
      if u1 <> w + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING_numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w)
      if u1 <> w + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING__ampersand__lcase )

      dim y as wstring * 50 = "asdfghjkl"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( lcase )
      else
        CU_PASS( lcase )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING__ampersand__ucase )

      dim y as wstring * 50 = "QWERTZUIOP"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( ucase )
      else
        CU_PASS( ucase )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING__ampersand__wide )

      dim y as wstring * 50 = !"asd wstring fghjkl\u4644"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( wide string )
      else
        CU_PASS( wide string )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING__ampersand__russian )

      dim y as wstring * 50 = "фывапр"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( russian string )
      else
        CU_PASS( russian string )
      end if

    END_TEST

    TEST( Return_Conversion_USTRING_receives_a_USTRING__ampersand__numbers )

      dim y as wstring * 50 = "1234567890"
      dim s  as string = y 
      dim s1 as string 
      dim z  as Zstring * 64 = y 
      dim w  as Wstring * 64 = y 
      dim w1 as Wstring * 64 
      dim u  as ustring = y 
      dim u1 as ustring 
      u1 = conversiontest_7(u, w, 1)
      if u1 <> w + w then
        CU_FAIL( numbers )
      else
        CU_PASS( numbers )
      end if

    END_TEST


END_SUITE
