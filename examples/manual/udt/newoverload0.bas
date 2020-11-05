'' examples/manual/udt/newoverload0.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNewOverload
'' --------

Type UDTdisplayer
  '' user UDT fields:
	Dim As Byte b(1 To 1024*1024)
  '' display fields:
	Public:
	  Declare Operator New (ByVal size As UInteger) As Any Ptr
	  Declare Operator Delete (ByVal buf As Any Ptr)
	  Declare Operator New[] (ByVal size As UInteger) As Any Ptr
	  Declare Operator Delete[] (ByVal buf As Any Ptr)
	Private:
	  Declare Static Function allocation (ByRef N As String, ByVal size As UInteger) As Any Ptr
	  Declare Static Sub deallocation (ByRef D As String, ByVal p As Any Ptr)
End Type

Operator UDTdisplayer.New (ByVal size As UInteger) As Any Ptr
  Return UDTdisplayer.allocation("New", size)
End Operator

Operator UDTdisplayer.Delete (ByVal buf As Any Ptr)
  UDTdisplayer.deallocation("Delete", buf)
End Operator

Operator UDTdisplayer.New[] (ByVal size As UInteger) As Any Ptr
  Return UDTdisplayer.allocation("New[]", size)
End Operator

Operator UDTdisplayer.Delete[] (ByVal buf As Any Ptr)
  UDTdisplayer.deallocation("Delete[]", buf)
End Operator

Function UDTdisplayer.allocation (ByRef N As String, ByVal size As UInteger) As Any Ptr
  Dim As Any Ptr p = Allocate(size)
  Print "memory allocation for " & size & " bytes from '" & N & "' at address: " & p
  Return p
End Function

Sub UDTdisplayer.deallocation (ByRef D As String, ByVal p As Any Ptr)
  Print "memory deallocation from '" & D & "' at address " & p
  Deallocate p
End Sub


Dim As UDTdisplayer Ptr pu1 = New UDTdisplayer
Dim As UDTdisplayer Ptr pu2 = New UDTdisplayer[3]
Delete pu1
Delete[] pu2

Sleep
