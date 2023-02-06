'' examples/manual/defines/fbquerysymbol.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_QUERY_SYMBOL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbquerysymbol
'' --------

#include Once "fbc-int/symbol.bi"
Using FBC

Type T
	i As Integer
End Type
Dim x As T

Print isUDT( T )       '' returns -1 (true)
Print isVariable( T )  '' returns 0 (false)
Print isUDT( x )       '' returns 0 (false)
Print isVariable( x )  '' returns -1 (true)

Sleep
