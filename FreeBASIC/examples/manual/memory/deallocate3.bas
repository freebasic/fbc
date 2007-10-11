'' examples/manual/memory/deallocate3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeallocate
'' --------

Function createInteger() As Integer Ptr
   Return Allocate( Len( Integer ) )                     '' return pointer to newly
End Function                                             '' allocated memory

Sub destroyInteger( ByRef someIntegerPtr As Integer Ptr )
   Deallocate( someIntegerPtr )                          '' free memory back to system
   someIntegerPtr = 0                                    '' null original pointer
End Sub

Sub DeallocateExample3()
   Dim As Integer Ptr integerPtr = createInteger()       '' initialize pointer to
	                                                     '' new memory address

   *integerPtr = 420                                     '' use pointer
   Print *integerPtr

   destroyInteger( integerPtr )                          '' pass pointer by reference
   Assert( integerPtr = 0 )                              '' pointer should now be null
End Sub

   DeallocateExample3()
   End 0
