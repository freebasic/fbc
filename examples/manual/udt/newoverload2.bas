'' examples/manual/udt/newoverload2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator New Overload'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNewOverload
'' --------

Type UDTmanager
  '' user UDT fields:
	Dim As Byte b(1 To 1024*1024)
  '' manager fields:
	Public:
	  Declare Operator New[] (ByVal size As UInteger) As Any Ptr
	  Declare Operator Delete[] (ByVal buf As Any Ptr)
	  Static As UInteger maxmemory
	Private:
	  Static As Any Ptr address()
	  Static As UInteger bytes()
	  Static upbound As UInteger
	  Declare Static Function printLine (ByRef text As String, ByVal index As UInteger, ByVal sign As Integer) As UInteger
	  Declare Static Sub endProgram ()
End Type

Dim As UInteger UDTmanager.maxmemory = 3 * 1024 * 1024 * 1024
ReDim UDTmanager.address(0)
ReDim UDTmanager.bytes(0)
Dim UDTmanager.upbound As UInteger = 0

Function UDTmanager.printLine (ByRef text As String, ByVal index As UInteger, ByVal sign As Integer) As UInteger
  Dim As UInteger total = 0
  For I As UInteger = 1 To UDTmanager.upbound
	If I <> index OrElse Sgn(sign) > 0 Then
	  total += UDTmanager.bytes(I)
	End If
  Next I
  Print text, "&h" & Hex(UDTmanager.address(index), SizeOf(Any Ptr) * 2),
  If sign <> 0 Then
	Print Using " +####.## MB"; Sgn(sign) * Cast(Integer, UDTmanager.bytes(index) / 1024) / 1024;
  Else
	Print Using "( ####.## MB)"; UDTmanager.bytes(index) / 1024 / 1024;
  End If
  Print,
  Print Using "###.## GB"; total / 1024 / 1024 / 1024
  Return total
End Function

Sub UDTmanager.endProgram ()
  Do While UDTmanager.upbound > 0
	Deallocate UDTmanager.address(UDTmanager.upbound)
	UDTmanager.printLine("memory deallocation forced", UDTmanager.upbound, -1)
	UDTmanager.upbound -= 1
	ReDim Preserve UDTmanager.address(UDTmanager.upbound)
	ReDim Preserve UDTmanager.bytes(UDTmanager.upbound)
  Loop
  Print "end program forced"
  Print
  Sleep
  End
End Sub

Operator UDTmanager.New[] (ByVal size As UInteger) As Any Ptr
  Dim As Any Ptr p = Allocate(size)
  If p > 0 Then
	UDTmanager.upbound += 1
	ReDim Preserve UDTmanager.address(UDTmanager.upbound)
	ReDim Preserve UDTmanager.bytes(UDTmanager.upbound)
	UDTmanager.address(UDTmanager.upbound) = p
	UDTmanager.bytes(UDTmanager.upbound) = size
	If UDTmanager.printLine("memory allocation", UDTmanager.upbound, +1) > UDTmanager.maxmemory Then
	  UDTmanager.address(0) = p
	  UDTmanager.bytes(0) = size
	  Print
	  UDTmanager.printLine("memory allocation exceeded", 0, 0)
	  UDTmanager.endProgram()
	End If
	Return p
  Else
	UDTmanager.address(0) = p
	UDTmanager.bytes(0) = size
	Print
	UDTmanager.printLine("memory allocation failed", 0, 0)
	UDTmanager.endProgram()
  End If
End Operator

Operator UDTmanager.Delete[] (ByVal buf As Any Ptr)
  Dim As UInteger found = 0
  For I As UInteger = 1 To UDTmanager.upbound
	If UDTmanager.address(I) = buf Then
	  Deallocate buf
	  UDTmanager.printLine("memory deallocation", I, -1)
	  For J As UInteger = I + 1 To UDTmanager.upbound
		UDTmanager.address(J - 1) = UDTmanager.address(J)
		UDTmanager.bytes(J - 1) = UDTmanager.bytes(J)
	  Next J
	  UDTmanager.upbound -= 1
	  ReDim Preserve UDTmanager.address(UDTmanager.upbound)
	  ReDim Preserve UDTmanager.bytes(UDTmanager.upbound)
	  found = 1
	  Exit For
	End If
  Next I
  If found = 0 Then
	UDTmanager.address(0) = buf
	UDTmanager.bytes(0) = 0
	UDTmanager.printLine("deallocation not matching", 0, 0)
  End If
End Operator


Print "Message",, "Address" & Space(SizeOf(Any Ptr)), "Size", "Total"
Print
Randomize
Dim As UDTmanager Ptr pu1 = New UDTmanager[CUInt(Rnd() * 256 + 1)]
Dim As UDTmanager Ptr pu2 = New UDTmanager[CUInt(Rnd() * 256 + 1)]
Dim As UDTmanager Ptr pu3 = Cast(UDTmanager Ptr, 1)
Delete[] pu2
Delete[] pu3
Delete[] pu2
Delete[] pu1
Do
  Dim As UDTmanager Ptr pu = New UDTmanager[CUInt(Rnd() * 512 + 1)]
Loop
