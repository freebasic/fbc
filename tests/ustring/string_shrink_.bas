#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_shrink_(y, cc, uflag)
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


      if shrink_(z) <> z then    
        CU_FAIL(  shrink nothing zstring )
      else
        CU_PASS(  shrink nothing zstring )
      end if


      if shrink_(z + space(25)) <> z then    
        CU_FAIL(  shrink 25 spaces trailing zstring )
      else
        CU_PASS(  shrink 25 spaces trailing zstring )
      end if


      if shrink_(space(25) + z) <> z then    
        CU_FAIL(  shrink 25 leading spaces zstring )
      else
        CU_PASS(  shrink 25 leading spaces zstring )
      end if


      if shrink_(space(25) + z + space(25)) <> z then    
        CU_FAIL(  shrink 25 leading and trailing spaces zstring )
      else
        CU_PASS(  shrink 25 leading and trailing spaces zstring )
      end if


      for i = 2 to 7
      z1= left(z, i) + space(3) + mid(z, i+1)
      
      if tally(shrink_(z1), " ") <> tally(z, " ") + 1 then    
        CU_FAIL(  shrink spaces inside zstring )
      else
        CU_PASS(  shrink spaces inside zstring )
      end if
      next i



      for i = 2 to 7
      z1= left(z, 2) + string(i, 88) + mid(z, 3)
      
      if len(shrink_(z1, "X")) <> len(z) + 1 then    
        CU_FAIL(  shrink X inside zstring )
      else
        CU_PASS(  shrink X inside zstring )
      end if
      next i



      for i = 2 to 7
      z1= left(z, 2) + string(i, 88) + mid(z, 3, 2) + string(4, 88) + mid(z, 5)
      
      if len(shrink_(z1, "X")) <> len(z) + 2 then    
        CU_FAIL(  shrink X inside zstring )
      else
        CU_PASS(  shrink X inside zstring )
      end if
      next i



      if shrink_(s) <> s then    
        CU_FAIL(  shrink nothing string )
      else
        CU_PASS(  shrink nothing string )
      end if


      if shrink_(s + space(25)) <> s then    
        CU_FAIL(  shrink 25 spaces trailing string )
      else
        CU_PASS(  shrink 25 spaces trailing string )
      end if


      if shrink_(space(25) + s) <> s then    
        CU_FAIL(  shrink 25 leading spaces string )
      else
        CU_PASS(  shrink 25 leading spaces string )
      end if


      if shrink_(space(25) + s + space(25)) <> s then    
        CU_FAIL(  shrink 25 leading and trailing spaces string )
      else
        CU_PASS(  shrink 25 leading and trailing spaces string )
      end if


      for i = 2 to 7
      s1= left(s, i) + space(3) + mid(s, i+1)
      
      if tally(shrink_(s1), " ") <> tally(s, " ") + 1 then    
        CU_FAIL(  shrink spaces inside string )
      else
        CU_PASS(  shrink spaces inside string )
      end if
      next i



      for i = 2 to 7
      s1= left(s, 2) + string(i, 88) + mid(s, 3)
      
      if len(shrink_(s1, "X")) <> len(s) + 1 then    
        CU_FAIL(  shrink X inside string )
      else
        CU_PASS(  shrink X inside string )
      end if
      next i



      for i = 2 to 7
      s1= left(s, 2) + string(i, 88) + mid(s, 3, 2) + string(4, 88) + mid(s, 5)
      
      if len(shrink_(s1, "X")) <> len(s) + 2 then    
        CU_FAIL(  shrink X inside string )
      else
        CU_PASS(  shrink X inside string )
      end if
      next i



do_wide_only:


      if shrink_(w) <> w then    
        CU_FAIL(  shrink nothing wstring )
      else
        CU_PASS(  shrink nothing wstring )
      end if


      if shrink_(w + space(25)) <> w then    
        CU_FAIL(  shrink 25 spaces trailing wstring )
      else
        CU_PASS(  shrink 25 spaces trailing wstring )
      end if


      if shrink_(space(25) + w) <> w then    
        CU_FAIL(  shrink 25 leading spaces wstring )
      else
        CU_PASS(  shrink 25 leading spaces wstring )
      end if


      if shrink_(space(25) + w + space(25)) <> w then    
        CU_FAIL(  shrink 25 leading and trailing spaces wstring )
      else
        CU_PASS(  shrink 25 leading and trailing spaces wstring )
      end if


      for i = 2 to 7
      w1= left(w, i) + space(3) + mid(w, i+1)
      
      if tally(shrink_(w1), " ") <> tally(w, " ") + 1 then    
        CU_FAIL(  shrink spaces inside wstring )
      else
        CU_PASS(  shrink spaces inside wstring )
      end if
      next i



      for i = 2 to 7
      w1= left(w, 2) + string(i, 88) + mid(w, 3)
      
      if len(shrink_(w1, "X")) <> len(w) + 1 then    
        CU_FAIL(  shrink X inside wstring )
      else
        CU_PASS(  shrink X inside wstring )
      end if
      next i



      for i = 2 to 7
      w1= left(w, 2) + string(i, 88) + mid(w, 3, 2) + string(4, 88) + mid(w, 5)
      
      if len(shrink_(w1, "X")) <> len(w) + 2 then    
        CU_FAIL(  shrink X inside wstring )
      else
        CU_PASS(  shrink X inside wstring )
      end if
      next i



      if shrink_(u) <> u then    
        CU_FAIL(  shrink nothing ustring )
      else
        CU_PASS(  shrink nothing ustring )
      end if


      if shrink_(u + space(25)) <> u then    
        CU_FAIL(  shrink 25 spaces trailing ustring )
      else
        CU_PASS(  shrink 25 spaces trailing ustring )
      end if


      if shrink_(space(25) + u) <> u then    
        CU_FAIL(  shrink 25 leading spaces ustring )
      else
        CU_PASS(  shrink 25 leading spaces ustring )
      end if


      if shrink_(space(25) + u + space(25)) <> u then    
        CU_FAIL(  shrink 25 leading and trailing spaces ustring )
      else
        CU_PASS(  shrink 25 leading and trailing spaces ustring )
      end if


      for i = 2 to 7
      u1= left(u, i) + space(3) + mid(u, i+1)
      
      if tally(shrink_(u1), " ") <> tally(u, " ") + 1 then    
        CU_FAIL(  shrink spaces inside ustring )
      else
        CU_PASS(  shrink spaces inside ustring )
      end if
      next i



      for i = 1 to 7
      u1= left(u, 2) + string(i, 88) + mid(u, 3)
      
      if len(shrink_(u1, "X")) <> len(u) + 1 then    
        CU_FAIL(  shrink X inside ustring )
      else
        CU_PASS(  shrink X inside ustring )
      end if
      next i



      for i = 2 to 7
      u1= left(u, 2) + string(i, 88) + mid(u, 3, 2) + string(4, 88) + mid(u, 5)
      
      if len(shrink_(u1, "X")) <> len(u) + 2 then    
        CU_FAIL(  shrink X inside 2 ustring )
      else
        CU_PASS(  shrink X inside 2 ustring )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_shrink_ )
dim y  as wstring * 128


  TEST ( shrink_1 )
    y = "1234567890 + abcdefghij"
    test_shrink_(y, 1, 0)
  END_TEST

  TEST ( shrink_2 )
    y = "1234567890 + abcdefghij"
    test_shrink_(y+y, 2, 0)
  END_TEST

  TEST ( shrink_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_shrink_(y, 1, 0)
  END_TEST

  TEST ( shrink_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_shrink_(y+y, 2, 0)
  END_TEST

  TEST ( shrink_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_shrink_(y, 1, 1)
  END_TEST

  TEST ( shrink_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_shrink_(y+y, 2, 1)
  END_TEST


END_SUITE
