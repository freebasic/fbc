'' examples/manual/udt/constructor.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CONSTRUCTOR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgConstructor
'' --------

Type sample

  _text As String

  Declare Constructor ()
  Declare Constructor ( a As Integer )
  Declare Constructor ( a As Single  ) 
  Declare Constructor ( a As String, b As Byte ) 

  Declare Operator Cast () As String

End Type

Constructor sample ()
  Print "constructor sample ()"
  Print
  this._text = "Empty"
End Constructor

Constructor sample ( a As Integer )
  Print "constructor sample ( a as integer )"
  Print "  a = "; a
  Print
  this._text = Str(a)
End Constructor

Constructor sample ( a As Single )
  Print "constructor sample ( a as single )"
  Print "  a = "; a
  Print
  this._text = Str(a)
End Constructor

Constructor sample ( a As String, b As Byte )
  Print "constructor sample ( a as string, b as byte )"
  Print "  a = "; a
  Print "  b = "; b
  Print
  this._text = Str(a) + "," + Str(b)
End Constructor

Operator sample.cast () As String
  Return this._text
End Operator

Print "Creating x1"
Dim x1 As sample

Print "Creating x2"
Dim x2 As sample = 1

Print "Creating x3"
Dim x3 As sample = 99.9

Print "Creating x4"
Dim x4 As sample = sample( "aaa", 1 )

Print "Values:"
Print "  x1 = "; x1
Print "  x2 = "; x2
Print "  x3 = "; x3
Print "  x4 = "; x4
