'' examples/manual/defines/fbquerysymbol3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_QUERY_SYMBOL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbquerysymbol
'' --------

#include Once "fbc-int/symbol.bi"
Using FBC

Namespace NS
	Type T
		Dim As Const String Const Ptr Ptr pps
	End Type
End Namespace

#print TypeOf(NS.T.pps)

Print "type name    : " & __FB_QUOTE__( __FB_QUERY_SYMBOL__( FB_QUERY_SYMBOL.typename, NS.T.pps ) )
Print "type name id : " & __FB_QUOTE__( __FB_QUERY_SYMBOL__( FB_QUERY_SYMBOL.typenameid, NS.T.pps ) )
Print "mangled id   : " & __FB_QUOTE__( __FB_QUERY_SYMBOL__( FB_QUERY_SYMBOL.mangleid, NS.T.pps ) )

Sleep
