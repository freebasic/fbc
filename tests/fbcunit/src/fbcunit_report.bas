''  fbcunit - FreeBASIC Compiler Unit Testing Component
''	Copyright (C) 2017-2020 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''  License: GNU Lesser General Public License 
''           version 2.1 (or any later version) plus
''           linking exception, see license.txt

#include once "crt/stdio.bi"
#include once "fbcunit_report.bi"

'' chng: written [jeffm]

'' ----------------------
'' file handler
'' ----------------------

declare function report_open( byref filename as const string ) as boolean
declare function report_close() as boolean
declare function report_write( byref s as const string ) as boolean

dim shared f as FILE ptr = NULL
dim shared indent as integer = 0

''
private function report_open _
	( _
		byref filename as const string _
	) as boolean

	report_close()

	f = fopen( filename, "w" )

	function = (f <> NULL)

end function

''
private function report_close _
	( _
	) as boolean

	if( f ) then
		function = (0 = fclose( f ))
	else
		function = true
	end if

end function

''
private function report_write _
	( _
		byref s as const string _
	) as boolean

	if( f ) then
		fprintf( f, space(indent) & "%s", strptr(s) )
	else
		function = false
	end if
end function

''
private sub report_indent ()
	indent += 4
end sub

''
private sub report_outdent ()
	if( indent >= 4 ) then
		indent -= 4
	end if
end sub

'' ----------------------
'' report implementation
'' ----------------------

''
private function strip_trailing_underscore _
	( _
		byref d as const string _
	) as string

	'' replace "_." with "."
	'' replace "_" + EOL' with EOL

	dim ret as string = ""
	dim n as integer = len(d)

	for i as integer = 1 to n
		dim ch as string = mid(d,i,1)
		if( ch = "_" ) then
			if( i = n ) then
				continue for
			elseif( mid(d,i+1,1) = "." ) then
				continue for
			end if
		end if
		ret &= ch
	next

	function = ret

end function

''
private function escape_xml _
	( _
		byref d as const string _
	) as string

	dim ret as string = ""
	for i as integer = 1 to len(d)
		select case mid(d,i,1)
		case """"
			ret &= "&quot;"
		case "'"
			ret &= "&apos;"
		case "<"
			ret &= "&lt;"
		case ">"
			ret &= "&gt;"
		case "&"
			ret &= "&amp;"
		case else
			ret &= mid(d,i,1)
		end select
	next

	function = ret

end function

''
private function convert_name _
	( _
		byref d as const string _
	) as string

	function = escape_xml( strip_trailing_underscore( d ) )

end function

''
namespace fbcu

	''
	function report_init_file _
		( _
			byref filename as const string _
		) as boolean

		if( filename > "" ) then
			if( report_open( filename ) ) then
				report_write( !"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" )
				report_write( !"<testsuites>\n" )
				report_indent()
				return true
			end if
		end if

		return false
	end function

	''
	sub report_init_suite _
		( _
			byref suite_rec as const FBCU_SUITE _
		)

		dim x as string

		with suite_rec

			x = "name=""" & convert_name ( .name ) & """"
			x &= " errors=""" & 0 & """"
			x &= " tests=""" & .test_count & """"
			x &= " failures=""" & .test_fail_count & """"
			x &= " time=""" & 0 & """"

			if( .test_count = 0 ) then
				report_write( "<testsuite " & x & !" />\n" )
			else
				report_write( "<testsuite " & x & !">\n" )
				report_indent()
			end if

		end with

	end sub

	''
	sub report_init_test _
		( _
			byref suite_rec as const FBCU_SUITE, _ 
			byref test_rec as const FBCU_TEST _
		)
		
		dim x as string

		with test_rec
				
			x = "classname=""" & convert_name( suite_rec.name ) & """"
			x &= " name=""" & convert_name ( .name ) & """"

			if( .assert_fail_count = 0 ) then
				report_write( "<testcase " & x & !" />\n" )
			else	
				report_write( "<testcase " & x & !">\n" )
				report_indent()
			end if
		end with

	end sub

	''
	sub report_emit_case _
		( _
			byref case_rec as const FBCU_CASE _
		)

		with case_rec
			report_write( "<failure message="""" type=""Failure"">" & !"\n" )
			report_indent()
			report_write( "Condition : " & escape_xml( .text ) & !"\n" )
			report_write( "File      : " & escape_xml( .file ) & !"\n" )
			report_write( "Line      : " & .line & !"\n" )
			report_outdent()
			report_write( "</failure>" & !"\n" )
		end with

	end sub

	''
	sub report_exit_test _
		( _
			byref test_rec as const FBCU_TEST _
		)

		with test_rec
			if( .assert_fail_count = 0 ) then
				'' do nothing
			else	
				report_outdent()
				report_write( !"</testcase>\n" )
			end if
		end with

	end sub

	''
	sub report_exit_suite _
		( _
			byref suite_rec as const FBCU_SUITE _
		)
		
		with suite_rec
			if( .test_count = 0 ) then
				'' do nothing
			else
				report_outdent()
				report_write( !"</testsuite>\n" )
			end if
		end with

	end sub

	''
	sub report_exit_file _
		( _
		)

		report_outdent()
		report_write( !"</testsuites>\n" )

	end sub

end namespace
