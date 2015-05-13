''
'' Loads mydll at runtime, calls a mydll's function and prints the result
'' 
'' compile as: fbc dylib.bas
'' (mydll must be compiled first)
''

dim library as any ptr

'' Function pointer through which the function is going to be called
dim AddNumbers as function( byval a as integer, byval b as integer ) as integer

'' Note: Just "mydll" is specified as library file name, not "mydll.dll" or
'' "libmydll.so", so it works on both Windows and Linux.
library = dylibload( "mydll" )
if( library = 0 ) then
	print "Cannot load the mydll dynamic library"
	sleep
	end 1
end if

'' Here the exact function name exported by the DLL must be given:
'' If ALIAS "..." was used then it is the exact specified alias name,
'' otherwise it's the normal name but all UPPERCASED (BASIC name mangling).
'' (EXTERN ... END EXTERN blocks also change name mangling modes if used)
addnumbers = dylibsymbol( library, "AddNumbers" )
if( addnumbers = 0 ) then
	print "Could not get AddNumbers()'s address from mydll library"
	end 1
end if

randomize( timer( ) )

dim as integer x = rnd * 10
dim as integer y = rnd * 10

print x; " +"; y; " ="; AddNumbers( x, y )

'' Done with the library. The OS will automatically clean up, but we can also
'' unload earlier (before process exit) if it's no longer needed.
'' Once it's unloaded, all function pointers to it become invalid!
dylibfree library
