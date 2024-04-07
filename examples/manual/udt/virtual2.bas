'' examples/manual/udt/virtual2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'VIRTUAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgVirtual
'' --------

'' Example with overriding destructor and
''              overriding function with covariant return


Type myBase Extends Object
  Declare Virtual Function clone () As myBase Ptr
  Declare Virtual Sub Destroy ()
End Type

Function myBase.clone () As myBase Ptr
  Dim As myBase Ptr pp = New myBase(This)
  Print "myBase.clone() As myBase Ptr", pp
  Function = pp
End Function

Sub myBase.Destroy ()
  Print "myBase.Destroy()", , @This
  Delete @This
End Sub


Type myDerived Extends myBase
  Declare Function clone () As myDerived Ptr     '' overriding member function with covariant return
  Declare Sub Destroy ()                         '' overriding member subroutine
End Type

Function myDerived.clone () As myDerived Ptr     '' overriding member function with covariant return
  Dim As myDerived Ptr pc = New myDerived(This)
  Print "myDerived.clone() As myDerived Ptr", pc
  Function = pc
End Function

Sub myDerived.Destroy ()                         '' overriding member subroutine
  Print "myDerived.Destroy()", , @This
  Delete @This
End Sub


Dim As myDerived c

Dim As myBase Ptr ppc = @c
Dim As myDerived Ptr pcc = @c

Dim As myBase Ptr ppc1 = ppc->clone()            '' using base pointers and polymorphism
Dim As myDerived Ptr pcc1 = pcc->clone()         '' using derived pointers and covariance of return value
Print
ppc1->Destroy()                                  '' using base pointer and polymorphism
pcc1->Destroy()                                  '' using derived pointer

Sleep
