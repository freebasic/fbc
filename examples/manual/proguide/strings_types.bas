'' examples/manual/proguide/strings_types.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Strings (string, zstring, and wstring)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgStringsTypes
'' --------

Dim As String * 20 s20 = "FreeBASIC manual"

Dim As ZString * 20 z20 = "FreeBASIC manual"
Dim As ZString Ptr pz = @"FreeBASIC manual"

Dim As WString * 20 w20 = "FreeBASIC manual"
Dim As WString Ptr pw = @WStr("FreeBASIC manual")

Dim As String s = "FreeBASIC manual"

Print Using "'FIXED-LENGTH STRING * 20': ## bytes in total, ## useful characters available"; SizeOf(s20); Len(s20)
Print Using "    containing ## user characters of # byte(s) each"; IIf(InStr(s20, Chr(0)) > 0, InStr(s20, Chr(0)) - 1, Len(s20)); SizeOf(s20[0])
Print
Print Using "'FIXED-LENGTH ZSTRING * 20': ## bytes in total, ## useful characters available"; SizeOf(z20); SizeOf(z20) \ SizeOf(z20[0]) - 1
Print Using "    containing ## user characters of # byte(s) each"; Len(z20); SizeOf(Z20[0])
Print "'ZSTRING PTR': dereferencing pointer -> "; """" & *pz & """"
Print Using "    containing ## user characters of # byte(s) each"; Len(*pz); SizeOf((*pz)[0])
Print
Print Using "'FIXED-LENGTH WSTRING * 20': ## bytes in total, ## useful characters available"; SizeOf(w20); SizeOf(w20) \ SizeOf(w20[0]) - 1
Print Using "    containing ## user characters of # byte(s) each"; Len(w20); SizeOf(w20[0])
Print "'WSTRING PTR': dereferencing pointer -> "; """" & *pw & """"
Print Using "    containing ## user characters of # byte(s) each"; Len(*pw); SizeOf((*pw)[0])
Print
Type descriptor : Addr As ZString Ptr : UC As UInteger : AC As UInteger : End Type
Print Using "'STRING': ## bytes in descriptor, memory allocated for ## characters right now"; SizeOf(s); Cast(descriptor Ptr, @s)->AC
Print Using "    containing ## user characters of # byte(s) each"; Len(s); SizeOf(s[0])

Sleep
		
