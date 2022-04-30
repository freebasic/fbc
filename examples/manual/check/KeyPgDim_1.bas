'' examples/manual/check/KeyPgDim_1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DIM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDim
'' --------

'' Variable declaration examples

'' One variable per DIM statement
Dim text As String
Dim x As Double

'' More than one variable declared, different data types
Dim k As Single, factor As Double, s As String

'' More than one variable declared, all same data types
Dim As Integer mx, my, mz ,mb

'' Variable having an initializer
Dim px As Double Ptr = @x
