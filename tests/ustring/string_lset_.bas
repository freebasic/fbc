#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_lset_(y, cc, uflag)
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


      if lset_(z, 0) <> "" then    
        CU_FAIL(  lset 0 zstring )
      else
        CU_PASS(  lset 0 zstring )
      end if


      if lset_(z, 25) <> left(z + space(25), 25) then    
        CU_FAIL(  lset 25 zstring )
      else
        CU_PASS(  lset 25 zstring )
      end if


      for i = 1 to 80
      if lset_(z, i) <> left(z + space(i), i) then    
        CU_FAIL(  lset zstring )
      else
        CU_PASS(  lset zstring )
      end if
      next i



      for i = 1 to 80
      if lset_(z, i, "x") <> left(z + string(i, asc("x")), i) then    
        CU_FAIL(  lset zstring )
      else
        CU_PASS(  lset zstring )
      end if
      next i



      if lset_(s, 0) <> "" then    
        CU_FAIL(  lset 0 string )
      else
        CU_PASS(  lset 0 string )
      end if


      if lset_(s, 25) <> left(s + space(25), 25) then    
        CU_FAIL(  lset 25 string )
      else
        CU_PASS(  lset 25 string )
      end if


      for i = 1 to 80
      if lset_(s, i) <> left(s + space(i), i) then    
        CU_FAIL(  lset string )
      else
        CU_PASS(  lset string )
      end if
      next i



      for i = 1 to 80
      if lset_(s, i, "x") <> left(s + string(i, asc("x")), i) then    
        CU_FAIL(  lset string )
      else
        CU_PASS(  lset string )
      end if
      next i



do_wide_only:


      if lset_(w, 0) <> "" then    
        CU_FAIL(  lset 0 wstring )
      else
        CU_PASS(  lset 0 wstring )
      end if


      if lset_(w, 25) <> left(w + space(25), 25) then    
        CU_FAIL(  lset 25 wstring )
      else
        CU_PASS(  lset 25 wstring )
      end if


      for i = 1 to 80
      if lset_(w, i) <> left(w + space(i), i) then    
        CU_FAIL(  lset wstring )
      else
        CU_PASS(  lset wstring )
      end if
      next i



      for i = 1 to 80
      if lset_(w, i, "x") <> left(w + string(i, asc("x")), i) then    
        CU_FAIL(  lset wstring )
      else
        CU_PASS(  lset wstring )
      end if
      next i



      if lset_(u, 0) <> "" then    
        CU_FAIL(  lset 0 ustring )
      else
        CU_PASS(  lset 0 ustring )
      end if


      if lset_(u, 25) <> left(u + space(25), 25) then    
        CU_FAIL(  lset 25 ustring )
      else
        CU_PASS(  lset 25 ustring )
      end if


      for i = 1 to 80
      if lset_(u, i) <> left(u + space(i), i) then    
        CU_FAIL(  lset ustring )
      else
        CU_PASS(  lset ustring )
      end if
      next i



      for i = 1 to 80
      if lset_(u, i, "x") <> left(u + string(i, asc("x")), i) then    
        CU_FAIL(  lset ustring )
      else
        CU_PASS(  lset ustring )
      end if
      next i



end scope
#endmacro


SUITE( fbc_tests.ustring_.string_lset_ )
dim y  as wstring * 128


  TEST ( lset_1 )
    y = "1234567890 + abcdefghij"
    test_lset_(y, 1, 0)
  END_TEST

  TEST ( lset_2 )
    y = "1234567890 + abcdefghij"
    test_lset_(y+y, 2, 0)
  END_TEST

  TEST ( lset_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_lset_(y, 1, 0)
  END_TEST

  TEST ( lset_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_lset_(y+y, 2, 0)
  END_TEST

  TEST ( lset_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_lset_(y, 1, 1)
  END_TEST

  TEST ( lset_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_lset_(y+y, 2, 1)
  END_TEST


END_SUITE
