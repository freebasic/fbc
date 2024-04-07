'' examples/manual/check/FBArray.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FBARRAY (array descriptor structure and access)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFBArray
'' --------

#include "fbc-int/array.bi"

Sub printArrayDescriptor (ByVal p As Any Ptr, ByVal tabulation As Integer = 0, ByRef title As String = "")
	Dim As FBC.FBARRAY Ptr pd = p
	Dim As Integer t = 0
	If title <> "" Then
		Print title
		t = 1
	End If
	Print Space((t    ) * tabulation) & "[@array descriptor: @&h"; Hex(pd, 2 * SizeOf(Any Ptr)) & " / "; _
																   SizeOf(FBC.FBARRAY) - (8 - pd->dimensions) * 3 * SizeOf(Integer) & " bytes]"'
	Print Space((t + 1) * tabulation) & "@array(all_null_indexes)      =&h"; Hex(pd->index_ptr, 2 * SizeOf(Any Ptr))
	Print Space((t + 1) * tabulation) & "@array(all_min_indexes)       =&h"; Hex(pd->base_ptr, 2 * SizeOf(Any Ptr))
	Print Space((t + 1) * tabulation) & "array_total_size_in_bytes     ="; pd->size
	Print Space((t + 1) * tabulation) & "array_element_size_in_bytes   ="; pd->element_len
	Print Space((t + 1) * tabulation) & "number_of_array_dimensions    ="; pd->dimensions
	Print Space((t + 1) * tabulation) & "fixed_len/fixed_dim/dimensions="; (pd->flags And FBC.FBARRAY_FLAGS_FIXED_LEN) Shr 5 & "/"; _
																		   (pd->flags And FBC.FBARRAY_FLAGS_FIXED_DIM) Shr 4 & "/"; _
																		   (pd->flags And FBC.FBARRAY_FLAGS_DIMENSIONS)
	For i As Integer = 0 To pd->dimensions - 1
		Print Space((t + 1) * tabulation) & "[dimension number:"; i + 1; "]"
		Print Space((t + 2) * tabulation) & "number_of_elements="; pd->dimTb(i).elements
		Print Space((t + 2) * tabulation) & "min_index         ="; pd->dimTb(i).LBound
		Print Space((t + 2) * tabulation) & "max_index         ="; pd->dimTb(i).UBound
	Next i
End Sub

Screen 0
Width , 35

Dim As LongInt test1(0 To 9, 1 To 100)
printArrayDescriptor(FBC.ArrayDescriptorPtr(test1()), 4, "'Dim As Longint test1(0 to 9, 1 to 100)':")
Sleep
Cls
Dim As LongInt test2()
printArrayDescriptor(FBC.ArrayDescriptorPtr(test2()), 4, "'Dim As Longint test2()':")
Print
ReDim test2(0 To 9, 1 To 100)
printArrayDescriptor(FBC.ArrayDescriptorPtr(test2()), 4, "'Redim test2(0 to 9, 1 to 100)':")
Sleep
Cls
Dim As LongInt test3(Any, Any)
printArrayDescriptor(FBC.ArrayDescriptorPtr(test3()), 4, "'Dim As Longint test3(Any, Any)':")
Print
ReDim test3(0 To 9, 1 To 100)
printArrayDescriptor(FBC.ArrayDescriptorPtr(test3()), 4, "'Redim test3(0 to 9, 1 to 100)':")

Sleep
		
