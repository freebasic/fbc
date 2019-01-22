#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_repeat_(y, cc, uflag)
scope
dim i as long
dim n as long
dim st as string
dim z  as zstring * 260 = y
dim s  as string        = y
dim w  as Wstring * 260 = y
dim u  as Ustring       = y
dim z1 as zstring * 260 
dim s1 as string        
dim w1 as Wstring * 260  
dim u1 as Ustring      


    if uflag then goto do_wide_only


      if repeat_(0, z) <> "" then
        CU_FAIL(  Repeat zstring nothing )
      else
        CU_PASS(  Repeat zstring nothing )
      end if


      if repeat_(3, z) <> z + z + z then
        CU_FAIL(  Repeat zstring )
      else
        CU_PASS(  Repeat zstring )
      end if


      if repeat_(0, s) <> "" then
        CU_FAIL(  Repeat string nothing )
      else
        CU_PASS(  Repeat string nothing )
      end if


      if repeat_(3, s) <> s + s + s then
        CU_FAIL(  Repeat string )
      else
        CU_PASS(  Repeat string )
      end if


do_wide_only:


      if repeat_(0, w) <> "" then
        CU_FAIL(  Repeat wstring nothing )
      else
        CU_PASS(  Repeat wstring nothing )
      end if


      if repeat_(3, w) <> w + w + w then
        CU_FAIL(  Repeat wstring )
      else
        CU_PASS(  Repeat wstring )
      end if


      if repeat_(0, u) <> "" then
        CU_FAIL(  Repeat ustring nothing )
      else
        CU_PASS(  Repeat ustring nothing )
      end if


      if repeat_(3, u) <> u + u + u then
        CU_FAIL(  Repeat ustring )
      else
        CU_PASS(  Repeat ustring )
      end if


end scope
#endmacro


SUITE( fbc_tests.ustring_.string_repeat_ )
dim y  as wstring * 128


  TEST ( repeat_1 )
    y = "1234567890 + abcdefghij"
    test_repeat_(y, 1, 0)
  END_TEST

  TEST ( repeat_2 )
    y = "1234567890 + abcdefghij"
    test_repeat_(y+y, 2, 0)
  END_TEST

  TEST ( repeat_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_repeat_(y, 1, 0)
  END_TEST

  TEST ( repeat_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_repeat_(y+y, 2, 0)
  END_TEST

  TEST ( repeat_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_repeat_(y, 1, 1)
  END_TEST

  TEST ( repeat_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_repeat_(y+y, 2, 1)
  END_TEST


END_SUITE
