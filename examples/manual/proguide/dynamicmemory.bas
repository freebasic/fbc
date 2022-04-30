'' examples/manual/proguide/dynamicmemory.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Dynamic memory management with FreeBASIC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDynamicMemory
'' --------

Type UDT
	Dim As String S = "FreeBASIC"              '' induce an implicit constructor and destructor
End Type

' 3 then 4 objects: Callocate, Reallocate, Deallocate, (+ .constructor + .destructor)
Dim As UDT Ptr p1 = CAllocate(3, SizeOf(UDT))  '' allocate cleared memory for 3 elements (string descriptors cleared,
											   ''     but maybe useless because of the constructor's call right behind)
For I As Integer = 0 To 2
	p1[I].Constructor()                        '' call the constructor on each element
Next I
For I As Integer = 0 To 2
	p1[I].S &= Str(I)                          '' add the element number to the string of each element
Next I
For I As Integer = 0 To 2
	Print "'" & p1[I].S & "'",                 '' print each element string
Next I
Print
p1 = Reallocate(p1, 4 * SizeOf(UDT))           '' reallocate memory for one additional element
Clear p1[3], 0, 3 * SizeOf(Integer)            '' clear the descriptor of the additional element,
											   ''     but maybe useless because of the constructor's call right behind
p1[3].Constructor()                            '' call the constructor on the additional element
p1[3].S &= Str(3)                              '' add the element number to the string of the additional element
For I As Integer = 0 To 3
	Print "'" & p1[I].S & "'",                 '' print each element string
Next I
Print
For I As Integer = 0 To 3
	p1[I].Destructor()                         '' call the destructor on each element
Next I
Deallocate(p1)                                 '' deallocate the memory
Print

' 3 objects: New, Delete
Dim As UDT Ptr p2 = New UDT[3]                 '' allocate memory and construct 3 elements
For I As Integer = 0 To 2
	p2[I].S &= Str(I)                          '' add the element number to the string of each element
Next I
For I As Integer = 0 To 2
	Print "'" & p2[I].S & "'",                 '' print each element string
Next I
Print
Delete [] p2                                   '' destroy the 3 element and deallocate the memory
Print

' 3 objects: Placement New, (+ .destructor)
ReDim As Byte array(0 To 3 * SizeOf(UDT) - 1)  '' allocate buffer for 3 elements
Dim As Any Ptr p = @array(0)
Dim As UDT Ptr p3 = New(p) UDT[3]              '' only construct the 3 elements in the buffer (placement New)
For I As Integer = 0 To 2
	p3[I].S &= Str(I)                          '' add the element number to the string of each element
Next I
For I As Integer = 0 To 2
	Print "'" & p3[I].S & "'",                 '' print each element string
Next I
Print
For I As Integer = 0 To 2
	p3[I].Destructor()                         '' call the destructor on each element
Next I
Erase array                                    '' deallocate the buffer
Print

' 3 then 4 objects: Redim, Erase
ReDim As UDT p4(0 To 2)                        '' define a dynamic array of 3 elements
For I As Integer = 0 To 2
	p4(I).S &= Str(I)                          '' add the element number to the string of each element
Next I
For I As Integer = 0 To 2
	Print "'" & p4(I).S & "'",                 '' print each element string
Next I
Print
ReDim Preserve p4(0 To 3)                      '' resize the dynamic array for one additional element
p4(3).S &= Str(3)                              '' add the element number to the string of the additional element
For I As Integer = 0 To 3
	Print "'" & p4(I).S & "'",                 '' print each element string
Next I
Print
Erase p4                                       '' erase the dynamic array
Print


Sleep
		
