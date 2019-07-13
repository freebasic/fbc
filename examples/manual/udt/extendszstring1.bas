'' examples/manual/udt/extendszstring1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExtendsZstring
'' --------

Type myZstring Extends ZString
  Public:
	Declare Constructor (ByRef z As Const ZString = "")
	Declare Operator Cast () ByRef As Const ZString
	Declare Operator Let (ByRef z As Const ZString)
  Private:
	Dim As String s
End Type

Constructor myZstring (ByRef z As Const ZString = "")
  This.s = z
End Constructor

Operator myZstring.Cast () ByRef As Const ZString
  Return *StrPtr(This.s)
End Operator

Operator myZstring.Let (ByRef z As Const ZString)
  This.s = z
End Operator

Dim As myZstring z = "FreeBASIC"
Print "'" & z & "'"

z &= " compiler"
Print "'" & z & "'"

Sleep
