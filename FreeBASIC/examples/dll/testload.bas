''
'' testload -- loads mydll at runtime, calls a mydll's function and prints the result
'' 
'' compile as: fbc testload.bas
''
'' note: requires the compiled mydll dynamic library to be available in current
''       directory; see mydll.bas for info on how to create this.
''

	dim library as integer
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
	
	x = rnd * 10
	y = rnd * 10
	
	print x; " +"; y; " ="; addnumbers( x, y )