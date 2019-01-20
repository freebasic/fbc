#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_parse_(y, cc, uflag)
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


      if parse_(z, 0) <> "" then                          'outside -> must return ""
        CU_FAIL(  parse 0 delimiter not present zstring )
      else
        CU_PASS(  parse 0 delimiter not present zstring )
      end if


      if parse_(z, 1) <> z then
        CU_FAIL(  parse 1 delimiter not present zstring )
      else
        CU_PASS(  parse 1 delimiter not present zstring )
      end if


      if parse_(z, 2) <> "" then
        CU_FAIL(  parse 2 delimiter not present zstring )
      else
        CU_PASS(  parse 2 delimiter not present zstring )
      end if


      if parse_(z, "", 1) <> z then
        CU_FAIL(  parse 1 delimiter not present zstring )
      else
        CU_PASS(  parse 1 delimiter not present zstring )
      end if


      for i = 1 to 7
      if parse_(z, left(z, i), 1) <> "" then
        CU_FAIL(  parse 1 delimiter = start zstring )
      else
        CU_PASS(  parse 1 delimiter = start zstring )
      end if
      next i



      for i = 1 to 7
      if parse_(z, any strreverse_(left(z, i)), 1) <> "" then
        CU_FAIL(  parse any 1 delimiter = start zstring )
      else
        CU_PASS(  parse any 1 delimiter = start zstring )
      end if
      next i



      for i = 1 to 7
      if parse_(z, left(z, i), 2) <> mid(z, i+1, instr(i+1, z, left(z, i)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start zstring )
      else
        CU_PASS(  parse 2 delimiter = start zstring )
      end if
      next i



      for i = 2 to 7
      if parse_(z, mid(z, i, 1), 2) <> mid(z, i+1, instr(i+1, z, mid(z, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start zstring )
      else
        CU_PASS(  parse 2 delimiter = start zstring )
      end if
      next i



      for i = 2 to 7
      if parse_(z, any strreverse_(mid(z, i, 1)), 2) <> mid(z, i+1, instr(i+1, z, mid(z, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start zstring )
      else
        CU_PASS(  parse 2 delimiter = start zstring )
      end if
      next i



      if parse_(s, 0) <> "" then                          'outside -> must return ""
        CU_FAIL(  parse 0 delimiter not present string )
      else
        CU_PASS(  parse 0 delimiter not present string )
      end if


      if parse_(s, 1) <> s then
        CU_FAIL(  parse 1 delimiter not present string )
      else
        CU_PASS(  parse 1 delimiter not present string )
      end if


      if parse_(s, 2) <> "" then
        CU_FAIL(  parse 2 delimiter not present string )
      else
        CU_PASS(  parse 2 delimiter not present string )
      end if


      if parse_(s, "", 1) <> s then
        CU_FAIL(  parse 1 delimiter not present string )
      else
        CU_PASS(  parse 1 delimiter not present string )
      end if


      for i = 1 to 7
      if parse_(s, left(s, i), 1) <> "" then
        CU_FAIL(  parse 1 delimiter = start string )
      else
        CU_PASS(  parse 1 delimiter = start string )
      end if
      next i



      for i = 1 to 7
      if parse_(s, any strreverse_(left(s, i)), 1) <> "" then
        CU_FAIL(  parse any 1 delimiter = start string )
      else
        CU_PASS(  parse any 1 delimiter = start string )
      end if
      next i



      for i = 1 to 7
      if parse_(s, left(s, i), 2) <> mid(s, i+1, instr(i+1, s, left(s, i)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start string )
      else
        CU_PASS(  parse 2 delimiter = start string )
      end if
      next i



      for i = 2 to 7
      if parse_(s, mid(s, i, 1), 2) <> mid(s, i+1, instr(i+1, s, mid(s, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start string )
      else
        CU_PASS(  parse 2 delimiter = start string )
      end if
      next i



      for i = 2 to 7
      if parse_(s, any strreverse_(mid(s, i, 1)), 2) <> mid(s, i+1, instr(i+1, s, mid(s, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start string )
      else
        CU_PASS(  parse 2 delimiter = start string )
      end if
      next i



do_wide_only:


      if parse_(w, 0) <> "" then                          'outside -> must return ""
        CU_FAIL(  parse 0 delimiter not present wstring )
      else
        CU_PASS(  parse 0 delimiter not present wstring )
      end if


      if parse_(w, 1) <> w then
        CU_FAIL(  parse 1 delimiter not present wstring )
      else
        CU_PASS(  parse 1 delimiter not present wstring )
      end if


      if parse_(w, 2) <> "" then
        CU_FAIL(  parse 2 delimiter not present wstring )
      else
        CU_PASS(  parse 2 delimiter not present wstring )
      end if


      if parse_(w, "", 1) <> w then
        CU_FAIL(  parse 1 delimiter not present wstring )
      else
        CU_PASS(  parse 1 delimiter not present wstring )
      end if


      for i = 1 to 7
      if parse_(w, left(w, i), 1) <> "" then
        CU_FAIL(  parse 1 delimiter = start wstring )
      else
        CU_PASS(  parse 1 delimiter = start wstring )
      end if
      next i



      for i = 1 to 7
      if parse_(w, any strreverse_(left(w, i)), 1) <> "" then
        CU_FAIL(  parse any 1 delimiter = start wstring )
      else
        CU_PASS(  parse any 1 delimiter = start wstring )
      end if
      next i



      for i = 1 to 7
      if parse_(w, left(w, i), 2) <> mid(w, i+1, instr(i+1, w, left(w, i)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start wstring )
      else
        CU_PASS(  parse 2 delimiter = start wstring )
      end if
      next i



      for i = 2 to 7
      if parse_(w, mid(w, i, 1), 2) <> mid(w, i+1, instr(i+1, w, mid(w, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start wstring )
      else
        CU_PASS(  parse 2 delimiter = start wstring )
      end if
      next i



      for i = 2 to 7
      if parse_(w, any strreverse_(mid(w, i, 1)), 2) <> mid(w, i+1, instr(i+1, w, mid(w, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start wstring )
      else
        CU_PASS(  parse 2 delimiter = start wstring )
      end if
      next i



      if parse_(u, 0) <> "" then                          'outside -> must return ""
        CU_FAIL(  parse 0 delimiter not present ustring )
      else
        CU_PASS(  parse 0 delimiter not present ustring )
      end if


      if parse_(u, 1) <> u then
        CU_FAIL(  parse 1 delimiter not present ustring )
      else
        CU_PASS(  parse 1 delimiter not present ustring )
      end if


      if parse_(u, 2) <> "" then
        CU_FAIL(  parse 2 delimiter not present ustring )
      else
        CU_PASS(  parse 2 delimiter not present ustring )
      end if


      if parse_(u, "", 1) <> u then
        CU_FAIL(  parse 1 delimiter not present ustring )
      else
        CU_PASS(  parse 1 delimiter not present ustring )
      end if


      for i = 1 to 7
      if parse_(u, left(u, i), 1) <> "" then
        CU_FAIL(  parse 1 delimiter = start ustring )
      else
        CU_PASS(  parse 1 delimiter = start ustring )
      end if
      next i



      for i = 1 to 7
      if parse_(u, any strreverse_(left(u, i)), 1) <> "" then
        CU_FAIL(  parse any 1 delimiter = start ustring )
      else
        CU_PASS(  parse any 1 delimiter = start ustring )
      end if
      next i



      for i = 1 to 7
      if parse_(u, left(u, i), 2) <> mid(u, i+1, instr(i+1, u, left(u, i)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start ustring )
      else
        CU_PASS(  parse 2 delimiter = start ustring )
      end if
      next i



      for i = 2 to 7
      if parse_(u, mid(u, i, 1), 2) <> mid(u, i+1, instr(i+1, u, mid(u, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start ustring )
      else
        CU_PASS(  parse 2 delimiter = start ustring )
      end if
      next i



      for i = 2 to 7
      if parse_(u, any strreverse_(mid(u, i, 1)), 2) <> mid(u, i+1, instr(i+1, u, mid(u, i, 1)) - i - 1) then
        CU_FAIL(  parse 2 delimiter = start ustring )
      else
        CU_PASS(  parse 2 delimiter = start ustring )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_parse_ )
dim y  as wstring * 128


  TEST ( parse_1 )
    y = "1234567890 + abcdefghij"
    test_parse_(y, 1, 0)
  END_TEST

  TEST ( parse_2 )
    y = "1234567890 + abcdefghij"
    test_parse_(y+y, 2, 0)
  END_TEST

  TEST ( parse_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_parse_(y, 1, 0)
  END_TEST

  TEST ( parse_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_parse_(y+y, 2, 0)
  END_TEST

  TEST ( parse_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_parse_(y, 1, 1)
  END_TEST

  TEST ( parse_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_parse_(y+y, 2, 1)
  END_TEST


END_SUITE
