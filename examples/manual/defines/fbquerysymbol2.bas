'' examples/manual/defines/fbquerysymbol2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_QUERY_SYMBOL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbquerysymbol
'' --------

#include Once "fbc-int/symbol.bi"
Using FBC

Function dataclassToStr( ByVal classid As fbc.FB_DATACLASS ) As String
	Static As ZString Ptr classnames _
		( FB_DATACLASS.FB_DATACLASS_INTEGER To FB_DATACLASS.FB_DATACLASS_UDT ) _
		= { @"integer", @"float", @"string", @"udt" }
	   
	Select Case classid
	Case LBound(classnames) To UBound(classnames)
		Return *classnames(classid)
	Case Else
		Return "*invalid*"
	End Select
End Function

#macro show_dataclass( sym )
	Scope
		Var classid = __FB_QUERY_SYMBOL__( FB_QUERY_SYMBOL.dataclass, sym )
		Print Left( "   [" & classid & "] " & dataclassToStr(classid) + Space(16), 16 ) & ": ";
		Print #sym  
	End Scope
#endmacro

Dim As Byte b
Dim As Double d
Dim As String s

Type T
	Dim As Long l
End Type
Dim As T t1

Print "EXAMPLES OF '__FB_QUERY_SYMBOL__( FB_QUERY_SYMBOL.dataclass, sym )':"

show_dataclass( b )
show_dataclass( d )
show_dataclass( s )
show_dataclass( T )
show_dataclass( T.l )
show_dataclass( t1 )
show_dataclass( t1.l )

Sleep
