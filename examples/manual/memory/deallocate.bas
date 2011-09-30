'' examples/manual/memory/deallocate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeallocate
'' --------

Sub DeallocateExample1()
   Dim As Integer Ptr integerPtr = Allocate( Len( Integer ) )  '' initialize pointer to
	                                                           '' new memory address

   *integerPtr = 420                                     '' use pointer
   Print *integerPtr

   Deallocate( integerPtr )                              '' free memory back to system
   integerPtr = 0                                        '' and zero the pointer
End Sub

   DeallocateExample1()
   End 0
