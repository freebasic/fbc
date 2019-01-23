#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_replace_(y, cc, uflag)
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


      if replace_(z, z, "") <> "" then
        CU_FAIL(  replace all with nothing zstring )
      else
        CU_PASS(  replace all with nothing zstring )
      end if


      if replace_(z, "", "asdf") <> z then
        CU_FAIL(  replace nothing zstring )
      else
        CU_PASS(  replace nothing zstring )
      end if


      if replace_(z, z, z) <> z then
        CU_FAIL(  replace all with all zstring )
      else
        CU_PASS(  replace all with all zstring )
      end if


      if replace_(z1, any z1, z1) <> z1 + z1 + z1 + z1 then
        CU_FAIL(  replace all any with all zstring )
      else
        CU_PASS(  replace all any with all zstring )
      end if


      for i = 1 to 7
      if replace_(z, left(z, i), "") <> remove_(z, left(z, i)) then
        CU_FAIL(  replace with nothing zstring )
      else
        CU_PASS(  replace with nothing zstring )
      end if
      next i



      for i = 1 to 7
      if replace_(z, any left(z, i), "") <> remove_(z, any left(z, i)) then
        CU_FAIL(  replace with nothing any zstring )
      else
        CU_PASS(  replace with nothing any zstring )
      end if
      next i



      for i = 1 to 7
      if replace_(z, any left(z, i), "", 1) <> remove_(z, any left(z, i), 1) then
        CU_FAIL(  replace with nothing any caseinsensitive zstring )
      else
        CU_PASS(  replace with nothing any caseinsensitive zstring )
      end if
      next i



      for i = 1 to 7
      if replace_(z, "," "asdf", 1) <> z then
        CU_FAIL(  replace with not found zstring )
      else
        CU_PASS(  replace with not found zstring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(z, mid(z, i, 3), "x", 1)) <> len(z) - tally(z, mid(z, i, 3)) * 2 then
        CU_FAIL(  replace with <x> zstring )
      else
        CU_PASS(  replace with <x> zstring )
      end if
      next i



      for i = 1 to 17
      if len(replace_(z, mid(z, i, 4), "xx", 1)) <> len(z) - tally(z, mid(z, i, 4)) * 2 then
        CU_FAIL(  replace with <xx> zstring )
      else
        CU_PASS(  replace with <xx> zstring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(z, any mid(z, i, 4), "xx", 1)) <> len(z) + tally(ucase(z), any mid(ucase(z), i, 4)) then
        CU_FAIL(  replace with <x> any caseinsensitive zstring )
      else
        CU_PASS(  replace with <x> any caseinsensitive zstring )
      end if
      next i



      if replace_(s, s, "") <> "" then
        CU_FAIL(  replace all with nothing string )
      else
        CU_PASS(  replace all with nothing string )
      end if


      if replace_(s, "", "asdf") <> s then
        CU_FAIL(  replace nothing string )
      else
        CU_PASS(  replace nothing string )
      end if


      if replace_(s, s, s) <> s then
        CU_FAIL(  replace all with all string )
      else
        CU_PASS(  replace all with all string )
      end if


      if replace_(s1, any s1, s1) <> s1 + s1 + s1 + s1 then
        CU_FAIL(  replace all any with all string )
      else
        CU_PASS(  replace all any with all string )
      end if


      for i = 1 to 7
      if replace_(s, left(s, i), "") <> remove_(s, left(s, i)) then
        CU_FAIL(  replace with nothing string )
      else
        CU_PASS(  replace with nothing string )
      end if
      next i



      for i = 1 to 7
      if replace_(s, any left(s, i), "") <> remove_(s, any left(s, i)) then
        CU_FAIL(  replace with nothing any string )
      else
        CU_PASS(  replace with nothing any string )
      end if
      next i



      for i = 1 to 7
      if replace_(s, any left(s, i), "", 1) <> remove_(s, any left(s, i), 1) then
        CU_FAIL(  replace with nothing any caseinsensitive string )
      else
        CU_PASS(  replace with nothing any caseinsensitive string )
      end if
      next i



      for i = 1 to 7
      if replace_(s, "," "asdf", 1) <> s then
        CU_FAIL(  replace with not found string )
      else
        CU_PASS(  replace with not found string )
      end if
      next i



      for i = 1 to 7
      if len(replace_(s, mid(s, i, 3), "x", 1)) <> len(s) - tally(s, mid(s, i, 3)) * 2 then
        CU_FAIL(  replace with <x> string )
      else
        CU_PASS(  replace with <x> string )
      end if
      next i



      for i = 1 to 17
      if len(replace_(s, mid(s, i, 4), "xx", 1)) <> len(s) - tally(s, mid(s, i, 4)) * 2 then
        CU_FAIL(  replace with <xx> string )
      else
        CU_PASS(  replace with <xx> string )
      end if
      next i



      for i = 1 to 7
      if len(replace_(s, any mid(s, i, 4), "xx", 1)) <> len(s) + tally(ucase(s), any mid(ucase(s), i, 4)) then
        CU_FAIL(  replace with <x> any caseinsensitive string )
      else
        CU_PASS(  replace with <x> any caseinsensitive string )
      end if
      next i



do_wide_only:


      if replace_(w, w, "") <> "" then
        CU_FAIL(  replace all with nothing wstring )
      else
        CU_PASS(  replace all with nothing wstring )
      end if


      if replace_(w, "", "asdf") <> w then
        CU_FAIL(  replace nothing wstring )
      else
        CU_PASS(  replace nothing wstring )
      end if


      if replace_(w, w, w) <> w then
        CU_FAIL(  replace all with all wstring )
      else
        CU_PASS(  replace all with all wstring )
      end if


      if replace_(w1, any w1, w1) <> w1 + w1 + w1 + w1 then
        CU_FAIL(  replace all any with all wstring )
      else
        CU_PASS(  replace all any with all wstring )
      end if


      for i = 1 to 7
      if replace_(w, left(w, i), "") <> remove_(w, left(w, i)) then
        CU_FAIL(  replace with nothing wstring )
      else
        CU_PASS(  replace with nothing wstring )
      end if
      next i



      for i = 1 to 7
      if replace_(w, any left(w, i), "") <> remove_(w, any left(w, i)) then
        CU_FAIL(  replace with nothing any wstring )
      else
        CU_PASS(  replace with nothing any wstring )
      end if
      next i



      for i = 1 to 7
      if replace_(w, any left(w, i), "", 1) <> remove_(w, any left(w, i), 1) then
        CU_FAIL(  replace with nothing any caseinsensitive wstring )
      else
        CU_PASS(  replace with nothing any caseinsensitive wstring )
      end if
      next i



      for i = 1 to 7
      if replace_(w, "," "asdf", 1) <> w then
        CU_FAIL(  replace with not found wstring )
      else
        CU_PASS(  replace with not found wstring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(w, mid(w, i, 3), "x", 1)) <> len(w) - tally(w, mid(w, i, 3)) * 2 then
        CU_FAIL(  replace with <x> wstring )
      else
        CU_PASS(  replace with <x> wstring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(w, mid(w, i, 4), "xx", 1)) <> len(w) - tally(w, mid(w, i, 4)) * 2 then
        CU_FAIL(  replace with <xx> wstring )
      else
        CU_PASS(  replace with <xx> wstring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(w, any mid(w, i, 4), "xx", 1)) <> len(w) + tally(ucase(w), any mid(ucase(w), i, 4)) then
        CU_FAIL(  replace with <x> any caseinsensitive wstring )
      else
        CU_PASS(  replace with <x> any caseinsensitive wstring )
      end if
      next i



      if replace_(u, u, "") <> "" then
        CU_FAIL(  replace all with nothing ustring )
      else
        CU_PASS(  replace all with nothing ustring )
      end if


      if replace_(u, "", "asdf") <> u then
        CU_FAIL(  replace nothing ustring )
      else
        CU_PASS(  replace nothing ustring )
      end if


      if replace_(u, u, u) <> u then
        CU_FAIL(  replace all with all ustring )
      else
        CU_PASS(  replace all with all ustring )
      end if


      if replace_(u1, any u1, u1) <> u1 + u1 + u1 + u1 then
        CU_FAIL(  replace all any with all ustring )
      else
        CU_PASS(  replace all any with all ustring )
      end if


      for i = 1 to 7
      if replace_(u, left(u, i), "") <> remove_(u, left(u, i)) then
        CU_FAIL(  replace with nothing ustring )
      else
        CU_PASS(  replace with nothing ustring )
      end if
      next i



      for i = 1 to 7
      if replace_(u, any left(u, i), "") <> remove_(u, any left(u, i)) then
        CU_FAIL(  replace with nothing any ustring )
      else
        CU_PASS(  replace with nothing any ustring )
      end if
      next i



      for i = 1 to 7
      if replace_(u, any left(u, i), "", 1) <> remove_(u, any left(u, i), 1) then
        CU_FAIL(  replace with nothing any caseinsensitive ustring )
      else
        CU_PASS(  replace with nothing any caseinsensitive ustring )
      end if
      next i



      for i = 1 to 7
      if replace_(u, "," "asdf", 1) <> u then
        CU_FAIL(  replace with not found ustring )
      else
        CU_PASS(  replace with not found ustring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(u, mid(u, i, 3), "x", 1)) <> len(u) - tally(u, mid(u, i, 3)) * 2 then
        CU_FAIL(  replace with <x> ustring )
      else
        CU_PASS(  replace with <x> ustring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(u, mid(u, i, 4), "xx", 1)) <> len(u) - tally(u, mid(u, i, 4)) * 2 then
        CU_FAIL(  replace with <xx> ustring )
      else
        CU_PASS(  replace with <xx> ustring )
      end if
      next i



      for i = 1 to 7
      if len(replace_(u, any mid(u, i, 4), "xx", 1)) <> len(u) + tally(ucase(u), any mid(ucase(u), i, 4)) then
        CU_FAIL(  replace with <x> any caseinsensitive ustring )
      else
        CU_PASS(  replace with <x> any caseinsensitive ustring )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_replace_ )
dim y  as wstring * 128


  TEST ( replace_1 )
    y = "1234567890 + abcdefghij"
    test_replace_(y, 1, 0)
  END_TEST

  TEST ( replace_2 )
    y = "1234567890 + abcdefghij"
    test_replace_(y+y, 2, 0)
  END_TEST

  TEST ( replace_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_replace_(y, 1, 0)
  END_TEST

  TEST ( replace_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_replace_(y+y, 2, 0)
  END_TEST

  TEST ( replace_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_replace_(y, 1, 1)
  END_TEST

  TEST ( replace_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_replace_(y+y, 2, 1)
  END_TEST


END_SUITE
