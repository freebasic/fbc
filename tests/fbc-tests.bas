/' 
	fbc-tests.bas
	
	test suite main entry point 
'/

#include once "fbcunit.bi" 

dim opt_help as boolean = false
dim opt_verbose as boolean = false
dim opt_show_summary as boolean = true
dim opt_xml_report as boolean = false
dim opt_xml_filename as string = ""

dim i as integer = 1

while command(i) > ""

	select case lcase(command(i))
	case "-h", "-help", "--help"
		opt_help = true

	case "-v", "--verbose"
		opt_verbose = true

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

	case else
		print "Unrecognized option '" & command(i) & "'"
		end 1

	end select

	i += 1

wend

if( opt_help ) then
	print "usage: fbc-tests [options]"
	print
	print "options:"
	print "   -h, -help, --help    show this help information"
	print "   -v, --verbose        be verbose"
	print "   --xml filename       write test results to xml format for filename"
	print "   --no-summary         don't show the summary (default is to show it)"
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
	print "fbc-tests: fbcu.check_internal_state() failed"
	end 1
end if


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
if( passed ) then
	end 0
end if

'' failed
end 1
