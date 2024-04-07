'' examples/manual/array/ubound2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UBOUND'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

'' determining the size of an array
Dim As Short array(0 To 9)
Dim As Integer arraylen, arraysize

arraylen = UBound(array) - LBound(array) + 1
arraysize = arraylen * SizeOf( Short )

Print "Number of elements in array:", arraylen    '10
Print "Number of bytes used in array:", arraysize '10 * 2 = 20 
