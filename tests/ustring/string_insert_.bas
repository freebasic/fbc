#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_insert_(y, cc, uflag)
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


      if insert_(z, "", 5) <>  z then
        CU_FAIL(  Insert zstring nothing )
      else
        CU_PASS(  Insert zstring nothing )
      end if


      if insert_(z, "q", 1) <>  "q" + z then
        CU_FAIL(  Insert zstring start )
      else
        CU_PASS(  Insert zstring start )
      end if


      if insert_(z, "q", len(z) + 1) <>  z + "q" then
        CU_FAIL(  Insert zstring end )
      else
        CU_PASS(  Insert zstring end )
      end if


      if insert_(z, left(z, 3), 5) <>  MID(z, 1, 4) + left(z, 3) + MID(z, 5) then
        CU_FAIL(  Insert zstring )
      else
        CU_PASS(  Insert zstring )
      end if


      if insert_(s, left(s, 3), 5) <>  MID(s, 1, 4) + left(s, 3) + MID(s, 5) then
        CU_FAIL(  Insert string )
      else
        CU_PASS(  Insert string )
      end if


do_wide_only:


      if insert_(w, left(w, 3), 5) <>  MID(w, 1, 4) + left(w, 3) + MID(w, 5) then
        CU_FAIL(  Insert wstring )
      else
        CU_PASS(  Insert wstring )
      end if


      if insert_(u, left(u, 3), 5) <>  MID(u, 1, 4) + left(u, 3) + MID(u, 5) then
        CU_FAIL(  Insert ustring )
      else
        CU_PASS(  Insert ustring )
      end if


end scope
#endmacro


SUITE( fbc_tests.ustring_.string_insert_ )
dim y  as wstring * 128


  TEST ( insert_1 )
    y = "1234567890 + abcdefghij"
    test_insert_(y, 1, 0)
  END_TEST

  TEST ( insert_2 )
    y = "1234567890 + abcdefghij"
    test_insert_(y+y, 2, 0)
  END_TEST

  TEST ( insert_3 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_insert_(y, 1, 0)
  END_TEST

  TEST ( insert_4 )
    y = "aAbBcCdDeE + vVwWxXyYzZ"
    test_insert_(y+y, 2, 0)
  END_TEST

  TEST ( insert_5 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_insert_(y, 1, 1)
  END_TEST

  TEST ( insert_6 )
    dim chars as integer
    dim utf8 as zstring * 128
    utf8 = "фФиИсСвВуУаА + мМцЦчЧяЯнН"
    dim as wstring ptr wp = UTFToWChar( UTF_ENCOD_UTF8, @utf8, 0, @chars )
    y = *wp
    test_insert_(y+y, 2, 1)
  END_TEST


END_SUITE
