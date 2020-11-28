''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''  License: GNU Lesser General Public License 
''           version 2.1 (or any later version) plus
''           linking exception, see license.txt

'' fbcunit wrapper for #lang qb mode

#include once "fbcunit.bi"

'' chng: written [jeffm]

''
function fbcu_find_suite_qb alias "fbcu_find_suite_qb" _
	( _
		byval suite_name as zstring ptr = FBCU_NULL _
	) as long

	function = fbcu.find_suite( suite_name )

end function

''
sub fbcu_add_suite_qb alias "fbcu_add_suite_qb" _
	( _
		byval suite_name as zstring ptr = FBCU_NULL, _
		byval init_proc as function cdecl ( ) as long = FBCU_NULL, _
		byval term_proc as function cdecl ( ) as long = FBCU_NULL _
	)

	fbcu.add_suite( suite_name, init_proc, term_proc )

end sub

''
function fbcu_get_suite_name_qb alias "fbcu_get_suite_name_qb" _
	( _
	) as const zstring ptr

	function = fbcu.get_suite_name()

end function

''
sub fbcu_add_test_qb alias "fbcu_add_test_qb" _
	( _
		byval suite_name as zstring ptr = FBCU_NULL, _
		byval test_name as zstring ptr = FBCU_NULL, _
		byval test_proc as sub cdecl ( ) = FBCU_NULL, _
		byval is_global as boolean = false _
	)
	
	fbcu.add_test( suite_name, test_name, test_proc, is_global )

end sub

''
function fbcu_check_internal_state alias "fbcu_check_internal_state_qb" _
	( _
	) as boolean

	function = fbcu.check_internal_state()

end function

''
function fbcu_write_report_xml alias "fbcu_write_report_xml_qb" _
	( _
		byval filename as const zstring ptr _
	) as boolean

	function = fbcu.write_report_xml( filename )

end function

''
sub fbcu_setBriefSummary alias "fbcu_setBriefSummary_qb" _
	( _
		byval briefSummary as boolean _
	)

	fbcu.setBriefSummary( briefSummary )

end sub

''
sub fbcu_setHideCases alias "fbcu_setHideCases_qb" _
	( _
		byval hideCases as boolean _
	)

	fbcu.setHideCases( hideCases )

end sub

''
function fbcu_getHideCases alias "fbcu_getHideCases_qb" _
	( _
	) as boolean

	function = fbcu.getHideCases()

end function

''
sub fbcu_setShowConsole alias "fbcu_setShowConsole_qb" _
	( _
		byval showConsole as boolean _
	)

	fbcu.setShowConsole( showConsole )

end sub

''
function fbcu_getShowConsole alias "fbcu_getShowConsole_qb" _
	( _
	) as boolean

	function = fbcu.getShowConsole()

end function

''
sub fbcu_outoutConsoleString alias "fbcu_outputConsoleString_qb" _
	( _
		byref s as const string = "" _
	)

	fbcu.outputConsoleString( s )

end sub

''
function fbcu_run_tests_qb alias "fbcu_run_tests_qb" _
	( _
		byval show_summary as boolean = true, _
		byval verbose as boolean = false _
	) as boolean

	function = fbcu.run_tests( show_summary, verbose )

end function

''
sub fbcu_show_results_qb alias "fbcu_show_results_qb" _
	( _
	)

	fbcu.show_results()

end sub

''
function fbcu_sngIsNan_qb_ alias "fbcu_sngIsNan_qb_" _
	( _
		byval a as single _
	) as boolean

	function = fbcu.sngIsNan( a )

end function

''
function fbcu_sngIsInf_qb_ alias "fbcu_sngIsInf_qb_" _
	( _
		byval a as single _
	) as boolean

	function = fbcu.sngIsInf( a )

end function

''
function fbcu_sngULP_qb_ alias "fbcu_sngULP_qb_" _
	( _
		byval a as single _
	) as long

	function = fbcu.sngULP( a )

end function

''
function fbcu_sngULPdiff_qb_ alias "fbcu_sngULPdiff_qb_" _
	( _
		byval a as single, _
		byval b as single _
	) as long

	function = fbcu.sngULPdiff( a, b )

end function

''
function fbcu_sngApprox_qb_ alias "fbcu_sngApprox_qb_" _
	( _
		byval a as single, _
		byval b as single, _
		byval ulps as long = 1 _
	) as boolean

	function = fbcu.sngApprox( a, b, ulps )

end function

''
function fbcu_dblIsNan_qb_ alias "fbcu_dblIsNan_qb_" _
	( _
		byval a as double _
	) as boolean

	function = fbcu.dblIsNan( a )

end function

''
function fbcu_dblIsInf_qb_ alias "fbcu_dblIsInf_qb_" _
	( _
		byval a as double _
	) as boolean

	function = fbcu.dblIsInf( a )

end function

''
function fbcu_dblULP_qb_ alias "fbcu_dblULP_qb_" _
	( _
		byval a as double _
	) as longint

	function = fbcu.dblULP( a )

end function

''
function fbcu_dblULPdiff_qb_ alias "fbcu_dblULPdiff_qb_" _
	( _
		byval a as double, _
		byval b as double _
	) as longint

	function = fbcu.dblULPdiff( a, b )

end function

''
function fbcu_dblApprox_qb_ alias "fbcu_dblApprox_qb_" _
	( _
		byval a as double, _
		byval b as double, _
		byval ulps as longint = 1 _
	) as boolean

	function = fbcu.dblApprox( a, b, ulps )

end function

''
sub fbcu_CU_ASSERT_qb_ alias "fbcu_CU_ASSERT_qb_" _
	( _
		byval value as boolean, _
		byval fil as zstring ptr, _
		byval lin as long, _
		byval fun as zstring ptr, _
		byval msg as zstring ptr _
	)

	fbcu.CU_ASSERT_( value, fil, lin, fun, msg )

end sub

''
sub fbcu_CU_ASSERT_FATAL_qb_ alias "fbcu_CU_ASSERT_FATAL_qb_" _
	( _
		byval value as boolean, _
		byval fil as zstring ptr, _
		byval lin as long, _
		byval fun as zstring ptr, _
		byval msg as zstring ptr _
	)

	fbcu.CU_ASSERT_FATAL_( value, fil, lin, fun, msg )

end sub
