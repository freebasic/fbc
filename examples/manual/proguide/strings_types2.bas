'' examples/manual/proguide/strings_types2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Strings (string, zstring, and wstring)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgStringsTypes
'' --------

Dim As ZString * (14+1) z = "FreeBASIC     "
Dim As ZString Ptr pz = @z

Print z
z[10] = Asc("2")
*(pz + 11) = Asc("0")                '' *(pz + 11) is converted to an Ubyte reference
(*pz)[12] = Asc("1")
pz[13] = Asc("8")                    '' pz[13] is converted to an Ubyte reference
Print z

For I As Integer = 10 To 13
	Print Str(z[I] - Asc("0"));
Next I
Print
For I As Integer = 10 To 13
	Print Str((*pz)[I] - Asc("0"));
Next I
Print
For I As Integer = 10 To 13
	Print Str(pz[I] - Asc("0"));     '' pz[I] is converted to an Ubyte reference
Next I
Print

Sleep
		
