''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2018 Jeffery R. Marshall (coder[at]execulink[dot]com)
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
		byval test_name as zstring ptr = FBCU_NULL, _
		byval test_proc as sub cdecl ( ) = FBCU_NULL, _
		byval is_global as boolean = false _
	)
	
	fbcu.add_test( test_name, test_proc, is_global )

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
