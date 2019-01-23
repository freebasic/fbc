#include "fbcunit.bi"
#include "ustring.bi"
#include "stringex.bi"
#include once "string.bi"
#include once "utf_conv.bi


#macro test_pathname_(y, cc, uflag)
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


  z = "c:\test test test\very_strange name.asdf.txt"
  s = "c:\test test test\very_strange name.asdf.txt"
  w = "c:\test test test\very_strange name.asdf.txt"
  u = "c:\test test test\very_strange name.asdf.txt"


      if pathname_(path, z) <> "c:\test test test\" then    
        CU_FAIL(  pathname name zstring )
      else
        CU_PASS(  pathname name zstring )
      end if


      if pathname_(name, z) <> "very_strange name.asdf" then    
        CU_FAIL(  pathname name zstring )
      else
        CU_PASS(  pathname name zstring )
      end if


      if pathname_(namex, z) <> "very_strange name.asdf.txt" then    
        CU_FAIL(  pathname name + extension zstring )
      else
        CU_PASS(  pathname name + extension zstring )
      end if


      if pathname_(extn, z) <> ".txt" then    
        CU_FAIL(  pathname extension zstring )
      else
        CU_PASS(  pathname extension zstring )
      end if


      if pathname_(path, s) <> "c:\test test test\" then    
        CU_FAIL(  pathname name string )
      else
        CU_PASS(  pathname name string )
      end if


      if pathname_(name, s) <> "very_strange name.asdf" then    
        CU_FAIL(  pathname name string )
      else
        CU_PASS(  pathname name string )
      end if


      if pathname_(namex, s) <> "very_strange name.asdf.txt" then    
        CU_FAIL(  pathname name + extension string )
      else
        CU_PASS(  pathname name + extension string )
      end if


      if pathname_(extn, s) <> ".txt" then    
        CU_FAIL(  pathname extension string )
      else
        CU_PASS(  pathname extension string )
      end if


      if pathname_(path, w) <> "c:\test test test\" then    
        CU_FAIL(  pathname name wstring )
      else
        CU_PASS(  pathname name wstring )
      end if


      if pathname_(name, w) <> "very_strange name.asdf" then    
        CU_FAIL(  pathname name wstring )
      else
        CU_PASS(  pathname name wstring )
      end if


      if pathname_(namex, w) <> "very_strange name.asdf.txt" then    
        CU_FAIL(  pathname name + extension wstring )
      else
        CU_PASS(  pathname name + extension wstring )
      end if


      if pathname_(extn, w) <> ".txt" then    
        CU_FAIL(  pathname extension wstring )
      else
        CU_PASS(  pathname extension wstring )
      end if


      if pathname_(path, u) <> "c:\test test test\" then    
        CU_FAIL(  pathname name ustring )
      else
        CU_PASS(  pathname name ustring )
      end if


      if pathname_(name, u) <> "very_strange name.asdf" then    
        CU_FAIL(  pathname name ustring )
      else
        CU_PASS(  pathname name ustring )
      end if


      if pathname_(namex, u) <> "very_strange name.asdf.txt" then    
        CU_FAIL(  pathname name + extension ustring )
      else
        CU_PASS(  pathname name + extension ustring )
      end if


      if pathname_(extn, u) <> ".txt" then    
        CU_FAIL(  pathname extension ustring )
      else
        CU_PASS(  pathname extension ustring )
      end if


end scope
#endmacro


SUITE( fbc_tests.ustring_.string_pathname_ )
dim y  as wstring * 128


  TEST ( pathname__1 )
    y = "0"
    test_pathname_(y, 0, 0)
  END_TEST


END_SUITE
