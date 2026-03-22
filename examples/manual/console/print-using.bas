'' examples/manual/console/print-using.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '(PRINT | ?) USING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPrintusing
'' --------

Print Using "The value is #.## seconds"; 1.019
Print Using "The ASCII code for the pound sign (_#) is ###"; Asc("#")
Print Using "The last day in the year is & \ \"; 31; "December"
Print
For exponent As Integer = 1 To 5
   Print Using "10 ^ # = ######"; exponent; 10 ^ exponent
Next exponent
