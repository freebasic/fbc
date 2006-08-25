# include "fbcu.bi"

# if __FB_LANG__ = deprecated

namespace fbc_tests.scopes.impl_exp

sub test_1 cdecl ()
	a = 1 
	scope 
	  dim a 
	  b = 7 
	  scope 
	    dim b 
	    scope 
	      c = 11 
	      scope 
	        a = 5 
	        b = 3 
	        CU_ASSERT_EQUAL(a, 5) 
	        CU_ASSERT_EQUAL(b, 3) 
	        CU_ASSERT_EQUAL(c, 11) 
	      end scope 
	      CU_ASSERT_EQUAL(a, 5) 
	      CU_ASSERT_EQUAL(b, 3) 
	      CU_ASSERT_EQUAL(c, 11) 
	    end scope 
	    CU_ASSERT_EQUAL(a, 5) 
	    CU_ASSERT_EQUAL(b, 3) 
	    '' c = c '' quiet implicit var warning 
	    CU_ASSERT_EQUAL(c, 0) 
	  end scope 
	  CU_ASSERT_EQUAL(a, 5) 
	  CU_ASSERT_EQUAL(b, 7) 
	  '' c = c '' quiet implicit var warning 
	  CU_ASSERT_EQUAL(c, 0) 
	end scope 
	CU_ASSERT_EQUAL( a, 1) 
	'' b = b '' quiet implicit var warning 
	CU_ASSERT_EQUAL(b, 0) 
	'' c = c '' quiet implicit var warning 
	CU_ASSERT_EQUAL(c, 0) 
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.scopes.imp_exp")
	fbcu.add_test("test 1", @test_1)

end sub

end namespace

# endif
