'' examples/manual/proguide/arrays/array.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrays
'' --------

Type arraytype As Integer

'set up bounds for a 4d array'

Const As Integer lb1 = 0, ub1 = 1, _
	             lb2 = 1, ub2 = 3, _
	             lb3 = 2, ub3 = 7, _
	             lb4 = 3, ub4 = 15

Dim As arraytype array(lb1 To ub1, _
	                   lb2 To ub2, _
	                   lb3 To ub3, _
	                   lb4 To ub4)


'Find the multiplier for each dimension in the array.
'
'The last index (mult4) doesn't need to be multiplied by anything
'
'The multiplier for the other dimensions is the product of all the sizes of
'the subsequent array dimensions
'
'mult0 is not needed (there is no 0th dimension); it just gives the number of 
'elements in the array

Const As Integer mult4 = 1
Const As Integer mult3 = (ub4 - lb4 + 1) ' * mult4
Const As Integer mult2 = (ub3 - lb3 + 1) * mult3
Const As Integer mult1 = (ub2 - lb2 + 1) * mult2
Const As Integer mult0 = (ub1 - lb1 + 1) * mult1


'get address of first element in array
Dim As arraytype Ptr arrayptr = @array(lb1, lb2, lb3, lb4)

Dim As Integer i1 = 1, i2 = 2, i3 = 3, i4 = 4

'set a value using array notation
array(i1, i2, i3, i4) = 5

'set the next contiguous value in the array
array(i1, i2, i3, i4 + 1) = 6

'calculate the pointer index of position in the array - this will automatically 
'be multiplied by the size of arraytype when you index the pointer

Dim i As Integer = (i1 - lb1) * mult1 + _
	               (i2 - lb2) * mult2 + _
	               (i3 - lb3) * mult3 + _
	               (i4 - lb4) ' * mult4


'sanity check - make sure we're not taken outside the memory of the array
Assert( (i + 1) < mult0)

'find the values we set, using pointer notation
Print arrayptr[i]
Print arrayptr[i + 1]
