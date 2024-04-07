'' examples/manual/proguide/static-lib/varZstringTest.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Static Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgStaticLibraries
'' --------

'' test program: 'varZstringTest.bas'

#include "varZstring.bi"  '' must contain also the overload Len operator declaration,
						  ''    otherwise the prebuilt-in Len operator is called and applied
						  ''    on the object variable (providing the length of its member data)
						
#inclib "varZstring"      '' one can also put this line in the 'varZstring.bi' file
						  ''   (and not in this file), but it seems a bit crooked

Print "VARIABLE",,, "|     LEN|  SIZEOF|"
Print "------------------------------------------|--------|--------|"

Dim As varZstring v = "FreeBASIC"  '' adjusts memory allocation to minimum
Print "varZstring v:", "'" & v & "'",, "|"; Using "########|"; Len(v); v.allocated

Dim As ZString * 256 z
z = v
Print "Zstring    z:", "'" & z & "'",, "|"; Using "########|"; Len(z); SizeOf(z)

v = z & " & SourceForge"  '' only increases memory allocation if necessazy
Print "varZstring v:", "'" & v & "'", "|"; Using "########|"; Len(v); v.allocated

v = z & " & Wiki" '' only increases memory allocation if necessazy
Print "varZstring v:", "'" & v & "'", "|"; Using "########|"; Len(v); v.allocated

v.Constructor(v)  '' readjusts memory allocation to minimum
Print "varZstring v:", "'" & v & "'", "|"; Using "########|"; Len(v); v.allocated

Sleep
		
