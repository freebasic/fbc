'' examples/manual/memory/deallocate.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DEALLOCATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeallocate
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
	
