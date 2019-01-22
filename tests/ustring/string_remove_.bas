#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_remove_(y, cc, uflag)
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


      if remove_(z, "") <> z then
        CU_FAIL(  remove nothing zstring )
      else
        CU_PASS(  remove nothing zstring )
      end if


      if remove_(z, z) <> "" then
        CU_FAIL(  remove all zstring )
      else
        CU_PASS(  remove all zstring )
      end if


      if remove_(z, any z) <> "" then
        CU_FAIL(  remove all any zstring )
      else
        CU_PASS(  remove all any zstring )
      end if


      for i = 2 to len(z)/2 - 2
      if remove_(z, Mid(z, i, len(z) - i*2)) <> mid(z, 1, i-1) & mid(z, len(z) - i) then
        CU_FAIL(  remove zstring )
      else
        CU_PASS(  remove zstring )
      end if
      next i



      for i = 1 to 7
      if len(remove_(z, left(z, i))) <> len(z) - tally(z, left(z, i)) * len(left(z, i)) then
        CU_FAIL(  remove zstring )
      else
        CU_PASS(  remove zstring )
      end if
      next i



      for i = 1 to 7
      if len(remove_(z, left(z, i), 1)) <> len(z) - tally(z, left(z, i), 1) * len(left(z, i)) then
        CU_FAIL(  remove zstring caseinsensitive )
      else
        CU_PASS(  remove zstring caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if len(remove_(z, any left(z, i), 1)) <> len(z) - tally(z, any left(z, i), 1) then
        CU_FAIL(  remove zstring caseinsensitive any )
      else
        CU_PASS(  remove zstring caseinsensitive any )
      end if
      next i



      for i = 1 to 7
      if len(remove_(z, any strreverse_(left(z, i)), 1)) <> len(z) - tally(z, any left(z, i), 1) then
        CU_FAIL(  remove zstring caseinsensitive any )
      else
        CU_PASS(  remove zstring caseinsensitive any )
      end if
      next i



      for i = 2 to len(s)/2 - 2
      if remove_(s, Mid(s, i, len(s) - i*2)) <> mid(s, 1, i-1) & mid(s, len(s) - i) then
        CU_FAIL(  remove string )
      else
        CU_PASS(  remove string )
      end if
      next i



      for i = 1 to 7
      if len(remove_(s, left(s, i))) <> len(s) - tally(s, left(s, i)) * len(left(s, i)) then
        CU_FAIL(  remove string )
      else
        CU_PASS(  remove string )
      end if
      next i



      for i = 1 to 7
      if len(remove_(s, left(s, i), 1)) <> len(s) - tally(s, left(s, i), 1) * len(left(s, i)) then
        CU_FAIL(  remove string caseinsensitive )
      else
        CU_PASS(  remove string caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if len(remove_(s, any left(s, i), 1)) <> len(s) - tally(s, any left(s, i), 1) then
        CU_FAIL(  remove string caseinsensitive any )
      else
        CU_PASS(  remove string caseinsensitive any )
      end if
      next i



      for i = 1 to 7
      if len(remove_(s, any strreverse_(left(s, i)), 1)) <> len(s) - tally(s, any left(s, i), 1) then
        CU_FAIL(  remove string caseinsensitive any )
      else
        CU_PASS(  remove string caseinsensitive any )
      end if
      next i



do_wide_only:


      for i = 2 to len(w)/2 - 2
      if remove_(w, Mid(w, i, len(w) - i*2)) <> mid(w, 1, i-1) & mid(w, len(w) - i) then
        CU_FAIL(  remove wstring )
      else
        CU_PASS(  remove wstring )
      end if
      next i



      for i = 1 to 7
      if len(remove_(w, left(w, i))) <> len(w) - tally(w, left(w, i)) * len(left(w, i)) then
        CU_FAIL(  remove wstring )
      else
        CU_PASS(  remove wstring )
      end if
      next i



      for i = 1 to 7
      if len(remove_(w, left(w, i), 1)) <> len(w) - tally(w, left(w, i), 1) * len(left(w, i)) then
        CU_FAIL(  remove wstring caseinsensitive )
      else
        CU_PASS(  remove wstring caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if len(remove_(w, any left(w, i), 1)) <> len(w) - tally(w, any left(w, i), 1) then
        CU_FAIL(  remove wstring caseinsensitive any )
      else
        CU_PASS(  remove wstring caseinsensitive any )
      end if
      next i



      for i = 1 to 7
      if len(remove_(w, any strreverse_(left(w, i)), 1)) <> len(w) - tally(w, any left(w, i), 1) then
        CU_FAIL(  remove wstring caseinsensitive any )
      else
        CU_PASS(  remove wstring caseinsensitive any )
      end if
      next i



      for i = 2 to len(u)/2 - 2
      if remove_(u, Mid(u, i, len(u) - i*2)) <> mid(u, 1, i-1) & mid(u, len(u) - i) then
        CU_FAIL(  remove ustring )
      else
        CU_PASS(  remove ustring )
      end if
      next i



      for i = 1 to 7
      if len(remove_(u, left(u, i))) <> len(u) - tally(u, left(u, i)) * len(left(u, i)) then
        CU_FAIL(  remove ustring )
      else
        CU_PASS(  remove ustring )
      end if
      next i



      for i = 1 to 7
      if len(remove_(u, left(u, i), 1)) <> len(u) - tally(u, left(u, i), 1) * len(left(u, i)) then
        CU_FAIL(  remove ustring caseinsensitive )
      else
        CU_PASS(  remove ustring caseinsensitive )
      end if
      next i



      for i = 1 to 7
      if len(remove_(u, any left(u, i), 1)) <> len(u) - tally(u, any left(u, i), 1) then
        CU_FAIL(  remove ustring caseinsensitive any )
      else
        CU_PASS(  remove ustring caseinsensitive any )
      end if
      next i



      for i = 1 to 7
      if len(remove_(u, any strreverse_(left(u, i)), 1)) <> len(u) - tally(u, any left(u, i), 1) then
        CU_FAIL(  remove ustring caseinsensitive any )
      else
        CU_PASS(  remove ustring caseinsensitive any )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_remove_ )
dim y  as wstring * 128


  TEST ( remove_1 )
    y = "1234567890 + abcdefghij"
    test_remove_(y, 1, 0)
  END_TEST

  TEST ( remove_2 )
    y = "1234567890 + abcdefghij"
    test_remove_(y+y, 2, 0)
  END_TEST

  TEST ( remove_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_remove_(y, 1, 0)
  END_TEST

  TEST ( remove_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_remove_(y+y, 2, 0)
  END_TEST

  TEST ( remove_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_remove_(y, 1, 1)
  END_TEST

  TEST ( remove_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_remove_(y+y, 2, 1)
  END_TEST


END_SUITE
