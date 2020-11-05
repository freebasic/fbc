#ifndef __FBCUNIT_REPORT_BI_INCLUDE__
#define __FBCUNIT_REPORT_BI_INCLUDE__ 1

''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''  License: GNU Lesser General Public License 
''           version 2.1 (or any later version) plus
''           linking exception, see license.txt

#include once "fbcunit_types.bi"

namespace fbcu

	declare function report_init_file _
		( _
			byref filename as const string _
		) as boolean

	declare sub report_init_suite _
		( _
			byref suite_rec as const FBCU_SUITE _
		)

	declare sub report_init_test _
		( _
			byref suite_rec as const FBCU_SUITE, _ 
			byref test_rec as const FBCU_TEST _
		)

	declare sub report_emit_case _
		( _
			byref case_rec as const FBCU_CASE _
		)

	declare sub report_exit_test _
		( _
			byref test_rec as const FBCU_TEST _
		)

	declare sub report_exit_suite _
		( _
			byref suite_rec as const FBCU_SUITE _
		)

	declare sub report_exit_file _
		( _
		)

end namespace

#endif
