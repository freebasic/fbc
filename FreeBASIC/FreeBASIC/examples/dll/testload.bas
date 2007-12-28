''
'' testload -- loads mydll at runtime, calls a mydll's function and prints the result
'' 
'' compile as: fbc testload.bas
''
'' note: requires the compiled mydll dynamic library to be available in current
''       directory; see mydll.bas for info on how to create this.
''

	dim library as any ptr
	dim addnumbers as function( byval operand1 as integer, byval operand2 as integer ) as integer

	'' Note we specify just "mydll" as library file name; this is to ensure
	'' compatibility between Windows and Linux, where a dynamic library
	'' has different file name and extension.
	''
	library = dylibload( "mydll" )
	if( library = 0 ) then
		print "Cannot load the mydll dynamic library, aborting program..."
		end 1
	end if
	
	addnumbers = dylibsymbol( library, "AddNumbers" )
	if( addnumbers = 0 ) then
		print "Cannot get AddNumbers function address from mydll library, aborting program..."
		end 1
	end if
	
	randomize timer
	
	dim as integer x = rnd * 10
	dim as integer y = rnd * 10
	
	print x; " +"; y; " ="; addnumbers( x, y )
	
	'' Done with the library; the OS will automatically unload libraries loaded by a process
	'' when it terminates, but we can also force unloading during our program execution to
	'' save resources; this is what the next line does. Remember that once you unload a
	'' previously loaded library, all the symbols you got from it via dylibsymbol will become
	'' invalid, and accessing them will cause the application to crash.
	''
	dylibfree library
	