/'
	tests -- run the unit tests for libfbcunit.a

	compile all test modules with:
		$ fbc tests.bas fbcu_sanity.bas fbcu_multiple.bas fbcu_global.bas fbcu_many_tests.bas \
			fbcu_append.bas fbcu_append2.bas fbcu_float.bas fbcu_namespace.bas fbcu_default.bas \
			fbcu_order.bas \
			-i ../inc -p ../lib

	or compile just a single test module with:
		$ fbc tests.bas fbcu_sanity.bas -i ../inc -p ../lib

	and run with
		$ tests
'/

#include once "fbcunit.bi"

dim opt_help as boolean = false
dim opt_verbose as boolean = false
dim opt_show_summary as boolean = true
dim opt_brief_summary as boolean = false
dim opt_hide_cases as boolean = false
dim opt_show_console as boolean = false
dim opt_xml_report as boolean = false
dim opt_xml_filename as string = ""
dim opt_no_error as boolean = false

dim i as integer = 1

while command(i) > ""

	select case lcase(command(i))
	case "-h", "-help", "--help"
		opt_help = true

	case "-v", "--verbose"
		opt_verbose = true

	case "--no-error"
		opt_no_error = true

	case "--xml"
		i += 1
		opt_xml_report = true
		opt_xml_filename = command(i)

		if( opt_xml_filename = "" ) then
			print "expected filename after '" & command(i-1) & "'"
			end 1
		end if

	case "--no-summary"
		opt_show_summary = false

	case "--brief-summary"
		opt_brief_summary = true

	case "--hide-cases"
		opt_hide_cases = true

	case "--show-console"
		opt_show_console = true

	case else
		print "Unrecognized option '" & command(i) & "'"
		end 1

	end select

	i += 1

wend

if( opt_help ) then
	print "usage: tests [options]"
	print
	print "options:"
	print "   -h, -help, --help    show this help information"
	print "   -v, --verbose        be verbose"
	print "   --xml filename       write test results to xml format for filename"
	print "   --no-summary         don't show the summary (default is to show it)"
	print "   --no-error           don't exit with error code even if tests failed"
	print "   --brief-summary      only show failures in the summary"
	print "   --hide-cases         don't show the failed cases"
	print "   --show-console       show console output"
	print

	'' exit with an error code
	end 1
end if

dim passed as boolean = false

'' check the fbcunit internal state
'' at this point all the module constructors should have been
'' called and fbcunit should know about all the suites & tests
'' it can run

if( fbcu.check_internal_state() = false ) then
	print "tests: fbcu.check_internal_state() failed"
	end 1
end if

'' set extra options
fbcu.setBriefSummary( opt_brief_summary )
fbcu.setHideCases( opt_hide_cases )
fbcu.setShowConsole( opt_show_console )

'' run the tests
passed = fbcu.run_tests( opt_show_summary, opt_verbose )


'' write xml report
if( opt_xml_report ) then
	if( fbcu.write_report_xml( opt_xml_filename ) = false ) then
		'' even if the tests passed, but writing the report
		'' failed, end with an exit code
		end 1
	end if
end if


'' only return exit code = 0 if all tests passed and no other errors
'' or if the '--no-error' option was given, suspress the error code
if( passed or opt_no_error ) then
	end 0
end if

'' failed
end 1
