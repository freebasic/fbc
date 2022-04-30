'' examples/manual/udt/newoverload1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator New Overload'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNewOverload
'' --------

Const ALIGN = 256

Type UDT
  Dim As Byte a(0 To 10 * 1024 * 1024 - 1) '' 10 megabyte fixed array
  Declare Operator New (ByVal size As UInteger) As Any Ptr
  Declare Operator Delete (ByVal buffer As Any Ptr)
  Declare Constructor ()
  Declare Destructor ()
End Type

Operator UDT.New (ByVal size As UInteger) As Any Ptr
  Print "  Overloaded New operator, with parameter size = &h" & Hex(size)
  Dim pOrig As Any Ptr = CAllocate(ALIGN-1 + SizeOf(UDT Ptr) + size)
  Dim pMin As Any Ptr = pOrig + SizeOf(UDT Ptr) 
  Dim p As Any Ptr = pMin + ALIGN-1 - (CUInt(pMin + ALIGN-1) Mod ALIGN)
  Cast(Any Ptr Ptr, p)[-1] = pOrig
  Operator = p
  Print "  real pointer = &h" & Hex(pOrig), "return pointer = &h" & Hex(p)
End Operator

Operator UDT.Delete (ByVal buffer As Any Ptr)
  Print "  Overloaded Delete operator, with parameter buffer = &h" & Hex(buffer)
  Dim pOrig As Any Ptr = Cast(Any Ptr Ptr, buffer)[-1]
  Deallocate(pOrig)
  Print "  real pointer = &h" & Hex(pOrig)
End Operator

Constructor UDT ()
  Print "  Constructor, @This = &h" & Hex(@This)
End Constructor

Destructor UDT ()
  Print "  Destructor, @This = &h" & Hex(@This)
End Destructor

Print "'Dim As UDT Ptr p = New UDT'"
Dim As UDT Ptr p = New UDT

Print "  p = &h" & Hex(p)

Print "'Delete p'"
Delete p

Sleep
