'' examples/manual/control/return2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReturn
'' --------

Type rational_number                   '' simple rational number type
   numerator As Integer
   denominator As Integer
End Type

Type rational As rational_number       '' type alias for clearer code

'' multiplies two rational types (note: r1 remains unchanged due to the BYVAL option)
Function rational_multiply( r1 As rational, r2 As rational ) As rational

   r1.numerator *= r2.numerator        '' multiply the divisors ...
   r1.denominator *= r2.denominator
   Return r1                           '' ... and return the rational

End Function

Dim As rational r1 = ( 6, 105 )        '' define some rationals r1 and r2
Dim As rational r2 = ( 70, 4 )
Dim As rational r3

r3 = rational_multiply( r1, r2 )       '' multiply and store the result in r3

'' display the expression (using STR to eliminate leading space when printing numeric types)
Print Str( r1.numerator ) ; "/" ; Str( r1.denominator ) ; " * " ;
Print Str( r2.numerator ) ; "/" ; Str( r2.denominator ) ; " = " ;
Print Str( r3.numerator ) ; "/" ; Str( r3.denominator )

Sleep 
End 0
