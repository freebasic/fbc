#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_parsecount(y, cc, uflag)
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


      if parsecount(z, ",") <> 1 then
        CU_FAIL(  parsecount zstring nothing )
      else
        CU_PASS(  parsecount zstring nothing )
      end if


      if parsecount(z, z) <> 2 then
        CU_FAIL(  parsecount zstring all )
      else
        CU_PASS(  parsecount zstring all )
      end if


      if parsecount(z, any z) <> len(z) + 1 then
        CU_FAIL(  parsecount zstring all any )
      else
        CU_PASS(  parsecount zstring all any )
      end if


      if parsecount(z, left(z, 2)) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount zstring )
      else
        CU_PASS(  Parsecount zstring )
      end if


      if parsecount(z, right(z, 2), 1) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount zstring caseinsensitive )
      else
        CU_PASS(  Parsecount zstring caseinsensitive )
      end if


      if parsecount(z, any mid(z, 2, 3)) <> 3 * cc + 1 then
        CU_FAIL(  Parsecount zstring any )
      else
        CU_PASS(  Parsecount zstring any )
      end if


      if parsecount(z, any mid(z, 2, 3)) <> 3 * cc + 1 then      'future extension "any"
        CU_FAIL(  Parsecount zstring any new )
      else
        CU_PASS(  Parsecount zstring any new )
      end if


      if parsecount(z, any mid(z, 3, 4), 1) <> 4 * cc + 1 then
        CU_FAIL(  Parsecount zstring any caseinsensitive )
      else
        CU_PASS(  Parsecount zstring any caseinsensitive )
      end if


      if parsecount(s, ",") <> 1 then
        CU_FAIL(  parsecount string nothing )
      else
        CU_PASS(  parsecount string nothing )
      end if


      if parsecount(s, s) <> 2 then
        CU_FAIL(  parsecount string all )
      else
        CU_PASS(  parsecount string all )
      end if


      if parsecount(s, any s) <> len(s) + 1 then
        CU_FAIL(  parsecount string all any )
      else
        CU_PASS(  parsecount string all any )
      end if


      if parsecount(s, left(s, 2)) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount string )
      else
        CU_PASS(  Parsecount string )
      end if


      if parsecount(s, right(s, 2), 1) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount string caseinsensitive )
      else
        CU_PASS(  Parsecount string caseinsensitive )
      end if


      if parsecount(s, any mid(s, 2, 3)) <> 3 * cc + 1 then
        CU_FAIL(  Parsecount string any )
      else
        CU_PASS(  Parsecount string any )
      end if


      if parsecount(s, any mid(s, 2, 3)) <> 3 * cc + 1 then      'future extension "any"
        CU_FAIL(  Parsecount string any new )
      else
        CU_PASS(  Parsecount string any new )
      end if


      if parsecount(s, any mid(s, 3, 4), 1) <> 4 * cc + 1 then
        CU_FAIL(  Parsecount string any caseinsensitive )
      else
        CU_PASS(  Parsecount string any caseinsensitive )
      end if


do_wide_only:


      if parsecount(w, ",") <> 1 then
        CU_FAIL(  parsecount wstring nothing )
      else
        CU_PASS(  parsecount wstring nothing )
      end if


      if parsecount(w, w) <> 2 then
        CU_FAIL(  parsecount wstring all )
      else
        CU_PASS(  parsecount wstring all )
      end if


      if parsecount(w, any w) <> len(w) + 1 then
        CU_FAIL(  parsecount wstring all any )
      else
        CU_PASS(  parsecount wstring all any )
      end if


      if parsecount(w, left(w, 2)) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount wstring )
      else
        CU_PASS(  Parsecount wstring )
      end if


      if parsecount(w, right(w, 2), 1) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount wstring caseinsensitive )
      else
        CU_PASS(  Parsecount wstring caseinsensitive )
      end if


      if parsecount(w, any mid(w, 2, 3)) <> 3 * cc + 1 then
        CU_FAIL(  Parsecount wstring any )
      else
        CU_PASS(  Parsecount wstring any )
      end if


      if parsecount(w, any mid(w, 2, 3)) <> 3 * cc + 1 then      'future extension "any"
        CU_FAIL(  Parsecount wstring any new )
      else
        CU_PASS(  Parsecount wstring any new )
      end if


      if parsecount(w, any mid(w, 3, 4), 1) <> 4 * cc + 1 then
        CU_FAIL(  Parsecount wstring any caseinsensitive )
      else
        CU_PASS(  Parsecount wstring any caseinsensitive )
      end if


      if parsecount(u, ",") <> 1 then
        CU_FAIL(  parsecount ustring nothing )
      else
        CU_PASS(  parsecount ustring nothing )
      end if


      if parsecount(u, u) <> 2 then
        CU_FAIL(  parsecount ustring all )
      else
        CU_PASS(  parsecount ustring all )
      end if


      if parsecount(u, any u) <> len(u) + 1 then
        CU_FAIL(  parsecount ustring all any )
      else
        CU_PASS(  parsecount ustring all any )
      end if


      if parsecount(u, left(u, 2)) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount ustring )
      else
        CU_PASS(  Parsecount ustring )
      end if


      if parsecount(u, right(u, 2), 1) <> 1 * cc + 1 then
        CU_FAIL(  Parsecount ustring caseinsensitive )
      else
        CU_PASS(  Parsecount ustring caseinsensitive )
      end if


      if parsecount(u, any mid(u, 2, 3)) <> 3 * cc + 1 then
        CU_FAIL(  Parsecount ustring any )
      else
        CU_PASS(  Parsecount ustring any )
      end if


      if parsecount(u, any mid(u, 2, 3)) <> 3 * cc + 1 then      'future extension "any"
        CU_FAIL(  Parsecount ustring any new )
      else
        CU_PASS(  Parsecount ustring any new )
      end if


      if parsecount(u, any mid(u, 3, 4), 1) <> 4 * cc + 1 then
        CU_FAIL(  Parsecount ustring any caseinsensitive )
      else
        CU_PASS(  Parsecount ustring any caseinsensitive )
      end if


end scope
#endmacro


SUITE( fbc_tests.ustring_.string_parsecount )
dim y  as wstring * 128


  TEST ( parsecount_1 )
    y = "1234567890 + abcdefghij"
    test_parsecount(y, 1, 0)
  END_TEST

  TEST ( parsecount_2 )
    y = "1234567890 + abcdefghij"
    test_parsecount(y+y, 2, 0)
  END_TEST

  TEST ( parsecount_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_parsecount(y, 1, 0)
  END_TEST

  TEST ( parsecount_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_parsecount(y+y, 2, 0)
  END_TEST

  TEST ( parsecount_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_parsecount(y, 1, 1)
  END_TEST

  TEST ( parsecount_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_parsecount(y+y, 2, 1)
  END_TEST


END_SUITE
