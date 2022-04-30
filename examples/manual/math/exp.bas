'' examples/manual/math/exp.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'EXP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgExp
'' --------

'Compute Continuous Compound Interest
Dim r As Double
Dim p As Double
Dim t As Double
Dim a As Double

Input "Please enter the initial investment (principal amount): "; p
Input "Please enter the annual interest rate (as a decimal): "; r
Input "Please enter the number of years to invest: "; t

a = p * Exp ( r * t )
Print ""
Print "After";t;" years, at an interest rate of"; r * 100; "%, your initial investment of"; p; " would be worth";a
