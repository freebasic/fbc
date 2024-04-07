'' examples/manual/proguide/macro.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Macros'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMacros
'' --------

#define MIN(x, y) IIf( ( x ) < ( y ), x, y )      '' maximum function-like macro
#define MAX(x, y) IIf( ( x ) > ( y ), x, y )      '' minimum function-like macro
#define MUL(x, y) ( ( x ) * ( y ) )               '' multiply function-like macro

#macro REV_STR(str_dest, str_src)                 '' reverse-string sub-like macro
	For i As Integer = Len(str_src) To 1 Step -1
		str_dest &= Mid(str_src, i, 1)
	Next I
#endmacro

Print MIN(5 - 3, 1 + 2)    '' 2
Print MAX(5 - 3, 1 + 2)    '' 3
Print MUL(5 - 3, 1 + 2)^2  '' 36

Dim As String s
REV_STR(s, "CISABeerF")  '' FreeBASIC
Print s

Sleep
		
