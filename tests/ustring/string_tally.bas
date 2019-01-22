#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_tally(y, cc, uflag)
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


      if tally(z, ",") <> 0 then
        CU_FAIL(  Tally zstring nothing )
      else
        CU_PASS(  Tally zstring nothing )
      end if


      if tally(z, z) <> 1 then
        CU_FAIL(  Tally zstring all )
      else
        CU_PASS(  Tally zstring all )
      end if


      if tally(z, any z) <> len(z) then
        CU_FAIL(  Tally zstring all any )
      else
        CU_PASS(  Tally zstring all any )
      end if


      if tally(z, left(z, 2)) <> 1 * cc then
        CU_FAIL(  Tally zstring )
      else
        CU_PASS(  Tally zstring )
      end if


      if tally(z, right(z, 2), 1) <> 1 * cc then
        CU_FAIL(  Tally zstring caseinsensitive )
      else
        CU_PASS(  Tally zstring caseinsensitive )
      end if


      if tally(z, any mid(z, 2, 3)) <> 3 * cc then
        CU_FAIL(  Tally zstring any )
      else
        CU_PASS(  Tally zstring any )
      end if


      if tally(z, any mid(z, 2, 3)) <> 3 * cc then    
        CU_FAIL(  Tally zstring any new )
      else
        CU_PASS(  Tally zstring any new )
      end if


      if tally(z, any mid(z, 3, 4), 1) <> 4 * cc then
        CU_FAIL(  Tally zstring any caseinsensitive )
      else
        CU_PASS(  Tally zstring any caseinsensitive )
      end if


      if tally(s, ",") <> 0 then
        CU_FAIL(  Tally string nothing )
      else
        CU_PASS(  Tally string nothing )
      end if


      if tally(s, s) <> 1 then
        CU_FAIL(  Tally string all )
      else
        CU_PASS(  Tally string all )
      end if


      if tally(s, any s) <> len(s) then
        CU_FAIL(  Tally string all any )
      else
        CU_PASS(  Tally string all any )
      end if


      if tally(s, left(s, 2)) <> 1 * cc then
        CU_FAIL(  Tally string )
      else
        CU_PASS(  Tally string )
      end if


      if tally(s, right(s, 2), 1) <> 1 * cc then
        CU_FAIL(  Tally string caseinsensitive )
      else
        CU_PASS(  Tally string caseinsensitive )
      end if


      if tally(s, any mid(s, 2, 3)) <> 3 * cc then
        CU_FAIL(  Tally string any )
      else
        CU_PASS(  Tally string any )
      end if


      if tally(s, any mid(s, 2, 3)) <> 3 * cc then    
        CU_FAIL(  Tally string any new )
      else
        CU_PASS(  Tally string any new )
      end if


      if tally(s, any mid(s, 3, 4), 1) <> 4 * cc then
        CU_FAIL(  Tally string any caseinsensitive )
      else
        CU_PASS(  Tally string any caseinsensitive )
      end if


do_wide_only:


      if tally(w, ",") <> 0 then
        CU_FAIL(  Tally wstring nothing )
      else
        CU_PASS(  Tally wstring nothing )
      end if


      if tally(w, w) <> 1 then
        CU_FAIL(  Tally wstring all )
      else
        CU_PASS(  Tally wstring all )
      end if


      if tally(w, any w) <> len(w) then
        CU_FAIL(  Tally wstring all any )
      else
        CU_PASS(  Tally wstring all any )
      end if


      if tally(w, left(w, 2)) <> 1 * cc then
        CU_FAIL(  Tally wstring )
      else
        CU_PASS(  Tally wstring )
      end if


      if tally(w, right(w, 2), 1) <> 1 * cc then
        CU_FAIL(  Tally wstring caseinsensitive )
      else
        CU_PASS(  Tally wstring caseinsensitive )
      end if


      if tally(w, any mid(w, 2, 3)) <> 3 * cc then
        CU_FAIL(  Tally wstring any )
      else
        CU_PASS(  Tally wstring any )
      end if


      if tally(w, any mid(w, 2, 3)) <> 3 * cc then    
        CU_FAIL(  Tally wstring any new )
      else
        CU_PASS(  Tally wstring any new )
      end if


      if tally(w, any mid(w, 3, 4), 1) <> 4 * cc then
        CU_FAIL(  Tally wstring any caseinsensitive )
      else
        CU_PASS(  Tally wstring any caseinsensitive )
      end if


      if tally(u, ",") <> 0 then
        CU_FAIL(  Tally ustring nothing )
      else
        CU_PASS(  Tally ustring nothing )
      end if


      if tally(u, u) <> 1 then
        CU_FAIL(  Tally ustring all )
      else
        CU_PASS(  Tally ustring all )
      end if


      if tally(u, any u) <> len(u) then
        CU_FAIL(  Tally ustring all any )
      else
        CU_PASS(  Tally ustring all any )
      end if


      if tally(u, left(u, 2)) <> 1 * cc then
        CU_FAIL(  Tally ustring )
      else
        CU_PASS(  Tally ustring )
      end if


      if tally(u, right(u, 2), 1) <> 1 * cc then
        CU_FAIL(  Tally ustring caseinsensitive )
      else
        CU_PASS(  Tally ustring caseinsensitive )
      end if


      if tally(u, any mid(u, 2, 3)) <> 3 * cc then
        CU_FAIL(  Tally ustring any )
      else
        CU_PASS(  Tally ustring any )
      end if


      if tally(u, any mid(u, 2, 3)) <> 3 * cc then    
        CU_FAIL(  Tally ustring any new )
      else
        CU_PASS(  Tally ustring any new )
      end if


      if tally(u, any mid(u, 3, 4), 1) <> 4 * cc then
        CU_FAIL(  Tally ustring any caseinsensitive )
      else
        CU_PASS(  Tally ustring any caseinsensitive )
      end if


end scope
#endmacro


SUITE( fbc_tests.ustring_.string_tally )
dim y  as wstring * 128


  TEST ( tally_1 )
    y = "1234567890 + abcdefghij"
    test_tally(y, 1, 0)
  END_TEST

  TEST ( tally_2 )
    y = "1234567890 + abcdefghij"
    test_tally(y+y, 2, 0)
  END_TEST

  TEST ( tally_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_tally(y, 1, 0)
  END_TEST

  TEST ( tally_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_tally(y+y, 2, 0)
  END_TEST

  TEST ( tally_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_tally(y, 1, 1)
  END_TEST

  TEST ( tally_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_tally(y+y, 2, 1)
  END_TEST


END_SUITE
