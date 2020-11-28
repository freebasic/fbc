#ifndef __FBCUNIT_BI_INCLUDE__
#define __FBCUNIT_BI_INCLUDE__ 1

''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''  License: GNU Lesser General Public License 
''           version 2.1 (or any later version) plus
''           linking exception, see license.txt

/'---------------------------------------------------------
| fbcunit - FreeBASIC Compiler Unit testing module        |
---------------------------------------------------------'/

#define FBCU_VER_MAJOR 1
#define FBCU_VER_MINOR 0

#inclib "fbcunit"

/'------------------------------------
| compile time configuration options |
------------------------------------'/

#if not defined(FBCU_ENABLE_MACROS)
	/'
	Enable the helper macros by default.  To disable the
	helper macros, FBCU_ENABLE_MACROS must be defined to
	0 before including this file.
	'/
	#define FBCU_ENABLE_MACROS 1
#endif

#if not defined(FBCU_ENABLE_CHECKS)
	/'
	Enable the name collision checks by default.  To disable
	the checks, FBCU_ENABLE_CHECKS must be defined to 0
	before including this file.
	'/
	#define FBCU_ENABLE_CHECKS 1
#endif

#if not defined(FBCU_ENABLE_TRACE)
	/'
	Disable helper macro tracing by default.  To enable
	tracing, FBCU_ENABLE_TRACE must be defined to any
	integer other than 0 before including this file.
	'/
	#define FBCU_ENABLE_TRACE 0
#endif


/'---------------------------
| test for reserved symbols |
---------------------------'/
''
#if ((FBCU_ENABLE_MACROS<>0) andalso (FBCU_ENABLE_CHECKS<>0))

#if defined(TMP_FBCUNIT_SUITE_NAME)
	#error "TMP_FBCUNIT_SUITE_NAME" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_TEST_GROUP_NAME)
	#error "TMP_FBCUNIT_TEST_GROUP_NAME" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_TEST_NAME)
	#error "TMP_FBCUNIT_TEST_NAME" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_IN_INIT)
	#error "TMP_FBCUNIT_SUITE_IN_INIT" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_HAVE_INIT)
	#error "TMP_FBCUNIT_SUITE_HAVE_INIT" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_IN_CLEANUP)
	#error "TMP_FBCUNIT_SUITE_IN_CLEANUP" symbol is reserved for fbcunit
#endif
#if defined(TMP_FBCUNIT_SUITE_HAVE_CLEANUP)
	#error "TMP_FBCUNIT_SUITE_HAVE_CLEANUP" symbol is reserved for fbcunit
#endif
#if defined(SUITE)
	#error "SUITE" symbol is reserved for fbcunit
#endif
#if defined(SUITE_EMIT)
	#error "SUITE_EMIT" symbol is reserved for fbcunit
#endif
#if defined(END_SUITE)
	#error "END_SUITE" symbol is reserved for fbcunit
#endif
#if defined(END_SUITE_EMIT)
	#error "END_SUITE_EMIT" symbol is reserved for fbcunit
#endif
#if defined(SUITE_INIT)
	#error "SUITE_INIT" symbol is reserved for fbcunit
#endif
#if defined(SUITE_INIT_EMIT)
	#error "SUITE_INIT_EMIT" symbol is reserved for fbcunit
#endif
#if defined(END_SUITE_INIT)
	#error "END_SUITE_INIT" symbol is reserved for fbcunit
#endif
#if defined(SUITE_CLEANUP)
	#error "SUITE_CLEANUP" symbol is reserved for fbcunit
#endif
#if defined(SUITE_CLEANUP_EMIT)
	#error "SUITE_CLEANUP_EMIT" symbol is reserved for fbcunit
#endif
#if defined(END_SUITE_CLEANUP)
	#error "END_SUITE_CLEANUP" symbol is reserved for fbcunit
#endif
#if defined(TEST)
	#error "TEST" symbol is reserved for fbcunit
#endif
#if defined(TEST_EMIT)
	#error "TEST_EMIT" symbol is reserved for fbcunit
#endif
#if defined(END_TEST)
	#error "END_TEST" symbol is reserved for fbcunit
#endif
#if defined(END_TEST_EMIT)
	#error "END_TEST_EMIT" symbol is reserved for fbcunit
#endif
#if defined(TEST_GROUP)
	#error "TEST_GROUP" symbol is reserved for fbcunit
#endif
#if defined(TEST_GROUP_EMIT)
	#error "TEST_GROUP_EMIT" symbol is reserved for fbcunit
#endif
#if defined(END_TEST_GROUP)
	#error "END_TEST_GROUP" symbol is reserved for fbcunit
#endif
#if defined(END_TEST_GROUP_EMIT)
	#error "END_TEST_GROUP_EMIT" symbol is reserved for fbcunit
#endif
#if defined(FBCU_TRACE)
	#error "FBCU_TRACE" symbol is reserved for fbcunit
#endif

#endif '' ((FBCU_ENABLE_MACROS<>0) and (FBCU_ENABLE_CHECKS<>0))

/'--------------------------
| fbcunit assertion macros |
--------------------------'/

#ifndef FBCU_NULL
#define FBCU_NULL 0
#endif

#if( __FB_LANG__ = "qb" )
	#ifndef false
		const false = 0
	#endif
	#ifndef true
		const true = not false
	#endif
#endif

#define CU_ASSERT( a )               fbcu.CU_ASSERT_( (a), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT(" #a ")" )
#define CU_ASSERT_EQUAL( a, b )      fbcu.CU_ASSERT_( ((a)=(b)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_EQUAL(" #a "," #b ")" )
#define CU_ASSERT_NOT_EQUAL( a, b )  fbcu.CU_ASSERT_( ((a)<>(b)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_NOT_EQUAL(" #a "," #b ")" )
#define CU_ASSERT_TRUE( a )          fbcu.CU_ASSERT_( (a)<>false, __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_TRUE(" #a ")" )
#define CU_ASSERT_FALSE( a )         fbcu.CU_ASSERT_( (a)=false, __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_FALSE(" #a ")" )
#define CU_FAIL( a )                 fbcu.CU_ASSERT_( false, __FILE__, __LINE__, __FUNCTION__, "CU_FAIL(" #a ")" )
#define CU_FAIL_FATAL( a )           fbcu.CU_ASSERT_FATAL_( false, __FILE__, __LINE__, __FUNCTION__, "CU_FAIL_FATAL(" #a ")" )
#define CU_PASS( a )                 fbcu.CU_ASSERT_( true , __FILE__, __LINE__, __FUNCTION__, "CU_PASS(" #a ")" )
#define CU_ASSERT_DOUBLE_EXACT( a, e )     fbcu.CU_ASSERT_( (cdbl(a) = cdbl(e)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_DOUBLE_EXACT(" #a "," #e ")" )
#define CU_ASSERT_DOUBLE_EQUAL( a, e, g )  fbcu.CU_ASSERT_( (abs(cdbl(a)-cdbl(e)) <= abs(cdbl(g))), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_DOUBLE_EQUAL(" #a "," #e "," #g ")" )
#if( __FB_LANG__ = "qb" )
#define CU_ASSERT_DOUBLE_APPROX( a, e, u ) fbcu.CU_ASSERT_( fbcu.dblApprox(cdbl(a), cdbl(e), __clngint(u)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_DOUBLE_APPROX(" #a "," #e "," #u ")" )
#else
#define CU_ASSERT_DOUBLE_APPROX( a, e, u ) fbcu.CU_ASSERT_( fbcu.dblApprox(cdbl(a), cdbl(e), clngint(u)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_DOUBLE_APPROX(" #a "," #e "," #u ")" )
#endif
#define CU_ASSERT_SINGLE_EXACT( a, e )     fbcu.CU_ASSERT_( (csng(a) = csng(e)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_SINGLE_EXACT(" #a "," #e ")" )
#define CU_ASSERT_SINGLE_EQUAL( a, e, g )  fbcu.CU_ASSERT_( (abs(csng(a)-csng(e)) <= abs(csng(g))), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_SINGLE_EQUAL(" #a "," #e "," #g ")" )
#define CU_ASSERT_SINGLE_APPROX( a, e, u ) fbcu.CU_ASSERT_( fbcu.sngApprox(csng(a), csng(e), clng(u)), __FILE__, __LINE__, __FUNCTION__, "CU_ASSERT_SINGLE_APPROX(" #a "," #e "," #u ")" )

#define CU_PRINT( s ) fbcu.outputConsoleString( s )

/'-----------------------------
| fbcunit code emitter macros |
-----------------------------'/

#if (FBCU_ENABLE_MACROS<>0)

	#if (FBCU_ENABLE_TRACE<>0)
		#define FBCU_TRACE(msg_) #print FBCU TRACE: msg_
	#else
		#define FBCU_TRACE(msg_)
	#endif

	#if( __FB_LANG__ = "qb" )

		#macro SUITE_EMIT( suite_name )
			FBCU_TRACE( "SUITE" suite_name )
		#endmacro

		#macro END_SUITE_EMIT( suite_name, id )
			__private sub tests.##suite_name##_ctor##id cdecl () __constructor
				#if (defined( TMP_FBCUNIT_SUITE_HAVE_INIT ) andalso defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP ))
					fbcu.add_suite( #suite_name, __procptr(tests.##suite_name##.init), __procptr(tests.##suite_name##.cleanup) )
				#elseif defined( TMP_FBCUNIT_SUITE_HAVE_INIT )
					fbcu.add_suite( #suite_name, __procptr(tests.##suite_name##.init), FBCU_NULL )
				#elseif defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP )
					fbcu.add_suite( #suite_name, FBCU_NULL, __procptr(tests.##suite_name##.cleanup) )
				#else
					fbcu.add_suite( #suite_name, FBCU_NULL, FBCU_NULL )
				#endif
			end sub
			FBCU_TRACE( "END_SUITE" suite_name )
		#endmacro

		#macro SUITE_INIT_EMIT( suite_name )
			function tests.##suite_name##.init cdecl () as long
			FBCU_TRACE( "SUITE_INIT" )
		#endmacro

		#macro END_SUITE_INIT_EMIT()
			end function
			FBCU_TRACE( "END_SUITE_INIT" )
		#endmacro

		#macro SUITE_CLEANUP_EMIT( suite_name )
			function tests.##suite_name##.cleanup cdecl () as long
			FBCU_TRACE( "SUITE_CLEANUP" )
		#endmacro

		#macro END_SUITE_CLEANUP_EMIT()
			end function
			FBCU_TRACE( "END_SUITE_CLEANUP" )
		#endmacro

		#macro TEST_GROUP_EMIT( group_name )
			#error FBCUNIT: not allowed "TEST_GROUP"
		#endmacro

		#macro END_TEST_GROUP_EMIT( group_name )
			#error FBCUNIT: not allowed "END_TEST_GROUP"
		#endmacro

		#macro TEST_EMIT( suite_name, test_name )
			sub tests.##suite_name##.##test_name cdecl ()
			FBCU_TRACE( "TEST" tests.fbcu_global.##test_name )
		#endmacro

		#macro END_TEST_EMIT( suite_name, group_name, test_name, global )
			end sub
			__private sub tests.##suite_name##.##test_name##_ctor cdecl () __constructor
				fbcu.add_test( #suite_name, #test_name, __procptr(tests.##suite_name##.##test_name), global )
			end sub
			FBCU_TRACE( "END_TEST" test_name )
		#endmacro

	#else '' ( __FB_LANG__ <> "qb" )

		#macro SUITE_EMIT( suite_name )
			namespace tests.##suite_name
			FBCU_TRACE( "SUITE" suite_name )
		#endmacro

		#macro END_SUITE_EMIT( suite_name, id )
				private sub suite_ctor##id cdecl () constructor
					#if (defined( TMP_FBCUNIT_SUITE_HAVE_INIT ) andalso defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP ))
						fbcu.add_suite( #suite_name, procptr(tests.##suite_name##.init), procptr(tests.##suite_name##.cleanup) )
					#elseif defined( TMP_FBCUNIT_SUITE_HAVE_INIT )
						fbcu.add_suite( #suite_name, procptr(tests.##suite_name##.init), FBCU_NULL )
					#elseif defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP )
						fbcu.add_suite( #suite_name, FBCU_NULL, procptr(tests.##suite_name##.cleanup) )
					#else
						fbcu.add_suite( #suite_name, FBCU_NULL, FBCU_NULL )
					#endif
				end sub
			end namespace
			FBCU_TRACE( "END_SUITE" suite_name )
		#endmacro

		#macro SUITE_INIT_EMIT( suite_name )
				function init cdecl () as long
			FBCU_TRACE( "SUITE_INIT" )
		#endmacro

		#macro END_SUITE_INIT_EMIT()
				end function
			FBCU_TRACE( "END_SUITE_INIT" )
		#endmacro

		#macro SUITE_CLEANUP_EMIT( suite_name )
				function cleanup cdecl () as long
			FBCU_TRACE( "SUITE_CLEANUP" )
		#endmacro

		#macro END_SUITE_CLEANUP_EMIT()
				end function
			FBCU_TRACE( "END_SUITE_CLEANUP" )
		#endmacro

		#macro TEST_GROUP_EMIT( group_name )
			namespace group_name
			FBCU_TRACE( "TEST_GROUP" )
		#endmacro

		#macro END_TEST_GROUP_EMIT( group_name )
			end namespace
			FBCU_TRACE( "END_TEST_GROUP" suite_name )
		#endmacro

		#macro TEST_EMIT( suite_name, test_name )
				sub test_name cdecl ()
			FBCU_TRACE( "TEST" test_name )
		#endmacro

		#macro END_TEST_EMIT( suite_name, group_name, test_name, global )
				end sub
				private sub test_name##_ctor cdecl () constructor
				#if #group_name > ""
					fbcu.add_test( #suite_name, #group_name + "." + #test_name, procptr(test_name), global )
				#else
					fbcu.add_test( #suite_name, #test_name, procptr(test_name), global )
				#endif
				end sub
			FBCU_TRACE( "END_TEST" test_name )
		#endmacro

	#endif '' ( __FB_LANG__ <> "qb" )

#endif '' (FBCU_ENABLE_MACROS<>0)


/'-----------------------
| fbcunit helper macros |
-----------------------'/

#if (FBCU_ENABLE_MACROS<>0)

#macro SUITE( suite_name )
	#if defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: test suites can not be nested, or missing "END_SUITE" before "SUITE"
	#endif
	#if #suite_name > ""
		#define TMP_FBCUNIT_SUITE_NAME suite_name
	#else
		#define TMP_FBCUNIT_SUITE_NAME fbcu_global
	#endif
	SUITE_EMIT( TMP_FBCUNIT_SUITE_NAME )
#endmacro

#macro END_SUITE
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "END_SUITE"
	#elseif defined( TMP_FBCUNIT_TEST_GROUP_NAME )
		#error FBCUNIT: missing "END_TEST_GROUP" before "END_SUITE"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "END_SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "END_SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "END_SUITE"
	#endif

	#if defined( TMP_FBCUNIT_SUITE_NAME )
		END_SUITE_EMIT( TMP_FBCUNIT_SUITE_NAME, __LINE__ )
	#else
		#error FBCUNIT: mismatched "END_SUITE"
	#endif

	#undef TMP_FBCUNIT_SUITE_NAME
	#undef TMP_FBCUNIT_SUITE_IN_INIT
	#undef TMP_FBCUNIT_SUITE_HAVE_INIT
	#undef TMP_FBCUNIT_SUITE_IN_CLEANUP
	#undef TMP_FBCUNIT_SUITE_HAVE_CLEANUP

#endmacro

#macro SUITE_INIT
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: "SUITE_INIT" can only be used once per "SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_HAVE_INIT )
		#error FBCUNIT: "SUITE_INIT" can only be used once per "SUITE"
	#endif
	#define TMP_FBCUNIT_SUITE_HAVE_INIT
	#define TMP_FBCUNIT_SUITE_IN_INIT
	SUITE_INIT_EMIT( TMP_FBCUNIT_SUITE_NAME )
#endmacro

#macro END_SUITE_INIT
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "END_SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "END_SUITE_INIT"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: mismatched END_SUITE_INIT
	#endif
	END_SUITE_INIT_EMIT()
	#undef TMP_FBCUNIT_SUITE_IN_INIT
#endmacro

#macro SUITE_CLEANUP
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: "SUITE_CLEANUP" can only be used once per "SUITE"
	#elseif defined( TMP_FBCUNIT_SUITE_HAVE_CLEANUP )
		#error FBCUNIT: "SUITE_CLEANUP" can only be used once per "SUITE"
	#endif
	#define TMP_FBCUNIT_SUITE_HAVE_CLEANUP
	#define TMP_FBCUNIT_SUITE_IN_CLEANUP
	SUITE_CLEANUP_EMIT( TMP_FBCUNIT_SUITE_NAME )
#endmacro

#macro END_SUITE_CLEANUP
	#if not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: unexpected "END_SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: missing "END_TEST" before "END_SUITE_CLEANUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: mismatched "END_SUITE_CLEANUP"
	#endif
	END_SUITE_INIT_EMIT()
	#undef TMP_FBCUNIT_SUITE_IN_CLEANUP
#endmacro

#macro TEST_GROUP( group_name )
	#if defined( TMP_FBCUNIT_TEST_GROUP_NAME )
		#error FBCUNIT: test groups can not be nested or missing "END_TEST_GROUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "TEST_GROUP"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "TEST_GROUP"
	#elseif not defined( TMP_FBCUNIT_SUITE_NAME )
		#error FBCUNIT: "TEST_GROUP" can only be used in a "SUITE"
	#endif
	#if #group_name > ""
		#define TMP_FBCUNIT_TEST_GROUP_NAME group_name
	#else
		#error FBCUNIT: missing group name in "TEST_GROUP"
	#endif
	TEST_GROUP_EMIT( group_name )
#endmacro

#macro END_TEST_GROUP
	#if defined( TMP_FBCUNIT_TEST_GROUP_NAME )
		END_TEST_GROUP_EMIT( TMP_FBCUNIT_TEST_GROUP_NAME )
	#else
		#error FBCUNIT: mismatched "END_TEST_GROUP"
	#endif
	#undef TMP_FBCUNIT_TEST_GROUP_NAME
#endmacro

#macro TEST( test_name )
	#if defined( TMP_FBCUNIT_TEST_NAME )
		#error FBCUNIT: tests can not be nested or missing "END_TEST"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_INIT )
		#error FBCUNIT: missing "END_SUITE_INIT" before "TEST"
	#elseif defined( TMP_FBCUNIT_SUITE_IN_CLEANUP )
		#error FBCUNIT: missing "END_SUITE_CLEANUP" before "TEST"
	#endif
	#if #test_name > ""
		#define TMP_FBCUNIT_TEST_NAME test_name
	#else
		#define TMP_FBCUNIT_TEST_NAME default
	#endif
	#if defined( TMP_FBCUNIT_SUITE_NAME )
		TEST_EMIT( TMP_FBCUNIT_SUITE_NAME, TMP_FBCUNIT_TEST_NAME )
	#else
		TEST_EMIT( fbcu_global, TMP_FBCUNIT_TEST_NAME )
	#endif
#endmacro

#macro END_TEST
	#if defined( TMP_FBCUNIT_TEST_NAME )
		#if defined( TMP_FBCUNIT_SUITE_NAME )
			#if defined( TMP_FBCUNIT_TEST_GROUP_NAME )
			END_TEST_EMIT( TMP_FBCUNIT_SUITE_NAME, TMP_FBCUNIT_TEST_GROUP_NAME, TMP_FBCUNIT_TEST_NAME, false )
			#else
			END_TEST_EMIT( TMP_FBCUNIT_SUITE_NAME, , TMP_FBCUNIT_TEST_NAME, false )
			#endif
		#else
			#if defined( TMP_FBCUNIT_TEST_GROUP_NAME )
			END_TEST_EMIT( fbcu_global, TMP_FBCUNIT_TEST_GROUP_NAME, TMP_FBCUNIT_TEST_NAME, true )
			#else
			END_TEST_EMIT( fbcu_global, , TMP_FBCUNIT_TEST_NAME, true )
			#endif
		#endif
	#else
		#error FBCUNIT: mismatched "END_TEST"
	#endif
	#undef TMP_FBCUNIT_TEST_NAME
#endmacro

#endif '' (FBCU_ENABLE_MACROS<>0)


/'--------------------------
| fbcunit api for -lang qb |
--------------------------'/

#if( __FB_LANG__ = "qb" )

	declare function fbcu.find_suite alias "fbcu_find_suite_qb" _
		( _
			byval suite_name as __zstring __ptr = FBCU_NULL _
		) as long

	declare sub fbcu.add_suite alias "fbcu_add_suite_qb" _
		( _
			byval suite_name as __zstring __ptr = FBCU_NULL, _
			byval init_proc as function cdecl ( ) as long = FBCU_NULL, _
			byval term_proc as function cdecl ( ) as long = FBCU_NULL _
		)

	declare function fbcu.get_suite_name alias "fbcu_get_suite_name_qb" _
		( _
		) as const __zstring __ptr

	declare sub fbcu.add_test alias "fbcu_add_test_qb" _
		( _
			byval suite_name as __zstring __ptr = FBCU_NULL, _
			byval test_name as __zstring __ptr = FBCU_NULL, _
			byval test_proc as sub cdecl ( ) = FBCU_NULL, _
			byval is_global as __boolean = __false _
		)

	declare function fbcu.check_internal_state alias "fbcu_check_internal_state_qb" _
		( _
		) as __boolean

	declare function fbcu.write_report_xml alias "fbcu_write_report_xml_qb" _
		( _
			byval filename as const __zstring __ptr _
		) as __boolean

	declare sub fbcu.setBriefSummary alias "fbcu_setBriefSummary_qb" _
		( _
			byval briefSummary as __boolean _
		)

	declare sub fbcu.setHideCases alias "fbcu_setHideCases_qb" _
		( _
			byval hideCases as __boolean _
		)

	declare function fbcu.getHideCases alias "fbcu_getHideCases_qb" _
		( _
		) as __boolean

	declare sub fbcu.setShowConsole alias "fbcu_setShowConsole_qb" _
		( _
			byval showConsole as __boolean _
		)

	declare function fbcu.getShowConsole alias "fbcu_getShowConsole_qb" _
		( _
		) as __boolean

	declare sub fbcu.outputConsoleString alias "fbcu_outputConsoleString_qb" _
		( _
			byref s as const string = "" _
		)

	declare function fbcu.run_tests alias "fbcu_run_tests_qb" _
		( _
			byval show_summary as __boolean = __true, _
			byval verbose as __boolean = __false _
		) as __boolean

	declare sub fbcu.show_results alias "fbcu_show_results_qb" _
		( _
		)

	declare function fbcu.sngIsNan alias "fbcu_sngIsNan_qb_" _
		( _
			byval a as single _
		) as __boolean

	declare function fbcu.sngIsInf alias "fbcu_sngIsInf_qb_" _
		( _
			byval a as single _
		) as __boolean

	declare function fbcu.sngULP alias "fbcu_sngULP_qb_" _
		( _
			byval a as single _
		) as single

	declare function fbcu.sngULPdiff alias "fbcu_sngULPdiff_qb_" _
		( _
			byval a as single, _
			byval b as single _
		) as long

	declare function fbcu.sngApprox alias "fbcu_sngApprox_qb_" _
		( _
			byval a as single, _
			byval b as single, _
			byval ulps as long = 1 _
		) as __boolean

	declare function fbcu.dblIsNan alias "fbcu_dblIsNan_qb_" _
		( _
			byval a as double _
		) as __boolean

	declare function fbcu.dblIsInf alias "fbcu_dblIsInf_qb_" _
		( _
			byval a as double _
		) as __boolean

	declare function fbcu.dblULP alias "fbcu_dblULP_qb_" _
		( _
			byval a as double _
		) as double

	declare function fbcu.dblULPdiff alias "fbcu_dblULPdiff_qb_" _
		( _
			byval a as double, _
			byval b as double _
		) as __longint

	declare function fbcu.dblApprox alias "fbcu_dblApprox_qb_" _
		( _
			byval a as double, _
			byval b as double, _
			byval ulps as __longint = 1 _
		) as __boolean

	declare sub fbcu.CU_ASSERT_ alias "fbcu_CU_ASSERT_qb_" _
		( _
			byval value as __boolean, _
			byval fil as __zstring __ptr, _
			byval lin as long, _
			byval fun as __zstring __ptr, _
			byval msg as __zstring __ptr _
		)

	declare sub fbcu.CU_ASSERT_FATAL_ alias "fbcu_CU_ASSERT_FATAL_qb_" _
		( _
			byval value as __boolean, _
			byval fil as __zstring __ptr, _
			byval lin as long, _
			byval fun as __zstring __ptr, _
			byval msg as __zstring __ptr _
		)

#endif '' ( __FB_LANG__ = "qb" )


/'----------------------------------
| fbcunit api for -lang fb, fblite |
----------------------------------'/

#if( __FB_LANG__ <> "qb" )

namespace fbcu

	declare function find_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL _
		) as long

	declare sub add_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL, _
			byval init_proc as function cdecl ( ) as long = FBCU_NULL, _
			byval term_proc as function cdecl ( ) as long = FBCU_NULL _
		)

	declare function get_suite_name _
		( _
		) as const zstring ptr

	declare sub add_test _
		( _
			byval suite_name as zstring ptr = FBCU_NULL, _
			byval test_name as zstring ptr = FBCU_NULL, _
			byval test_proc as sub cdecl ( ) = FBCU_NULL, _
			byval is_global as boolean = false _
		)

	declare function check_internal_state _
		( _
		) as boolean

	declare function write_report_xml _
		( _
			byval filename as const zstring ptr _
		) as boolean

	declare sub setBriefSummary _
		( _
			byval briefSummary as boolean _
		)

	declare sub setHideCases _
		( _
			byval hideCases as boolean _
		)

	declare function getHideCases _
		( _
		) as boolean

	declare sub setShowConsole _
		( _
			byval showConsole as boolean _
		)

	declare function getShowConsole _
		( _
		) as boolean

	declare sub outputConsoleString _
		( _
			byref s as const string = "" _
		)

	declare function run_tests _
		( _
			byval show_summary as boolean = true, _
			byval verbose as boolean = false _
		) as boolean

	declare sub show_results _
		( _
		)

	declare function sngIsNan _
		( _
			byval a as single _
		) as boolean

	declare function sngIsInf _
		( _
			byval a as single _
		) as boolean

	declare function sngULP _
		( _
			byval a as single _
		) as single

	declare function sngULPdiff _
		( _
			byval a as single, _
			byval b as single _
		) as long

	declare function sngApprox _
		( _
			byval a as single, _
			byval b as single, _
			byval ulps as long = 1 _
		) as boolean

	declare function dblIsNan _
		( _
			byval a as double _
		) as boolean

	declare function dblIsInf _
		( _
			byval a as double _
		) as boolean

	declare function dblULP _
		( _
			byval a as double _
		) as double

	declare function dblULPdiff _
		( _
			byval a as double, _
			byval b as double _
		) as longint

	declare function dblApprox _
		( _
			byval a as double, _
			byval b as double, _
			byval ulps as longint = 1 _
		) as boolean

	declare sub CU_ASSERT_ _
		( _
			byval value as boolean, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

	declare sub CU_ASSERT_FATAL_ _
		( _
			byval value as boolean, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

end namespace

#endif '' ( __FB_LANG__ <> "qb" )

#endif
