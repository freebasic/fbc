'' examples/manual/memory/deallocate2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DEALLOCATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeallocate
'' --------

'' WARNING: "evil" example showing how things should NOT be done

Sub DeallocateExample2()
   Dim As Integer Ptr integerPtr = Allocate( Len( Integer ) )  
   '' initialize ^^^ pointer to new memory

   Dim As Integer Ptr anotherIntegerPtr = integerPtr
   '' initialize ^^^ another pointer to the same memory

   *anotherIntegerPtr = 69                     '' use other pointer
   Print *anotherIntegerPtr

   Deallocate( anotherIntegerPtr )             '' free memory back to system
   anotherIntegerPtr = 0                       '' and zero other pointer

'' *integerPtr = 420                           '' undefined behavior; original
											   '' pointer is invalid
End Sub

   DeallocateExample2()
   End 0
	
