#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_extract_(y, cc, uflag)
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


      if extract_(z, "") <> z then
        CU_FAIL(  Extract zstring nothing )
      else
        CU_PASS(  Extract zstring nothing )
      end if


      if extract_(z, ",") <> z then
        CU_FAIL(  Extract zstring )
      else
        CU_PASS(  Extract zstring )
      end if


      if extract_(z, z) <> "" then
        CU_FAIL(  Extract zstring all )
      else
        CU_PASS(  Extract zstring all )
      end if


      if extract_(z, any z) <> "" then
        CU_FAIL(  Extract zstring all any )
      else
        CU_PASS(  Extract zstring all any )
      end if


      for i = 2 to len(z)
      if extract_(z, Mid(z, i, 1)) <> left(z, instr(z, mid(z, i, 1)) - 1) then
        CU_FAIL(  Extract zstring )
      else
        CU_PASS(  Extract zstring )
      end if
      next i



      for i = 1 to 7
      if extract_(z, right(z, i), 1) <> left(z, instr(ucase(z), right(ucase(z), i)) - 1) then
        CU_FAIL(  Extract zstring caseinsensitive )
      else
        CU_PASS(  Extract zstring caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(i, z, right(z, i), 1) <> mid(left(z, instr(ucase(z), right(ucase(z), i)) - 1), i) then
        CU_FAIL(  Extract zstring start caseinsensitive )
      else
        CU_PASS(  Extract zstring start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(z, any right(z, i)) <> left(z, instr(z, any right(z, i)) - 1) then
        CU_FAIL(  Extract zstring any new )
      else
        CU_PASS(  Extract zstring any new )
      end if
      next i



      for i = 1 to 7
      if extract_(z, any right(z, i)) <> left(z, instr(z, any right(z, i)) - 1) then
        CU_FAIL(  Extract zstring any )
      else
        CU_PASS(  Extract zstring any )
      end if
      next i



      for i = 1 to 7
      if extract_(z, any right(z, i), 1) <> left(z, instr(ucase(z), any right(ucase(z), i)) - 1) then
        CU_FAIL(  Extract zstring caseinsensitive any )
      else
        CU_PASS(  Extract zstring caseinsensitive any )
      end if
      next i



      for i = 2 to len(s)
      if extract_(s, Mid(s, i, 1)) <> left(s, instr(s, mid(s, i, 1)) - 1) then
        CU_FAIL(  Extract string )
      else
        CU_PASS(  Extract string )
      end if
      next i



      for i = 1 to 7
      if extract_(s, right(s, i), 1) <> left(s, instr(ucase(s), right(ucase(s), i)) - 1) then
        CU_FAIL(  Extract string caseinsensitive )
      else
        CU_PASS(  Extract string caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(i, s, right(s, i), 1) <> mid(left(s, instr(ucase(s), right(ucase(s), i)) - 1), i) then
        CU_FAIL(  Extract string start caseinsensitive )
      else
        CU_PASS(  Extract string start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(s, any right(s, i)) <> left(s, instr(s, any right(s, i)) - 1) then
        CU_FAIL(  Extract string any new )
      else
        CU_PASS(  Extract string any new )
      end if
      next i



      for i = 1 to 7
      if extract_(s, any right(s, i)) <> left(s, instr(s, any right(s, i)) - 1) then
        CU_FAIL(  Extract string any )
      else
        CU_PASS(  Extract string any )
      end if
      next i



      for i = 1 to 7
      if extract_(s, any right(s, i), 1) <> left(s, instr(ucase(s), any right(ucase(s), i)) - 1) then
        CU_FAIL(  Extract string caseinsensitive any )
      else
        CU_PASS(  Extract string caseinsensitive any )
      end if
      next i



do_wide_only:


      for i = 2 to len(w)
      if extract_(w, Mid(w, i, 1)) <> left(w, instr(w, mid(w, i, 1)) - 1) then
        CU_FAIL(  Extract wstring )
      else
        CU_PASS(  Extract wstring )
      end if
      next i



      for i = 1 to 7
      if extract_(w, right(w, i), 1) <> left(w, instr(ucase(w), right(ucase(w), i)) - 1) then
        CU_FAIL(  Extract wstring caseinsensitive )
      else
        CU_PASS(  Extract wstring caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(i, w, right(w, i), 1) <> mid(left(w, instr(ucase(w), right(ucase(w), i)) - 1), i) then
        CU_FAIL(  Extract wstring start caseinsensitive )
      else
        CU_PASS(  Extract wstring start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(w, any right(w, i)) <> left(w, instr(w, any right(w, i)) - 1) then
        CU_FAIL(  Extract wstring any new )
      else
        CU_PASS(  Extract wstring any new )
      end if
      next i



      for i = 1 to 7
      if extract_(w, any right(w, i)) <> left(w, instr(w, any right(w, i)) - 1) then
        CU_FAIL(  Extract wstring any )
      else
        CU_PASS(  Extract wstring any )
      end if
      next i



      for i = 1 to 7
      if extract_(w, any right(w, i), 1) <> left(w, instr(ucase(w), any right(ucase(w), i)) - 1) then
        CU_FAIL(  Extract wstring caseinsensitive any )
      else
        CU_PASS(  Extract wstring caseinsensitive any )
      end if
      next i



      for i = 2 to len(u)
      if extract_(u, Mid(u, i, 1)) <> left(u, instr(u, mid(u, i, 1)) - 1) then
        CU_FAIL(  Extract ustring )
      else
        CU_PASS(  Extract ustring )
      end if
      next i



      for i = 1 to 7
      if extract_(u, right(u, i), 1) <> left(u, instr(ucase(u), right(ucase(u), i)) - 1) then
        CU_FAIL(  Extract ustring caseinsensitive )
      else
        CU_PASS(  Extract ustring caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(i, u, right(u, i), 1) <> mid(left(u, instr(ucase(u), right(ucase(u), i)) - 1), i) then
        CU_FAIL(  Extract ustring start caseinsensitive )
      else
        CU_PASS(  Extract ustring start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if extract_(u, any right(u, i)) <> left(u, instr(u, any right(u, i)) - 1) then
        CU_FAIL(  Extract ustring any new )
      else
        CU_PASS(  Extract ustring any new )
      end if
      next i



      for i = 1 to 7
      if extract_(u, any right(u, i)) <> left(u, instr(u, any right(u, i)) - 1) then
        CU_FAIL(  Extract ustring any )
      else
        CU_PASS(  Extract ustring any )
      end if
      next i



      for i = 1 to 7
      if extract_(u, any right(u, i), 1) <> left(u, instr(ucase(u), any right(ucase(u), i)) - 1) then
        CU_FAIL(  Extract ustring caseinsensitive any )
      else
        CU_PASS(  Extract ustring caseinsensitive any )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_extract_ )
dim y  as wstring * 128


  TEST ( extract_1 )
    y = "1234567890 + abcdefghij"
    test_extract_(y, 1, 0)
  END_TEST

  TEST ( extract_2 )
    y = "1234567890 + abcdefghij"
    test_extract_(y+y, 2, 0)
  END_TEST

  TEST ( extract_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_extract_(y, 1, 0)
  END_TEST

  TEST ( extract_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_extract_(y+y, 2, 0)
  END_TEST

  TEST ( extract_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_extract_(y, 1, 1)
  END_TEST

  TEST ( extract_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_extract_(y+y, 2, 1)
  END_TEST


END_SUITE
