'' examples/manual/proguide/shared-lib/load.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

'' load.bas: Loads mydll.dll (or libmydll.so) at runtime, calls one of mydll's
'' functions and prints the result. mydll is not needed at compile time.
'' compile as: fbc test.bas
''
'' Note: The compiled mydll.dll (or libmydll.so) dynamic library is expected
'' to be available in the current directory.

'' Note we specify just "mydll" as library file name; this is to ensure
'' compatibility between Windows and Linux, where a dynamic library
'' has different file name and extension.
Dim As Any Ptr libhandle = DyLibLoad( "mydll" )
If( libhandle = 0 ) Then
	Print "Failed to load the mydll dynamic library, aborting program..."
	End 1
End If

'' This function pointer will be used to call the function from mydll, after
'' the address has been found. Note: It must have the same calling
'' convention and parameters.
Dim AddNumbers As Function( ByVal As Integer, ByVal As Integer ) As Integer
AddNumbers = DyLibSymbol( libhandle, "AddNumbers" )
If( AddNumbers = 0 ) Then
	Print "Could not retrieve the AddNumbers() function's address from the mydll library, aborting program..."
	End 1
End If

Randomize Timer

Dim As Integer x = Rnd * 10
Dim As Integer y = Rnd * 10

Print x; " +"; y; " ="; AddNumbers( x, y )

'' Done with the library; the OS will automatically unload libraries loaded
'' by a process when it terminates, but we can also force unloading during
'' our program execution to save resources; this is what the next line does.
'' Remember that once you unload a previously loaded library, all the symbols
'' you got from it via dylibsymbol will become invalid, and accessing them
'' will cause the application to crash.
DyLibFree( libhandle )
