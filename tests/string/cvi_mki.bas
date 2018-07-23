#include "fbcunit.bi"

SUITE( fbc_tests.string_.cvi_mki )

	const as double  cv_d  = 1.646488698019057e+098
	const as single  cv_s  = 3.629605e+012         
	const as long    cv_l  = 1414743380            
	const as short   cv_sh = 17748                 
	const as longint cv_li = 6076276550747243860   
	#ifdef __FB_64BIT__
		const as integer cv_i = cv_li
	#else
		const as integer cv_i = cv_l
	#endif

	TEST( CVX )

		dim as double d = cvd("TESTTEST")
		dim as single s = cvs("TESTTEST")
		CU_ASSERT_DOUBLE_EQUAL( cv_d, d, cv_d / 1e15 )
		CU_ASSERT_DOUBLE_EQUAL( cv_s, s, cv_s / 1e7  )

		CU_ASSERT_EQUAL( cv_i , cvi      ("TESTTEST") )
		CU_ASSERT_EQUAL( cv_l , cvl      ("TESTTEST") )
		CU_ASSERT_EQUAL( cv_sh, cvshort  ("TESTTEST") )
		CU_ASSERT_EQUAL( cv_li, cvlongint("TESTTEST") )

#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( mki      (cv_i ), "TESTTEST" )
#else
		CU_ASSERT_EQUAL( mki      (cv_i ), "TEST" )
#endif
		CU_ASSERT_EQUAL( mkl      (cv_l ), "TEST" )
		CU_ASSERT_EQUAL( mkshort  (cv_sh), "TE" )
		CU_ASSERT_EQUAL( mklongint(cv_li), "TESTTEST" )

	END_TEST

	const as double  m_d  = 10000
	const as integer m_i  = 10000
	const as long    m_l  = 10000
	const as longint m_li = 10000

	TEST( MKX )
	
		dim as string mkd_d, mkd_i, mkd_l, mkd_li
		dim as string mks_d, mks_i, mks_l, mks_li
		dim as string mki_d, mki_i, mki_l, mki_li
		dim as string mkl_d, mkl_i, mkl_l, mkl_li
		dim as string mkshort_d, mkshort_i, mkshort_l, mkshort_li
		dim as string mklongint_d, mklongint_i, mklongint_l, mklongint_li
		
		#macro doMKX(token)
			token##_d  = token(m_d)
			token##_i  = token(m_i)
			token##_l  = token(m_l)
			token##_li = token(m_li)
		#endmacro
		
		doMKX(mkd)
		doMKX(mks)
		doMKX(mki)
		doMKX(mkl)
		doMKX(mkshort)
		doMKX(mklongint)
		
		#macro testMKX(token)
			CU_ASSERT_EQUAL( token##_d , token( 10000.0              ) )
			CU_ASSERT_EQUAL( token##_i , token( 10000                ) )
			CU_ASSERT_EQUAL( token##_l , token( cast(long, 10000)    ) )
			CU_ASSERT_EQUAL( token##_li, token( cast(longint, 10000) ) )
		#endmacro
		
		testMKX(mkd)
		testMKX(mks)
		testMKX(mki)
		testMKX(mkl)
		testMKX(mkshort)
		testMKX(mklongint)
		
	END_TEST

END_SUITE
