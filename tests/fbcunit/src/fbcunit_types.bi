#ifndef __FBCUNIT_TYPES_BI_INCLUDE__
#define __FBCUNIT_TYPES_BI_INCLUDE__ 1

''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''  License: GNU Lesser General Public License 
''           version 2.1 (or any later version) plus
''           linking exception, see license.txt

	type FBCU_SUITE

		name as string
		name_nocase as string
		init_proc as function cdecl ( ) as long
		term_proc as function cdecl ( ) as long
		test_count as integer
		test_index_head as integer
		test_index_tail as integer
	
		'' stats
		test_fail_count as integer
		assert_count as integer
		assert_pass_count as integer
		assert_fail_count as integer

	end type

	type FBCU_TEST

		name as string
		name_nocase as string
		test_proc as sub cdecl ( )
		suite_index as integer
		test_index_next as integer
		case_index_head as integer
		case_index_tail as integer

		'' stats
		assert_count as integer
		assert_pass_count as integer
		assert_fail_count as integer

	end type

	type FBCU_CASE
		text as string
		file as string
		line as integer
		case_index_next as integer
	end type

#endif
