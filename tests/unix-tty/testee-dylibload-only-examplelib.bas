'' dylibload() calls fb_hInitConsole()/fb_hExitConsole(), so we test it.

const LIBNAME = "examplelib"

dim dylib as any ptr = dylibload(LIBNAME)
if dylib = 0 then
	print "dylibload() failed, dylib " + LIBNAME + " not found"
	end 1
end if

scope
	dim get123 as function() as integer = dylibsymbol(dylib, "GET123")
	if get123 = 0 then
		print "dylibsymbol() failed, symbol GET123 not found in dylib " + LIBNAME
		end 1
	end if
	print get123(); " ";
end scope

scope
	dim print_hello as sub() = dylibsymbol(dylib, "PRINT_HELLO")
	if print_hello = 0 then
		print "dylibsymbol() failed, symbol PRINT_HELLO not found in dylib " + LIBNAME
		end 1
	end if
	print_hello()
end scope

'' No dylibfree(): The dynamic library's global dtors (including the FB runtime's one)
'' may run after those of the main program.
