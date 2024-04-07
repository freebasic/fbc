'' examples/manual/libraries/gsl1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'gsl, The GNU Scientific Library'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibgsl
'' --------

'' Elementary math example
#include "gsl/gsl_math.bi"

'' Raise the value of 3.141 to the fourth power
? "3.141 ^ 4 = "; gsl_pow_4(3.141)
?

'' Find the hypotenuse of a right triangle with sides 3 and 4 
? "The hypotenuse of a right triangle with sides of length 3 and 4 is"; gsl_hypot(3,4)
?

Sleep
