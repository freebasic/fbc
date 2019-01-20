#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_rset_(y, cc, uflag)
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


      if rset_(z, 0) <> "" then    
        CU_FAIL(  rset 0 zstring )
      else
        CU_PASS(  rset 0 zstring )
      end if


      if rset_(z, 25) <> right(space(25) + z, 25) then    
        CU_FAIL(  rset 25 zstring )
      else
        CU_PASS(  rset 25 zstring )
      end if


      for i = 1 to 80
      if rset_(z, i) <> right(space(i) + z, i) then    
        CU_FAIL(  rset zstring )
      else
        CU_PASS(  rset zstring )
      end if
      next i



      for i = 1 to 80
      if Rset_(z, i, "x") <> right(string(i, asc("x")) + z, i) then    
        CU_FAIL(  rset zstring )
      else
        CU_PASS(  rset zstring )
      end if
      next i



      if rset_(s, 0) <> "" then    
        CU_FAIL(  rset 0 string )
      else
        CU_PASS(  rset 0 string )
      end if


      if rset_(s, 25) <> right(space(25) + s, 25) then    
        CU_FAIL(  rset 25 string )
      else
        CU_PASS(  rset 25 string )
      end if


      for i = 1 to 80
      if rset_(s, i) <> right(space(i) + s, i) then    
        CU_FAIL(  rset string )
      else
        CU_PASS(  rset string )
      end if
      next i



      for i = 1 to 80
      if Rset_(s, i, "x") <> right(string(i, asc("x")) + s, i) then    
        CU_FAIL(  rset string )
      else
        CU_PASS(  rset string )
      end if
      next i



do_wide_only:


      if rset_(w, 0) <> "" then    
        CU_FAIL(  rset 0 wstring )
      else
        CU_PASS(  rset 0 wstring )
      end if


      if rset_(w, 25) <> right(space(25) + w, 25) then    
        CU_FAIL(  rset 25 wstring )
      else
        CU_PASS(  rset 25 wstring )
      end if


      for i = 1 to 80
      if rset_(w, i) <> right(space(i) + w, i) then    
        CU_FAIL(  rset wstring )
      else
        CU_PASS(  rset wstring )
      end if
      next i



      for i = 1 to 80
      if Rset_(w, i, "x") <> right(string(i, asc("x")) + w, i) then    
        CU_FAIL(  rset wstring )
      else
        CU_PASS(  rset wstring )
      end if
      next i



      if rset_(u, 0) <> "" then    
        CU_FAIL(  rset 0 ustring )
      else
        CU_PASS(  rset 0 ustring )
      end if


      if rset_(u, 25) <> right(space(25) + u, 25) then    
        CU_FAIL(  rset 25 ustring )
      else
        CU_PASS(  rset 25 ustring )
      end if


      for i = 1 to 80
      if rset_(u, i) <> right(space(i) + u, i) then    
        CU_FAIL(  rset ustring )
      else
        CU_PASS(  rset ustring )
      end if
      next i



      for i = 1 to 80
      if Rset_(u, i, "x") <> right(string(i, asc("x")) + u, i) then    
        CU_FAIL(  rset ustring )
      else
        CU_PASS(  rset ustring )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_rset_ )
dim y  as wstring * 128


  TEST ( rset_1 )
    y = "1234567890 + abcdefghij"
    test_rset_(y, 1, 0)
  END_TEST

  TEST ( rset_2 )
    y = "1234567890 + abcdefghij"
    test_rset_(y+y, 2, 0)
  END_TEST

  TEST ( rset_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_rset_(y, 1, 0)
  END_TEST

  TEST ( rset_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_rset_(y+y, 2, 0)
  END_TEST

  TEST ( rset_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_rset_(y, 1, 1)
  END_TEST

  TEST ( rset_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_rset_(y+y, 2, 1)
  END_TEST


END_SUITE
