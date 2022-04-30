'' examples/manual/proguide/shared-lib/mydll.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

'' mydll.bas
'' compile as: fbc -dll mydll.bas
'' This will create mydll.dll (and libmydll.dll.a import library) on Windows,
'' and libmydll.so on Linux.
''
'' Note: libmydll.dll.a is an import library, it's only needed when creating 
'' an executable that calls any of mydll's functions, only distribute 
'' the DLL files with your apps, do not include the import libraries, 
'' they are useless to end-users.

'' Simple exported function; the <alias "..."> disables FB's default
'' all-upper-case name mangling, so the DLL will export AddNumbers() instead of
'' ADDNUMBERS().
Function AddNumbers Alias "AddNumbers"( ByVal a As Integer, ByVal b As Integer ) As Integer Export
	Function = a + b
End Function
