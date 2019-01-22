#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_remain_(y, cc, uflag)
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


      if remain_(z, "") <> "" then
        CU_FAIL(  Remain zstring nothing )
      else
        CU_PASS(  Remain zstring nothing )
      end if


      if remain_(z, z) <> "" then
        CU_FAIL(  Remain zstring all )
      else
        CU_PASS(  Remain zstring all )
      end if


      if remain_(z, any z) <> mid(z, 2) then
        CU_FAIL(  Remain zstring all any )
      else
        CU_PASS(  Remain zstring all any )
      end if


      if remain_(z, any strreverse_(z)) <> mid(z, 2) then
        CU_FAIL(  Remain zstring all any )
      else
        CU_PASS(  Remain zstring all any )
      end if


      for i = 2 to len(z)
      if remain_(z, Mid(z, i, 1)) <> mid(z, instr(z, mid(z, i, 1)) + 1) then
        CU_FAIL(  Remain zstring )
      else
        CU_PASS(  Remain zstring )
      end if
      next i



      for i = 1 to 7
      if remain_(z, left(z, i), 1) <> mid(z, instr(ucase(z), left(ucase(z), i)) + i) then
        CU_FAIL(  Remain zstring caseinsensitive )
      else
        CU_PASS(  Remain zstring caseinsensitive )
      end if
      next i



      for i = 4 to 7                                                                      
      if remain_(i-2, z, mid(ucase(z), i, 2), 1) <> mid(z, instr(i-2, ucase(z), mid(ucase(z), i, 2)) + 2) then
        CU_FAIL(  Remain zstring start caseinsensitive )
      else
        CU_PASS(  Remain zstring start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if remain_(z, any strreverse_(left(z, i))) <> mid(z, instr(z, any left(z, i)) + 1) then
        CU_FAIL(  Remain zstring any new )
      else
        CU_PASS(  Remain zstring any new )
      end if
      next i



      for i = 1 to 7
      if remain_(z, any strreverse_(left(z, i))) <> mid(z, instr(z, any left(z, i)) + 1) then
        CU_FAIL(  Remain zstring any )
      else
        CU_PASS(  Remain zstring any )
      end if
      next i



      for i = 1 to 7
      if remain_(z, any strreverse_(mid(z, i, 2)), 1) <> mid(z, instr(ucase(z), any mid(ucase(z), i, 2)) + 1) then
        CU_FAIL(  Remain zstring caseinsensitive any )
      else
        CU_PASS(  Remain zstring caseinsensitive any )
      end if
      next i



      for i = 2 to len(s)
      if remain_(s, Mid(s, i, 1)) <> mid(s, instr(s, mid(s, i, 1)) + 1) then
        CU_FAIL(  Remain string )
      else
        CU_PASS(  Remain string )
      end if
      next i



      for i = 1 to 7
      if remain_(s, left(s, i), 1) <> mid(s, instr(ucase(s), left(ucase(s), i)) + i) then
        CU_FAIL(  Remain string caseinsensitive )
      else
        CU_PASS(  Remain string caseinsensitive )
      end if
      next i



      for i = 4 to 7                                                                      
      if remain_(i-2, s, mid(ucase(s), i, 2), 1) <> mid(s, instr(i-2, ucase(s), mid(ucase(s), i, 2)) + 2) then
        CU_FAIL(  Remain string start caseinsensitive )
      else
        CU_PASS(  Remain string start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if remain_(s, any strreverse_(left(s, i))) <> mid(s, instr(s, any left(s, i)) + 1) then
        CU_FAIL(  Remain string any new )
      else
        CU_PASS(  Remain string any new )
      end if
      next i



      for i = 1 to 7
      if remain_(s, any strreverse_(left(s, i))) <> mid(s, instr(s, any left(s, i)) + 1) then
        CU_FAIL(  Remain string any )
      else
        CU_PASS(  Remain string any )
      end if
      next i



      for i = 1 to 7
      if remain_(s, any strreverse_(mid(s, i, 2)), 1) <> mid(s, instr(ucase(s), any mid(ucase(s), i, 2)) + 1) then
        CU_FAIL(  Remain string caseinsensitive any )
      else
        CU_PASS(  Remain string caseinsensitive any )
      end if
      next i



do_wide_only:


      for i = 2 to len(w)
      if remain_(w, Mid(w, i, 1)) <> mid(w, instr(w, mid(w, i, 1)) + 1) then
        CU_FAIL(  Remain wstring )
      else
        CU_PASS(  Remain wstring )
      end if
      next i



      for i = 1 to 7
      if remain_(w, left(w, i), 1) <> mid(w, instr(ucase(w), left(ucase(w), i)) + i) then
        CU_FAIL(  Remain wstring caseinsensitive )
      else
        CU_PASS(  Remain wstring caseinsensitive )
      end if
      next i



      for i = 4 to 7                                                                      
      if remain_(i-2, w, mid(ucase(w), i, 2), 1) <> mid(w, instr(i-2, ucase(w), mid(ucase(w), i, 2)) + 2) then
        CU_FAIL(  Remain wstring start caseinsensitive )
      else
        CU_PASS(  Remain wstring start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if remain_(w, any strreverse_(left(w, i))) <> mid(w, instr(w, any left(w, i)) + 1) then
        CU_FAIL(  Remain wstring any new )
      else
        CU_PASS(  Remain wstring any new )
      end if
      next i



      for i = 1 to 7
      if remain_(w, any strreverse_(left(w, i))) <> mid(w, instr(w, any left(w, i)) + 1) then
        CU_FAIL(  Remain wstring any )
      else
        CU_PASS(  Remain wstring any )
      end if
      next i



      for i = 1 to 7
      if remain_(w, any strreverse_(mid(w, i, 2)), 1) <> mid(w, instr(ucase(w), any mid(ucase(w), i, 2)) + 1) then
        CU_FAIL(  Remain wstring caseinsensitive any )
      else
        CU_PASS(  Remain wstring caseinsensitive any )
      end if
      next i



      for i = 2 to len(u)
      if remain_(u, Mid(u, i, 1)) <> mid(u, instr(u, mid(u, i, 1)) + 1) then
        CU_FAIL(  Remain ustring )
      else
        CU_PASS(  Remain ustring )
      end if
      next i



      for i = 1 to 7
      if remain_(u, left(u, i), 1) <> mid(u, instr(ucase(u), left(ucase(u), i)) + i) then
        CU_FAIL(  Remain ustring caseinsensitive )
      else
        CU_PASS(  Remain ustring caseinsensitive )
      end if
      next i



      for i = 4 to 7                                                                      
      if remain_(i-2, u, mid(ucase(u), i, 2), 1) <> mid(u, instr(i-2, ucase(u), mid(ucase(u), i, 2)) + 2) then
        CU_FAIL(  Remain ustring start caseinsensitive )
      else
        CU_PASS(  Remain ustring start caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if remain_(u, any strreverse_(left(u, i))) <> mid(u, instr(u, any left(u, i)) + 1) then
        CU_FAIL(  Remain ustring any new )
      else
        CU_PASS(  Remain ustring any new )
      end if
      next i



      for i = 1 to 7
      if remain_(u, any strreverse_(left(u, i))) <> mid(u, instr(u, any left(u, i)) + 1) then
        CU_FAIL(  Remain ustring any )
      else
        CU_PASS(  Remain ustring any )
      end if
      next i



      for i = 1 to 7
      if remain_(u, any strreverse_(mid(u, i, 2)), 1) <> mid(u, instr(ucase(u), any mid(ucase(u), i, 2)) + 1) then
        CU_FAIL(  Remain ustring caseinsensitive any )
      else
        CU_PASS(  Remain ustring caseinsensitive any )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_remain_ )
dim y  as wstring * 128


  TEST ( remain_1 )
    y = "1234567890 + abcdefghij"
    test_remain_(y, 1, 0)
  END_TEST

  TEST ( remain_2 )
    y = "1234567890 + abcdefghij"
    test_remain_(y+y, 2, 0)
  END_TEST

  TEST ( remain_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_remain_(y, 1, 0)
  END_TEST

  TEST ( remain_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_remain_(y+y, 2, 0)
  END_TEST

  TEST ( remain_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_remain_(y, 1, 1)
  END_TEST

  TEST ( remain_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_remain_(y+y, 2, 1)
  END_TEST


END_SUITE
