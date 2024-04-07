'' examples/manual/libraries/big_int.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'big_int'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibbigint
'' --------

#include Once "big_int/big_int_full.bi"

Sub print_num(ByVal num As big_int Ptr)
	Dim As big_int_str Ptr s = big_int_str_create(1)
	If (s = 0) Then
		Exit Sub
	End If

	If (big_int_to_str(num, 10, s) <> 0) Then
		Exit Sub
	End If

	Print *s->Str;

	big_int_str_destroy(s)
End Sub

	Dim As big_int Ptr bignum = big_int_create(1)

	big_int_from_int(2, bignum)
	big_int_pow(bignum, 65536, bignum)

	Print "2^65536 = ";
	print_num(bignum)
	Print

	big_int_destroy(bignum)
