#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_strreverse_(y, cc, uflag)
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


      if strreverse_(strreverse_(z)) <> z then
        CU_FAIL(  StrReverse zstring )
      else
        CU_PASS(  StrReverse zstring )
      end if


      if strreverse_(strreverse_(s)) <> s then
        CU_FAIL(  StrReverse string )
      else
        CU_PASS(  StrReverse string )
      end if


do_wide_only:


      if strreverse_(strreverse_(w)) <> w then
        CU_FAIL(  StrReverse wstring )
      else
        CU_PASS(  StrReverse wstring )
      end if


      if strreverse_(strreverse_(u)) <> u then
        CU_FAIL(  StrReverse ustring )
      else
        CU_PASS(  StrReverse ustring )
      end if


end scope
#endmacro


SUITE( fbc_tests.ustring_.string_strreverse_ )
dim y  as wstring * 128


  TEST ( strreverse_1 )
    y = "1234567890 + abcdefghij"
    test_strreverse_(y, 1, 0)
  END_TEST

  TEST ( strreverse_2 )
    y = "1234567890 + abcdefghij"
    test_strreverse_(y+y, 2, 0)
  END_TEST

  TEST ( strreverse_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_strreverse_(y, 1, 0)
  END_TEST

  TEST ( strreverse_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_strreverse_(y+y, 2, 0)
  END_TEST

  TEST ( strreverse_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_strreverse_(y, 1, 1)
  END_TEST

  TEST ( strreverse_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_strreverse_(y+y, 2, 1)
  END_TEST


END_SUITE
