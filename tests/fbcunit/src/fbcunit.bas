''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''  License: GNU Lesser General Public License 
''           version 2.1 (or any later version) plus
''           linking exception, see license.txt

/'---------------------------------------------------------
| fbcunit - FreeBASIC Compiler Unit testing module        |
----------------------------------------------------------/

     XXX                                   
    XX    XX                               XX    XX
    XX    XX                                     XX
  XXXXXX  XXXXX    XXXX   XX  XX  XXXXX   XXX   XXXX
    XX    XX  XX  XX  XX  XX  XX  XX XXX   XX    XX
    XX    XX  XX  XX      XX  XX  XX  XX   XX    XX
    XX    XX  XX  XX  XX  XX  XX  XX  XX   XX    XX
    XX    XXXXX    XXXX    XXXX   XX  XX  XXXX   XXX

/----------------------------------------------------------
|                                                         |
---------------------------------------------------------'/

#include once "fbcunit.bi"
#include once "fbcunit_console.bi"
#include once "fbcunit_report.bi"

'' chng: written [jeffm]

'' --------------------------------------------------------

'' FBCU_SUITE_COUNT_START is a compile time option that can
'' set the starting size of the suite and test tables

#ifndef FBCU_SUITE_COUNT_START
#define FBCU_SUITE_COUNT_START 16
#elseif (FBCU_SUITE_COUNT_START <= 0)
#undef FBCU_SUITE_COUNT_START 16
#define FBCU_SUITE_COUNT_START 16
#endif

'' ------------------
'' module level stuff
'' ------------------

#include once "fbcunit_types.bi"

redim shared fbcu_suites() as FBCU_SUITE
dim shared fbcu_suites_max as integer = 0
dim shared fbcu_suites_count as integer = 0

redim shared fbcu_tests() as FBCU_TEST
dim shared fbcu_tests_max as integer = 0
dim shared fbcu_tests_count as integer = 0

redim shared fbcu_cases() as FBCU_CASE
dim shared fbcu_cases_max as integer = 0
dim shared fbcu_cases_count as integer = 0

#define INVALID_INDEX 0

dim shared fbcu_suite_default_index as integer = INVALID_INDEX
dim shared fbcu_suite_index as integer = INVALID_INDEX
dim shared fbcu_test_index as integer = INVALID_INDEX

dim shared fbcu_hide_cases as boolean = false
dim shared fbcu_show_console as boolean = false
dim shared fbcu_brief_summary as boolean = false

'' --------------------
'' console output
'' --------------------

private sub print_output( byref s as const string = "" )

	/'
		1)	the crt call to fprintf is in another module, just 
			personal preference that we don't include "crt.bi" 
			and all it's symbols in this module and keep this
			source mostly basic like

		2)	we use fprintf(stdout,...) function because
			a)	PRINT gets messed after fbgfx tests
			b)	OPEN CONS & PRINT #, need a file number.  Can't
				use FREEFILE or a fixed number, it could conflict
				with a file number in use in the tests

		3)	the output uses LF=chr(10) only.  On win 7 in a cmd
			shell, this gets translated to CRLF.
	'/

	crt_print_output( s & chr(10) )

end sub

'' --------------------
'' hash for suite names
'' --------------------

declare function hash_compute ( byval s as const zstring ptr ) as uinteger
declare sub hash_grow()
declare function hash_find ( byval s as const zstring ptr ) as integer
declare function hash_add ( byval s as const zstring ptr, byval suite_index as const integer ) as integer

'' NB: hash() table is zero based

#define INVALID_HASH_INDEX -1

redim shared hash() as integer
dim shared hash_size as integer = 0
dim shared hash_count as integer = 0

private function hash_compute ( byval s as const zstring ptr ) as uinteger
	dim index as uinteger = 0, n as integer = len( *s )
	for i as integer = 0 to n-1
		index += s[i] + ( index shl 3 )
	next i
	function = index shl 4
end function

private sub hash_grow()
	if( hash_size = 0 ) then
		hash_size = 32
	else
		hash_size *= 2
	end if
	redim hash(0 to hash_size-1) as integer
	for index as integer = 0 to hash_size-1
		hash(index) = 0
	next
	for index as integer = 1 to fbcu_suites_count
		hash_add( strptr(fbcu_suites(index).name_nocase), index )
	next 
end sub

'' returns index in to hash()
private function hash_find ( byval s as const zstring ptr ) as integer
	if( hash_size = 0 ) then
		hash_grow()
	end if
	dim index as integer = hash_compute( s ) mod hash_size
	dim start as integer = index
	while( hash(index) )
		if( *s = fbcu_suites(hash(index)).name_nocase ) then
			exit while
		end if
		index += 1
		index mod= hash_size
		if( index = start ) then
			return INVALID_HASH_INDEX
		end if
	wend
	function = index
end function

'' returns index in to hash()
private function hash_add ( byval s as const zstring ptr, byval suite_index as const integer ) as integer
	dim index as integer = hash_find( s )
	if( index <> INVALID_HASH_INDEX ) then
		if( hash(index) = INVALID_INDEX ) then
			hash(index) = suite_index
			hash_count += 1
			if( hash_count > (hash_size \ 2) ) then
				hash_grow()
				index = hash_find( s )
			end if
		end if
		function = index
	else
		function = INVALID_HASH_INDEX
	end if
end function


'' ----------------------
'' fbcunit implementation
'' ----------------------

namespace fbcu

	''
	function find_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL _
		) as long

		if( suite_name = FBCU_NULL ) then
			return INVALID_INDEX
		end if

		dim s as string = lcase( *suite_name )

		dim index as integer = hash_find(strptr(s))
		if( index <> INVALID_HASH_INDEX ) then
			function = hash(index)
		else
			function = INVALID_INDEX
		end if

	end function

	''
	sub add_suite _
		( _
			byval suite_name as zstring ptr = FBCU_NULL, _
			byval init_proc as function cdecl ( ) as long = FBCU_NULL, _
			byval term_proc as function cdecl ( ) as long = FBCU_NULL _
		)
		
		fbcu_suite_index = find_suite( suite_name )

		if( fbcu_suite_index <> INVALID_INDEX ) then
			with fbcu_suites( fbcu_suite_index )
				if( init_proc ) then
					'' !!! FIXME !!! - if suite was already added we should generate an error or keep a list of init procs
					.init_proc = init_proc
				end if
				if( term_proc ) then
					'' !!! FIXME !!! - if suite was already added we should generate an error or keep a list of cleanup procs
					.term_proc = term_proc
				end if
			end with
			exit sub
		end if

		if( fbcu_suites_max = 0 ) then
			fbcu_suites_max = FBCU_SUITE_COUNT_START
			redim fbcu_suites( 1 to fbcu_suites_max ) as FBCU_SUITE
		elseif( fbcu_suites_count >= fbcu_suites_max ) then
			fbcu_suites_max = fbcu_suites_max * 2
			redim preserve fbcu_suites( 1 to fbcu_suites_max ) as FBCU_SUITE
		end if

		fbcu_suites_count += 1
		fbcu_suite_index = fbcu_suites_count

		with fbcu_suites( fbcu_suite_index )
			if( suite_name ) then
				.name = *suite_name
			else
				.name = "fbcu_global"
			end if

			.name_nocase = lcase(.name)

			hash_add( strptr(.name_nocase), fbcu_suite_index )

			.init_proc = init_proc
			.term_proc = term_proc
			.test_count = 0
			.test_index_head = INVALID_INDEX
			.test_index_tail = INVALID_INDEX

			'' stats
			.test_fail_count = 0
			.assert_count = 0
			.assert_pass_count = 0
			.assert_fail_count = 0

		end with

	end sub

	''
	function get_suite_name _
		( _
		) as const zstring ptr

		if( fbcu_suite_index > 0 ) then
			function = strptr( fbcu_suites( fbcu_suite_index ).name )
		else
			function = FBCU_NULL
		end if

	end function

	''
	sub add_test _
		( _
			byval suite_name as zstring ptr, _
			byval test_name as zstring ptr, _
			byval test_proc as sub cdecl ( ), _
			byval is_global as boolean = false _
		)
		
		if( is_global ) then
			fbcu_suite_index = fbcu_suite_default_index
		end if
		
		fbcu_suite_index = find_suite( suite_name )

		if( fbcu_suite_index = INVALID_INDEX ) then
			add_suite( suite_name )
		end if

		if( fbcu_tests_max = 0 ) then
			fbcu_tests_max = FBCU_SUITE_COUNT_START
			redim fbcu_tests( 1 to fbcu_tests_max ) as FBCU_TEST
		elseif( fbcu_tests_count >= fbcu_tests_max ) then
			fbcu_tests_max = fbcu_tests_max * 2
			redim preserve fbcu_tests( 1 to fbcu_tests_max ) as FBCU_TEST
		end if
			
		fbcu_tests_count += 1
		fbcu_test_index = fbcu_tests_count

		with fbcu_suites( fbcu_suite_index )
			.test_count += 1
		end with

		with fbcu_tests( fbcu_test_index )
			if( test_name ) then
				.name = *test_name
			else
				.name = "[test*" & fbcu_test_index & "]"
			end if

			.test_proc = test_proc
			.suite_index = fbcu_suite_index
			.test_index_next = INVALID_INDEX
			.case_index_head = INVALID_INDEX
			.case_index_tail = INVALID_INDEX

			'' stats
			.assert_count = 0
			.assert_pass_count = 0
			.assert_fail_count = 0

		end with

		if( fbcu_suites( fbcu_suite_index ).test_index_head = INVALID_INDEX ) then
			fbcu_suites( fbcu_suite_index ).test_index_head = fbcu_test_index
		else
			fbcu_tests( fbcu_suites( fbcu_suite_index ).test_index_tail ).test_index_next = fbcu_test_index
		end if
		fbcu_suites( fbcu_suite_index ).test_index_tail = fbcu_test_index

		if( is_global ) then
			fbcu_suite_default_index = fbcu_suite_index
		end if

	end sub

	''
	sub add_case _
		( _
			byval value as boolean, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		if( fbcu_suite_index = INVALID_INDEX ) then	
			add_suite( )
		end if

		if( fbcu_test_index = INVALID_INDEX ) then	
			add_test( )
		end if

		'' increment assertions for current suite
		fbcu_suites( fbcu_suite_index ).assert_count += 1

		'' increment assertions for current test
		fbcu_tests( fbcu_test_index ).assert_count += 1

		'' pass
		if( value ) then
			'' increment pass for current suite
			fbcu_suites( fbcu_suite_index ).assert_pass_count += 1
			fbcu_tests( fbcu_test_index ).assert_pass_count += 1

		'' fail
		else
			'' increment fail for current suite
			fbcu_suites( fbcu_suite_index ).assert_fail_count += 1

			if( fbcu_tests( fbcu_test_index ).assert_fail_count = 0 ) then
				fbcu_suites( fbcu_suite_index ).test_fail_count += 1
			end if

			fbcu_tests( fbcu_test_index ).assert_fail_count += 1

			if( fbcu_cases_max = 0 ) then
				fbcu_cases_max = FBCU_SUITE_COUNT_START
				redim fbcu_cases( 1 to fbcu_cases_max ) as FBCU_CASE
			elseif( fbcu_cases_count >= fbcu_cases_max ) then
				fbcu_cases_max = fbcu_cases_max * 2
				redim preserve fbcu_cases( 1 to fbcu_cases_max ) as FBCU_CASE
			end if

			fbcu_cases_count += 1

			with fbcu_cases( fbcu_cases_count)
				.text = *msg
				.file = *fil
				.line = lin
				.case_index_next = 0
			end with

			if( fbcu_tests( fbcu_test_index ).case_index_head = INVALID_INDEX ) then
				fbcu_tests( fbcu_test_index ).case_index_head = fbcu_cases_count
			else
				fbcu_cases( fbcu_tests( fbcu_test_index ).case_index_tail ).case_index_next = fbcu_cases_count
			end if
			fbcu_tests( fbcu_test_index ).case_index_tail = fbcu_cases_count

		end if

	end sub

	''
	private function ljust( byref v as const string, byval w as const integer ) as string
		function = left( v & string( w, asc( " " )), w )
	end function

	''
	private function rjust( byref v as const string, byval w as const integer ) as string
		function = right( string( w, asc( " " )) & v, w )
	end function

	''
	function check_internal_state _
		( _
		) as boolean

		dim failed as boolean = false

		const msg_prefix = "FBCUNIT CHECK_INTERNAL_STATE: "

		if(( fbcu_suites_count = 0 ) andalso ( fbcu_tests_count = 0 )) then
			'' no suites or tests
			return true
		end if

		'' verify that suites have valid hash table entries
		if( fbcu_suites_count > 0 ) then

			'' test that every suite has a valid hash table entry

			for suite_index as integer = 1 to fbcu_suites_count
				dim index as integer = hash_find( strptr( fbcu_suites(suite_index).name_nocase ) )
				if( index <> INVALID_HASH_INDEX ) then
					if( hash(index) = INVALID_INDEX ) then
						print_output( msg_prefix & "suite entry '" & fbcu_suites(suite_index).name & "' does not have hash table entry" )
						failed = true
					elseif( hash(index) <> suite_index ) then
						print_output( msg_prefix & "suite entry '" & fbcu_suites(suite_index).name & "' does not match hash table entry" )
						failed = true
					end if
				end if
			next

		end if

		'' verify that every test is reachable by following the singly linked lists
		if( fbcu_tests_count > 0 ) then

			dim test_suite_index(1 to fbcu_tests_count) as integer
			for fbcu_tests_count as integer = 1 to fbcu_tests_count
				test_suite_index(fbcu_tests_count) = INVALID_INDEX
			next

			for suite_index as integer = 1 to fbcu_suites_count

				dim test_index as integer = fbcu_suites( suite_index ).test_index_head

				while( test_index <> INVALID_INDEX )

					'' already linked?
					if( test_suite_index( test_index ) <> INVALID_INDEX ) then
						print_output( msg_prefix & "test " & fbcu_suites(suite_index).name & "." & fbcu_tests(test_index).name & " is duplicated" )
						failed = true
					end if

					test_suite_index( test_index ) = suite_index
					test_index = fbcu_tests( test_index ).test_index_next
				wend

			next

			'' no link at all?
			for test_index as integer = 1 to fbcu_tests_count
				if( test_suite_index( test_index ) = INVALID_INDEX ) then
					print_output( msg_prefix & "test " & fbcu_tests(test_index).name & " not reachable" )
					failed = true
				end if
			next

		end if

		function = not failed

	end function

	''
	function write_report_xml _
		( _ 
			byval filename as const zstring ptr _
		) as boolean

		if( filename = FBCU_NULL ) then
			return false
		end if

		if( fbcu.report_init_file( *filename ) = false ) then
			return false
		end if

		for suite_index as integer = 1 to fbcu_suites_count
			report_init_suite( fbcu_suites( suite_index ) )
			dim test_index as integer = fbcu_suites( suite_index ).test_index_head
			while( test_index <> INVALID_INDEX )
				report_init_test( fbcu_suites( suite_index ), fbcu_tests( test_index ) )
				dim case_index as integer = fbcu_tests( test_index ).case_index_head
				while( case_index <> INVALID_INDEX )
					report_emit_case( fbcu_cases( case_index ) )
					case_index = fbcu_cases( case_index ).case_index_next
				wend
				report_exit_test( fbcu_tests( test_index ) )
				test_index = fbcu_tests( test_index ).test_index_next
			wend
			fbcu.report_exit_suite( fbcu_suites( suite_index ) )
		next

		fbcu.report_exit_file()

		return true

	end function

	''
	sub setBriefSummary _
		( _
			byval briefSummary as boolean _
		)
		fbcu_brief_summary = briefSummary
	end sub

	''
	sub setHideCases _
		( _
			byval hideCases as boolean _
		)
		fbcu_hide_cases = hideCases
	end sub

	''
	function getHideCases _
		( _
		) as boolean
		function = fbcu_hide_cases
	end function

	''
	sub setShowConsole _
		( _
			byval showConsole as boolean _
		)
		fbcu_show_console = showConsole
	end sub

	''
	function getShowConsole _
		( _
		) as boolean
		function = fbcu_show_console
	end function

	''
	sub outputConsoleString _
		( _
			byref s as const string = "" _
		)
		if( fbcu_show_console ) then
			print_output( s )
		end if
	end sub

	''
	function run_tests _
		( _
			byval show_summary as boolean = true, _
			byval verbose as boolean = false _
		) as boolean

		dim failed as boolean = false

		function = false

		if( verbose ) then
			print_output( string( 78, "-" ) )
			print_output( date() & " " & time() )
			print_output( )
			print_output( "TESTS" )
			print_output( )
		end if

		for fbcu_suite_index = 1 to fbcu_suites_count

			dim dotests as boolean = false

			with fbcu_suites( fbcu_suite_index )

				if( verbose ) then
					print_output( "  " & .name )
				end if

				'' reset stats
				.test_fail_count = 0
				.assert_count = 0
				.assert_pass_count = 0
				.assert_fail_count = 0

				if( .init_proc ) then
					'' init proc should return 0 on success
					if( .init_proc() = 0 ) then
						dotests = true
					else
						print_output( "      " & .name & " init procedure failed" )
						failed = true
					end if
				else
					dotests = true
				end if

				if( dotests ) then

					fbcu_test_index = .test_index_head

					while( fbcu_test_index <> INVALID_INDEX )

						with fbcu_tests( fbcu_test_index )

							'' reset stats							
							.assert_count = 0
							.assert_pass_count = 0
							.assert_fail_count = 0

							if( .suite_index = fbcu_suite_index ) then

								if( verbose ) then
									print_output( "    " & .name )
								end if

								if( .test_proc ) then
									.test_proc()
								else
									failed = true
								end if
							end if

							fbcu_test_index = .test_index_next

							if( .assert_pass_count <> .assert_count ) then
								failed = true
							end if

						end with

					wend

				end if

				if( .term_proc ) then
					'' exit proc should return non-zero on failure
					if( .term_proc() <> 0 ) then
						print_output( "      " & .name & " cleanup procedure failed" )
						failed = true
					end if
				end if

			end with

		next

		function = not failed

		if( show_summary ) then
			show_results()
		end if

	end function

	''
	sub show_results _
		( _
		)

		dim t_assert_count as integer = 0
		dim t_assert_pass_count as integer = 0
		dim t_assert_fail_count as integer = 0
		dim t_test_count as integer = 0
		dim t_test_fail_count as integer = 0

		dim x as string = ""

		print_output( )
		if( fbcu_brief_summary ) then
			print_output( "SUMMARY (brief: failures only)" )
		else
			print_output( "SUMMARY" )
		end if
		print_output( )
		print_output( " Asserts    Passed    Failed  Suite                                      Tests" )
		print_output( "--------  --------  --------  --------------------------------------  --------" )

		for fbcu_suite_index as integer = 1 to fbcu_suites_count

			with fbcu_suites( fbcu_suite_index )

				t_test_count += .test_count
				t_assert_count += .assert_count
				t_assert_pass_count += .assert_pass_count
				t_assert_fail_count += .assert_fail_count
				t_test_fail_count += .test_fail_count

				'' brief summary? only show non-zero results
				if( fbcu_brief_summary ) then
					if( ( .assert_fail_count = 0) and (.test_fail_count = 0) ) then
						continue for
					end if
				end if

				x = ""
				x &= rjust( "" & .assert_count, 8 )
				x &= "  "
				x &= rjust( "" & .assert_pass_count, 8 )
				x &= "  "
				x &= rjust( "" & .assert_fail_count, 8 )
				x &= "  "
				x &= ljust( "" & .name, 38 )
				x &= "  "
				x &= rjust( "" & .test_count, 8 )

				print_output( x )

			end with

		next 

		print_output( "--------  --------  --------  --------------------------------------  --------" )

		x = ""
		x &= rjust( "" & t_assert_count, 8 )
		x &= "  "
		x &= rjust( "" & t_assert_pass_count, 8 )
		x &= "  "
		x &= rjust( "" & t_assert_fail_count, 8 )
		x &= "  "
		x &= ljust( "Total", 38 )
		x &= "  "
		x &= rjust( "" & t_test_count, 8 )

		print_output( x )
		print_output( )

	end sub

	''
	function sngIsNan _
		( _
			byval a as single _
		) as boolean

		dim ia as long = *cast( long ptr, @a )

		'' NAN = exponent all 1's and mantissa not zero
		return cbool( ((ia and &h7f800000) = &h7f800000 ) _
			  andalso ((ia and &h007fffff) <> 0) )

	end function

	''
	function sngIsInf _
		( _
			byval a as single _
		) as boolean

		dim ia as long = *cast( long ptr, @a )

		'' INF = exponent all 1's and mantissa zero
		return cbool( ((ia and &h7f800000) = &h7f800000 ) _
			  andalso ((ia and &h007fffff) = 0) )

	end function

	''
	function sngULP _
		( _
			byval a as single _
		) as single

		if( sngIsNan(a) orelse sngIsInf(a) ) then
			return a
		end if

		dim ia as long = *cast( long ptr, @a )
		ia -= 1

		return a - *cast( single ptr, @ia )
		
	end function

	''
	function sngULPdiff _
		( _
			byval a as single, _
			byval b as single _
		) as long

		dim ia as long = *cast( long ptr, @a )
		dim ib as long = *cast( long ptr, @b )

		if( sngIsNan(a) ) then
			return &h7fffffff
		end if

		if( sngIsNan(b) ) then
			return &h7fffffff
		end if

		'' signs different?
		if( (ia and &h80000000) <> (ib and &h80000000) ) then

			'' compare -0 and +0
			if( a = b ) then
				return 0
			end if

			'' assume big diff
			return &h7fffffff
		
		end if
			
		'' signs are the same, return |ia-ib|
		ia and= &h7fffffff
		ib and= &h7fffffff
		return iif( ia>ib, ia-ib, ib-ia )

	end function

	''
	function sngApprox _
		( _
			byval a as single, _
			byval b as single, _
			byval ulps as long = 1 _
		) as boolean

		function = cbool( sngULPdiff(a, b) <= ulps )

	end function

	''
	function dblIsNan _
		( _
			byval a as double _
		) as boolean

		dim ia as longint = *cast( longint ptr, @a )

		'' NAN = exponent all 1's and mantissa not zero
		return cbool( ((ia and &h7ff0000000000000ll) = &h7ff0000000000000ll ) _
			  andalso ((ia and &h000fffffffffffffll) <> 0ll) )

	end function

	''
	function dblIsInf _
		( _
			byval a as double _
		) as boolean

		dim ia as longint = *cast( longint ptr, @a )

		'' INF = exponent all 1's and mantissa zero
		return cbool( ((ia and &h7ff0000000000000ll) = &h7ff0000000000000ll ) _
			  andalso ((ia and &h000fffffffffffffll) = 0ll) )

	end function

	''
	function dblULP _
		( _
			byval a as double _
		) as double

		if( dblIsNan(a) orelse dblIsInf(a) ) then
			return a
		end if

		dim ia as longint = *cast( longint ptr, @a )
		ia -= 1

		return a - *cast( double ptr, @ia )

	end function

	''
	function dblULPdiff _
		( _
			byval a as double, _
			byval b as double _
		) as longint

		dim ia as longint = *cast( longint ptr, @a )
		dim ib as longint = *cast( longint ptr, @b )

		if( dblIsNan(a) ) then
			return &h7fffffffffffffffll
		end if

		if( dblIsNan(b) ) then
			return &h7fffffffffffffffll
		end if
		
		'' signs different?
		if( (ia and &h8000000000000000ll) <> (ib and &h8000000000000000ll) ) then

			'' compare -0 and +0
			if( a = b ) then
				return 0
			end if

			'' assume big diff
			return &h7fffffffffffffffll
		
		end if
			
		'' signs are the same, return |ia-ib|
		ia and= &h7fffffffffffffffll
		ib and= &h7fffffffffffffffll
		return iif( ia>ib, ia-ib, ib-ia )

	end function

	''
	function dblApprox _
		( _
			byval a as double, _
			byval b as double, _
			byval ulps as longint = 1 _
		) as boolean

		function = cbool( dblULPdiff(a, b) <= ulps )

	end function

	''
	sub CU_ASSERT_ _
		( _
			byval value as boolean, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		if( value = false ) then
			if( not fbcu_hide_cases ) then
				print_output( "      " & *fil & "(" & lin & ") : error : " & *fun & " " & *msg )
			end if
		end if

		add_case( value, fil, lin, fun, msg )

	end sub

	''
	sub CU_ASSERT_FATAL_ _
		( _
			byval value as boolean, _
			byval fil as zstring ptr, _
			byval lin as long, _
			byval fun as zstring ptr, _
			byval msg as zstring ptr _
		)

		CU_ASSERT_( value, fil, lin, fun, msg )

		end(1)

	end sub

end namespace
