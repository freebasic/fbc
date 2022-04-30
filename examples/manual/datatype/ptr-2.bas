'' examples/manual/datatype/ptr-2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '(POINTER | PTR)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPtr
'' --------

Type mytype
	a As Integer = 12345
End Type

Dim As mytype mt

Dim As mytype Ptr pmt
pmt = @mt

Print (*pmt).a  '' or Print pmt->a

'' Output:
'' 12345
